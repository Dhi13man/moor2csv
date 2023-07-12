import 'dart:io';

import 'package:flutter/material.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:moor2csv/moor2csv.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;
import 'example_database.dart' as database;

Future<bool> exportDatabase(
  database.Database db, {
  bool getEmployees = true,
}) async {
  final DriftSQLToCSV _csvGenerator = DriftSQLToCSV();
  bool didSucceed = false;
  if (getEmployees) {
    final List<database.Employee> _employees =
        await db.getAllEmployees(orderBy: 'id');
    if (_employees.isNotEmpty) {
      await _csvGenerator.writeToCSV(_employees, csvFileName: 'employees');
      didSucceed = true;
    }
  }
  return didSucceed;
}

void setUpDatabaseForDesktop() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    // Change the default factory
    sql.databaseFactory = databaseFactoryFfi;
  }
}

database.Database createDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      final dataDir = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dataDir.path, 'db.sqlite'));
      return NativeDatabase(dbFile, logStatements: logStatements);
    });
    return database.Database(executor);
  }
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    final executor = LazyDatabase(() async {
      final dbFolder = await getDatabasesPath();
      final file = File(p.join(dbFolder, 'db.sqlite'));
      return NativeDatabase(file);
    });
    return database.Database(executor);
  }
  return database.Database(NativeDatabase.memory(logStatements: logStatements));
}

main() async {
  setUpDatabaseForDesktop();
  database.Database db = createDb();
  // Insert something into the Database here.
  exportDatabase(db);
}
