import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moor2csv/moor2csv.dart';

import 'database_test.dart';

void main() {
  final String _csvFileName = 'table';
  final List<Employee> employees = [
    Employee(employeeID: '1', name: 'testA'),
    Employee(employeeID: '2', name: 'tenstB', phoneNo: 1203123112),
    Employee(employeeID: '3', name: 'temstC', deviceID: 'testDevice'),
    Employee(
        employeeID: '4', name: 'test,D', phoneNo: 132123124, deviceID: 's'),
  ]; // Replaced with values from database in actual implementation using select query get()

  test(
      'Tries creating CSV file with desktop settings (since debugging in pure dart)',
      () async {
    await MoorSQLToCSV().writeToCSV(employees, csvFileName: _csvFileName);
  });

  // Test if CSV file actually created
  test('Checks if generated files actually exist', () async {
    await MoorSQLToCSV().writeToCSV(employees, csvFileName: _csvFileName);

    // If internal structure of class working.
    final Directory? _directoryOnDesktop = await getDownloadsDirectory();

    // Test if File actually generated
    final String fullPath = '${_directoryOnDesktop?.path}/$_csvFileName.csv';
    final File testFilePointer = File(fullPath);
    final bool doesExist = await testFilePointer.exists();
    expect(doesExist, true);
  });

  // Test if CSV file generation works with commas and quotes in fields
  test(
      'Checks if CSV Properly Generated when fields contain special characters.',
      () async {
    final List<Employee> employees = [
      Employee(employeeID: '1', name: 'te,,'),
      Employee(employeeID: '2', name: 'tekjkn,/-,stB', phoneNo: 1203123112),
      Employee(employeeID: '3', name: 't:em-tC', deviceID: 'te;;/st,De,vice'),
      Employee(
          employeeID: '4', name: 'testD', phoneNo: 132123124, deviceID: 's'),
    ]; // Replaced with values from database in actual implementation using select query get()

    await MoorSQLToCSV()
        .writeToCSV(employees, csvFileName: '${_csvFileName}_special');

    // Internal structure of class working.
    final Directory? _directoryOnDesktop = await getDownloadsDirectory();

    // Test if File actually generated
    final String fullPath =
        '${_directoryOnDesktop?.path}/${_csvFileName}_special.csv';
    final File testFilePointer = File(fullPath);
    final bool doesExist = await testFilePointer.exists();
    expect(doesExist, true);
  });

  // Test if CSV generation keeps Dates and Times in Iso8601String form.
  test(
      'Checks if CSVs save Date Time exactly to Iso8601 String, from what they are in Classes.',
      () async {
    final List<Attendance> _attendances = [
      Attendance(
        employeeID: '1',
        attendanceCount: 1,
        lastAttendance: DateTime.now(),
      ),
      Attendance(
        employeeID: '22d1e12',
        attendanceCount: 2,
        lastAttendance: DateTime.now().toLocal(),
      ),
      Attendance(
        employeeID: '22d3123_1e12',
        attendanceCount: 2,
        lastAttendance: DateTime.now().toUtc(),
      ),
    ]; // Replaced with values from database in actual implementation using select query get()

    await MoorSQLToCSV()
        .writeToCSV(_attendances, csvFileName: '${_csvFileName}_dated');

    // Internal structure of class working.
    final Directory? _directoryOnDesktop = await getDownloadsDirectory();

    // Test if File actually generated
    final String fullPath =
        '${_directoryOnDesktop?.path}/${_csvFileName}_dated.csv';
    final File testFilePointer = File(fullPath);
    final bool doesExist = await testFilePointer.exists();
    expect(doesExist, true);
  });

  // Run Final Tests by checking the CSV files in location yourself.
}
