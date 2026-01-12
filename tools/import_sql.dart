// SQL to Isar Import Tool
// Usage: dart run tools/import_sql.dart <sql-file-path>

import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart run tools/import_sql.dart <sql-file>');
    exit(1);
  }

  final sqlFile = File(args[0]);
  if (!sqlFile.existsSync()) {
    print('Error: File not found');
    exit(1);
  }

  print('Reading SQL...');
  final sql = await sqlFile.readAsString();

  print('Parsing...');
  final tickets = parseSqlToTickets(sql);
  print('Parsed ${tickets.length} tickets');

  // Generate import file
  final code = generateImportFile(tickets);
  final output = File('lib/generated_import.dart');
  await output.writeAsString(code);

  print('✓ Generated lib/generated_import.dart');
  print('');
  print('To import:');
  print('  await importTickets();');
  print('  // from lib/generated_import.dart');
}

String generateImportFile(List<Map<String, dynamic>> tickets) {
  final json = jsonEncode(tickets);
  final escaped = json.replaceAll(r'$', r'\$').replaceAll("'", r"\'");
  return """import 'dart:convert';
import 'package:tickets_app/models/ticket.dart';
import 'package:tickets_app/services/isar_service.dart';

Future<void> importTickets() async {
  final data = '$escaped';
  final list = jsonDecode(data) as List;
  final service = IsarService();

  for (final json in list) {
    final ticket = Ticket.fromJson(json);
    await service.saveTicket(ticket);
  }

  print('Imported \${list.length} tickets');
}
""";
}

List<Map<String, dynamic>> parseSqlToTickets(String sql) {
  final tickets = <Map<String, dynamic>>[];

  final columnsMatch = RegExp(r'INSERT INTO.*?\((.*?)\)', dotAll: true).firstMatch(sql);
  if (columnsMatch == null) return tickets;

  final columns = columnsMatch.group(1)!
      .split(',')
      .map((c) => c.trim().replaceAll('"', ''))
      .toList();

  final valuesMatch = RegExp(r'VALUES\s+(.*);', dotAll: true).firstMatch(sql);
  if (valuesMatch == null) return tickets;

  final rows = RegExp(r'\((.*?)\)(?:,|\s*$)', dotAll: true)
      .allMatches(valuesMatch.group(1)!);

  for (final row in rows) {
    final values = parseRowValues(row.group(1)!);
    if (values.length != columns.length) continue;

    final map = <String, dynamic>{};
    for (var i = 0; i < columns.length; i++) {
      map[columns[i]] = values[i];
    }
    tickets.add(map);
  }

  return tickets;
}

List<dynamic> parseRowValues(String content) {
  final values = <dynamic>[];
  var current = '';
  var inString = false;
  var i = 0;

  while (i < content.length) {
    final char = content[i];

    if (char == "'") {
      if (inString && i + 1 < content.length && content[i + 1] == "'") {
        current += "'";
        i += 2;
        continue;
      }
      inString = !inString;
      i++;
      continue;
    }

    if (!inString && char == ',') {
      values.add(parseValue(current.trim()));
      current = '';
      i++;
      continue;
    }

    current += char;
    i++;
  }

  if (current.isNotEmpty) {
    values.add(parseValue(current.trim()));
  }

  return values;
}

dynamic parseValue(String value) {
  value = value.trim();

  if (value == 'null' || value.isEmpty) return null;
  if (value == 'true') return true;
  if (value == 'false') return false;

  final numValue = num.tryParse(value);
  if (numValue != null) return numValue;

  if (value.startsWith('[') && value.endsWith(']')) {
    try {
      return jsonDecode(value);
    } catch (_) {}
  }

  return value;
}
