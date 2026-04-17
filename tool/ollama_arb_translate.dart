// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

/// Translates string entries from [en.arb] into a target locale file using a local Ollama model.
///
/// - Copies `@@locale` and any `@…` metadata blocks verbatim from English.
/// - Batches leaf string keys and asks the model for a JSON object mapping keys → translated text.
Future<void> runOllamaArbTranslate({
  required String projectRoot,
  required Map<String, String> env,
  required List<String> forwarded,
}) async {
  final baseUrl = (env['OLLAMA_BASE_URL'] ?? 'http://127.0.0.1:11434').trim();
  final model = (env['OLLAMA_MODEL'] ?? 'llama3.2').trim();
  final systemPrompt = (env['OLLAMA_SYSTEM'] ?? _defaultSystemPrompt).trim();
  final maxBatchChars = int.tryParse(env['OLLAMA_MAX_BATCH_CHARS'] ?? '') ?? 6000;

  var targetLocale = env['SLANG_GPT_TARGET']?.trim() ?? 'es';
  var full = false;
  for (final a in forwarded) {
    if (a.startsWith('--target=')) {
      targetLocale = a.substring('--target='.length);
    } else if (a == '--full' || a == '-f') {
      full = true;
    }
  }
  final fullEnv = env['SLANG_GPT_FULL']?.toLowerCase();
  if (fullEnv == '1' || fullEnv == 'true' || fullEnv == 'yes') {
    full = true;
  }

  final enPath = File(p.join(projectRoot, 'lib/l10n/arb/en.arb'));
  final outPath = File(p.join(projectRoot, 'lib/l10n/arb', '$targetLocale.arb'));

  if (!enPath.existsSync()) {
    stderr.writeln('Missing ${enPath.path}');
    exit(1);
  }

  final en = jsonDecode(enPath.readAsStringSync()) as Map<String, dynamic>;
  final es = outPath.existsSync()
      ? jsonDecode(outPath.readAsStringSync()) as Map<String, dynamic>
      : <String, dynamic>{'@@locale': targetLocale};

  es['@@locale'] = targetLocale;
  _copyMetadata(en, es);

  final toTranslate = <String, String>{};
  for (final e in en.entries) {
    final k = e.key;
    if (k == '@@locale') continue;
    if (k.startsWith('@')) continue;
    if (e.value is! String) continue;
    final s = e.value as String;
    if (!full && es[k] is String && (es[k] as String).isNotEmpty) {
      continue;
    }
    toTranslate[k] = s;
  }

  if (toTranslate.isEmpty) {
    print('Nothing to translate (partial mode and target already filled).');
    await _writeArb(outPath, es);
    return;
  }

  print('Ollama: $baseUrl model=$model → ${outPath.path} (${toTranslate.length} keys, full=$full)');

  final client = http.Client();
  try {
    final batches = _batchMaps(toTranslate, maxBatchChars);
    var i = 0;
    for (final batch in batches) {
      i++;
      print('Batch $i/${batches.length} (${batch.length} keys)…');
      final translated = await _translateBatch(
        client: client,
        baseUrl: baseUrl,
        model: model,
        systemPrompt: systemPrompt,
        targetLocale: targetLocale,
        batch: batch,
      );
      translated.forEach((key, value) {
        if (batch.containsKey(key)) {
          es[key] = value;
        }
      });
    }
  } finally {
    client.close();
  }

  await _writeArb(outPath, es);
  print('Wrote ${outPath.path}');
}

Future<void> _writeArb(File path, Map<String, dynamic> map) async {
  final encoder = JsonEncoder.withIndent('  ');
  await path.writeAsString('${encoder.convert(map)}\n');
}

void _copyMetadata(Map<String, dynamic> en, Map<String, dynamic> es) {
  for (final e in en.entries) {
    final k = e.key;
    if (k.startsWith('@') && k != '@@locale') {
      es[k] = jsonDecode(jsonEncode(e.value));
    }
  }
}

List<Map<String, String>> _batchMaps(Map<String, String> m, int maxChars) {
  if (m.isEmpty) return [];
  final keys = m.keys.toList()..sort();
  final out = <Map<String, String>>[];
  var cur = <String, String>{};
  var size = 0;
  for (final k in keys) {
    final v = m[k]!;
    final add = utf8.encode(jsonEncode({k: v})).length + 2;
    if (cur.isNotEmpty && size + add > maxChars) {
      out.add(cur);
      cur = {};
      size = 0;
    }
    cur[k] = v;
    size += add;
  }
  if (cur.isNotEmpty) out.add(cur);
  return out;
}

Future<Map<String, String>> _translateBatch({
  required http.Client client,
  required String baseUrl,
  required String model,
  required String systemPrompt,
  required String targetLocale,
  required Map<String, String> batch,
}) async {
  final uri = Uri.parse(baseUrl.endsWith('/') ? '${baseUrl}api/chat' : '$baseUrl/api/chat');
  final user = StringBuffer()
    ..writeln('Translate the following JSON object values from English to ${_languageName(targetLocale)}.')
    ..writeln('Rules:')
    ..writeln('- Reply with ONE JSON object only (no markdown fences, no commentary).')
    ..writeln('- Use the same keys as input; only translate string values.')
    ..writeln('- Preserve placeholders exactly: {projectCount}, {year}, etc.')
    ..writeln('- Keep proper names (people, companies, product names) when commonly left untranslated.')
    ..writeln()
    ..writeln(jsonEncode(batch));

  final body = jsonEncode({
    'model': model,
    'stream': false,
    'messages': [
      {'role': 'system', 'content': systemPrompt},
      {'role': 'user', 'content': user.toString()},
    ],
  });

  final res = await client
      .post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
      .timeout(const Duration(minutes: 15));

  if (res.statusCode != 200) {
    stderr.writeln('Ollama HTTP ${res.statusCode}: ${res.body}');
    exit(1);
  }

  final outer = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
  final content = outer['message']?['content'];
  if (content is! String) {
    stderr.writeln('Unexpected Ollama response: $outer');
    exit(1);
  }

  final parsed = _parseJsonObject(content);
  final out = <String, String>{};
  for (final k in batch.keys) {
    final v = parsed[k];
    if (v is String) {
      out[k] = v;
    } else if (v != null) {
      out[k] = v.toString();
    } else {
      stderr.writeln('Warning: missing value for key "$k" in model output');
    }
  }
  return out;
}

Map<String, dynamic> _parseJsonObject(String raw) {
  var s = raw.trim();
  if (s.startsWith('```')) {
    final first = s.indexOf('\n');
    if (first != -1) {
      s = s.substring(first + 1);
    }
    final fence = s.lastIndexOf('```');
    if (fence != -1) {
      s = s.substring(0, fence).trim();
    }
  }
  final start = s.indexOf('{');
  final end = s.lastIndexOf('}');
  if (start == -1 || end <= start) {
    throw FormatException('No JSON object in model response: $raw');
  }
  return jsonDecode(s.substring(start, end + 1)) as Map<String, dynamic>;
}

String _languageName(String code) {
  return switch (code.toLowerCase()) {
    'es' => 'Spanish',
    'fr' => 'French',
    'de' => 'German',
    'pt' => 'Portuguese',
    'it' => 'Italian',
    _ => 'the locale $code',
  };
}

const _defaultSystemPrompt =
    'You are a professional UI translator for a software engineer portfolio website. '
    'Be concise and natural. Output only valid JSON when asked.';
