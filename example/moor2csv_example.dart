import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart' show getDatabasesPath;
import 'package:path/path.dart' as p;
import 'database_test.dart';

import 'package:moor2csv/moor2csv.dart';

Future<bool> exportDatabase(Database db, {bool getEmployees = true}) async {
  MoorSQLToCSV _csvGenerator;
  bool didSucceed = true;
  if (getEmployees) {
    List<Employee> _employees = await db.getAllEmployees(orderBy: 'id');
    if (_employees.isNotEmpty) {
      _csvGenerator = MoorSQLToCSV(_employees, csvFileName: 'employees');
      didSucceed = didSucceed && await _csvGenerator.wasCreated;
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

Database createDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      final dataDir = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dataDir.path, 'db.sqlite'));
      return VmDatabase(dbFile, logStatements: logStatements);
    });
    return Database(executor);
  }
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    final executor = LazyDatabase(() async {
      final dbFolder = await getDatabasesPath();
      final file = File(p.join(dbFolder, 'db.sqlite'));
      return VmDatabase(file);
    });
    return Database(executor);
  }
  return Database(VmDatabase.memory(logStatements: logStatements));
}

main() async {
  setUpDatabaseForDesktop();
  Database db = createDb();
  // Insert something into the Database here.
  exportDatabase(db);
}
