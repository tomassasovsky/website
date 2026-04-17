// Translates ARB files, then runs `dart run slang`.
//
// Providers (set `TRANSLATION_PROVIDER` in `.env`):
// - `openai` (default): [slang_gpt] → OpenAI (`OPENAI_API_KEY`). See `slang.yaml` → `gpt:`.
// - `ollama`: local HTTP API ([Ollama](https://ollama.com)) — no cloud key.
//
// Usage (from repo root):
//   dart run tool/translate_arb.dart
//   dart run tool/translate_arb.dart -- --target=es
//   dart run tool/translate_arb.dart -- --target=es --full
//
// Optional `.env` when no `--` args: `SLANG_GPT_TARGET=es`, `SLANG_GPT_FULL=true`
//
// Ollama `.env` examples:
//   TRANSLATION_PROVIDER=ollama
//   OLLAMA_BASE_URL=http://127.0.0.1:11434
//   OLLAMA_MODEL=llama3.2
//   # OLLAMA_MAX_BATCH_CHARS=6000
//   # OLLAMA_SYSTEM=...   (optional system prompt override)

import 'dart:io';

import 'package:path/path.dart' as p;

import 'ollama_arb_translate.dart';

Future<void> main(List<String> args) async {
  final projectRoot = p.normalize(
    p.join(File(Platform.script.toFilePath()).parent.path, '..'),
  );
  final envPath = File(p.join(projectRoot, '.env'));
  if (!envPath.existsSync()) {
    stderr.writeln('Missing .env at ${envPath.path}');
    exit(1);
  }

  final env = _parseEnv(envPath.readAsStringSync());
  final provider = (env['TRANSLATION_PROVIDER'] ?? 'openai').toLowerCase().trim();

  final sep = args.indexOf('--');
  final forwarded = sep >= 0 ? args.sublist(sep + 1) : <String>[];

  if (provider == 'ollama') {
    await runOllamaArbTranslate(
      projectRoot: projectRoot,
      env: env,
      forwarded: forwarded,
    );
  } else {
    final apiKey = env['OPENAI_API_KEY'] ?? env['API_KEY'];
    if (apiKey == null || apiKey.trim().isEmpty) {
      stderr.writeln(
        'Set OPENAI_API_KEY (or legacy API_KEY) in .env for OpenAI, '
        'or set TRANSLATION_PROVIDER=ollama for local Ollama.',
      );
      exit(1);
    }

    final slangGptArgs = <String>[
      'run',
      'slang_gpt',
      '--api-key=$apiKey',
    ];

    if (forwarded.isNotEmpty) {
      slangGptArgs.addAll(forwarded);
    } else {
      final target = env['SLANG_GPT_TARGET']?.trim();
      if (target != null && target.isNotEmpty) {
        slangGptArgs.add('--target=$target');
      }
      final full = env['SLANG_GPT_FULL']?.toLowerCase();
      if (full == '1' || full == 'true' || full == 'yes') {
        slangGptArgs.add('--full');
      }
    }

    stdout.writeln('Running: dart ${slangGptArgs.map(_redactKey).join(' ')}');
    stdout.writeln('(working directory: $projectRoot)\n');

    final gpt = await Process.start(
      Platform.resolvedExecutable,
      slangGptArgs,
      workingDirectory: projectRoot,
      mode: ProcessStartMode.inheritStdio,
    );
    final gptCode = await gpt.exitCode;
    if (gptCode != 0) {
      stderr.writeln('slang_gpt failed with exit code $gptCode');
      exit(gptCode);
    }
  }

  stdout.writeln('\nRunning: dart run slang\n');
  final slang = await Process.start(
    Platform.resolvedExecutable,
    const ['run', 'slang'],
    workingDirectory: projectRoot,
    mode: ProcessStartMode.inheritStdio,
  );
  final slangCode = await slang.exitCode;
  if (slangCode != 0) {
    stderr.writeln('slang failed with exit code $slangCode');
    exit(slangCode);
  }

  stdout.writeln('\nDone. ARBs updated and Dart localization regenerated.');
}

String _redactKey(String arg) {
  if (arg.startsWith('--api-key=')) {
    return '--api-key=***';
  }
  return arg;
}

Map<String, String> _parseEnv(String contents) {
  final map = <String, String>{};
  for (final line in contents.split('\n')) {
    final t = line.trim();
    if (t.isEmpty || t.startsWith('#')) continue;
    final eq = t.indexOf('=');
    if (eq <= 0) continue;
    final key = t.substring(0, eq).trim();
    var value = t.substring(eq + 1).trim();
    if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
      value = value.substring(1, value.length - 1);
    }
    // Strip ` # comment` so `KEY=value  # note` works like shell dotenv.
    final hash = value.indexOf(' #');
    if (hash != -1) {
      value = value.substring(0, hash).trim();
    }
    map[key] = value;
  }
  return map;
}
