import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moor2csv/moor2csv.dart';

import 'database_test.dart';

void main() {
  String _csvFileName = 'table';

  List<Employee> employees = [
    Employee(employeeID: '1', name: 'testA'),
    Employee(employeeID: '2', name: 'testB', phoneNo: 1203123112),
    Employee(employeeID: '3', name: 'testC', deviceID: 'testDevice'),
    Employee(employeeID: '4', name: 'testD', phoneNo: 132123124, deviceID: 's'),
  ]; // Replaced with values from database in actual implementation using select query get()

  test(
      'Tries creating CSV file with desktop settings (since debugging in pure dart)',
      () async {
    final csvGen = MoorSQLToCSV(employees, csvFileName: _csvFileName);
    // Test if internal structure of class working.
    bool wasCreated = await csvGen.wasCreated;
    expect(wasCreated, true);
  });

  // Test if CSV file actually created
  test('Checks if generated files actually exist', () async {
    final csvGen = MoorSQLToCSV(employees, csvFileName: _csvFileName);

    // Test if internal structure of class working.
    await csvGen.wasCreated;
    Directory _directoryOnDesktop = await getDownloadsDirectory();
    String fullPath = '${_directoryOnDesktop.path}/$_csvFileName.csv';
    File testFilePointer = File(fullPath);

    bool doesExist = await testFilePointer.exists();
    expect(doesExist, true);
  });

  // Run Final Test by checking the CSV file in location yourself.
}
