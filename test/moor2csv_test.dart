import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moor2csv/moor2csv.dart';

import 'database_test.dart';

void main() {
  String _csvFileName = 'table';

  List<Employee> employees = [
    Employee(employeeID: '1', name: 'testA'),
    Employee(employeeID: '2', name: 'tenstB', phoneNo: 1203123112),
    Employee(employeeID: '3', name: 'temstC', deviceID: 'testDevice'),
    Employee(
        employeeID: '4', name: 'test,D', phoneNo: 132123124, deviceID: 's'),
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

    // If internal structure of class working.
    await csvGen.wasCreated;
    Directory _directoryOnDesktop = await getDownloadsDirectory();
    // Test if File actually generated
    String fullPath = '${_directoryOnDesktop.path}/$_csvFileName.csv';
    File testFilePointer = File(fullPath);

    bool doesExist = await testFilePointer.exists();
    expect(doesExist, true);
  });

  // Test if CSV file generation works with commas and quotes in fields
  test(
      'Checks if CSV Properly Generated when fields contain special characters.',
      () async {
    List<Employee> employees = [
      Employee(employeeID: '1', name: 'te,,'),
      Employee(employeeID: '2', name: 'tekjkn,/-,stB', phoneNo: 1203123112),
      Employee(employeeID: '3', name: 't:em-tC', deviceID: 'te;;/st,De,vice'),
      Employee(
          employeeID: '4', name: 'testD', phoneNo: 132123124, deviceID: 's'),
    ]; // Replaced with values from database in actual implementation using select query get()

    final csvGen =
        MoorSQLToCSV(employees, csvFileName: '${_csvFileName}_special');

    // Internal structure of class working.
    await csvGen.wasCreated;
    Directory _directoryOnDesktop = await getDownloadsDirectory();
    // Test if File actually generated
    String fullPath = '${_directoryOnDesktop.path}/${_csvFileName}_special.csv';
    File testFilePointer = File(fullPath);

    bool doesExist = await testFilePointer.exists();
    expect(doesExist, true);
  });

  // Run Final Test by checking the CSV files in location yourself.
}
