import 'dart:io';

/// Merged environment: process env + values parsed from [path] (`.env` by default).
///
/// Process environment variables always win; the file only fills in missing keys.
final Map<String, String> appEnv = _buildEnv();

Map<String, String> _buildEnv([String path = '.env']) {
  final merged = <String, String>{...Platform.environment};
  final file = File(path);
  if (!file.existsSync()) return merged;

  for (var line in file.readAsLinesSync()) {
    line = line.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final idx = line.indexOf('=');
    if (idx < 0) continue;
    final key = line.substring(0, idx).trim();
    var value = line.substring(idx + 1).trim();
    if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
      value = value.substring(1, value.length - 1);
    }
    // Process env wins; only fill in what's missing.
    merged.putIfAbsent(key, () => value);
  }
  return merged;
}
