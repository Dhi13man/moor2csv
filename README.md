# moor2csv

Supporting package for Moor, that allows **exporting SQL-based Moor database to a CSV form**, for external storage or sharing. Works on all platforms except Web.

**Find Package on Official Dart Pub:**

[![moor2csv version](https://img.shields.io/pub/v/moor2csv.svg)](https://pub.dev/packages/moor2csv)

----

## Usage Steps

First, perform necessary steps to provide Storage capability in the device you are developing for.
Example: Editing `android\app\src\main\AndroidManifest.xml` and [providing permissions](https://developer.android.com/about/versions/11/privacy/permissions) for Android.

1. Set up a Moor Database in your flutter project and create necessary Data Structures and tables. Example:

        import 'package:moor/moor.dart';
        import 'package:undo/undo.dart';

        // ****** Employee Data Structure for Table *****
        class Employees extends Table {
          TextColumn get employeeID => text()();
          TextColumn get name => text().withLength(max: 100).nullable()();
          IntColumn get phoneNo => integer().nullable()();
          TextColumn get deviceID => text().nullable()();
          @override
          Set<Column> get primaryKey => {employeeID};
        }


        // ****** Moor Setup ********

        part 'Database.g.dart';

        @UseMoor(tables: [Employees])
        class Database extends _$Database {
          Database(QueryExecutor e) : super(e);
          final cs = ChangeStack();

          @override
          int get schemaVersion => 1;

          Future<List<Employee>> getAllEmployees(
                    {String orderBy = 'asce', String mode = 'name'}) =>
                (select(employees)
                      ..orderBy([
                        (u) {
                          GeneratedTextColumn criteria = employees.employeeID;
                          OrderingMode order =
                              (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                          if (orderBy == 'id') criteria = employees.employeeID;
                          if (orderBy == 'name') criteria = employees.name;
                          if (orderBy == 'device') criteria = employees.deviceID;
                          return OrderingTerm(expression: criteria, mode: order);
                        }
                      ]))
                    .get();
          ...
        } db;

2. Run a query to get your `List<DataClass>` item from the Database.  
Example: `List<Employee> _employees = await db.getAllEmployees(orderBy: 'id');` in an `async` function gets us our `List<DataClass>` item from database `db`.

3. Simply Create a `MoorSQLtoCSV` object by passing in the the `List<DataClass>` object as parameter to it (and optionally the CSV file name to save it as) and it will do all the necessary work to export your Database to a CSV file. Example to store `_employees` object of type `Employee table` in `employees.csv`:

        _csvGenerator = MoorSQLToCSV(_employees, csvFileName: 'employees');

4. Optionally, access the `wasCreated` member getter of the `MoorSQLtoCSV` object to get a `Future<bool>` stating whether your CSV file was generated and the `pathToCSVDirectory` getter to get the path to the directory where the CSV file was generated, once it's been done.

5. If the Database was successfully created, you will find it in:

    a. **Android and IoS:** Your Flutter App's internal Storage directory (eg. `Android\Data\com.*.*\appName` for Android), provided the permissions were given and the CSV was succesfully generated.

    b. **Desktop Systems:** Downloads Directory.

----

## Dependencies

1. [Moor](https://pub.dev/packages/moor) (with Tables and DataClasses ready). (Moor requires dependencies like `moor_generator` and `build_runner` for full functioning. Make sure you are familiar before using this package)
2. [Path Provider](https://pub.dev/packages/path_provider): To provide paths to Download folder (in desktop) and App Internal Storage Directory (in Mobile platforms) which are the only places storage of files is allowed
3. [Permission Handler](https://pub.dev/packages/permission_handler): To provide Storage read/write permission on Mobile devices. Moor itself requires it too.
4. Also uses `dart:io` library for file handling.

## Available Methods

**1. MoorSQLToCSV (Class constuctor):** Call it with `List<DataClass>` parameter to directly generate CSV from it.

    Optional Parameter csvFileName: Provides the file name to save the generated file as (with extension .csv).

**2. wasCreated (getter):** `Future<bool>` signifying whether the file was succesfully created.

**3. pathToCSVDirectory (getter):** Gives the path to directory where generated file is stored.

## Example Usage

    Future<bool> exportDatabase(
          {bool getEmployees = true,
          bool getAttendances = true,
          bool getEvents = true}) async {
        MoorSQLToCSV _csvGenerator;
        bool didSucceed = true;
        if (getEmployees) {
          List<Employee>_employees = await db.getAllEmployees(orderBy: 'id');
          if (_employees.isNotEmpty) {
            _csvGenerator = MoorSQLToCSV(_employees, csvFileName: 'employees');
            didSucceed = didSucceed && await_csvGenerator.wasCreated;
          }
        }
        if (getAttendances) {
          List<Attendance> _attendances = await db.getAllAttendances();
          if (_attendances.isNotEmpty) {
            _csvGenerator = MoorSQLToCSV(_attendances, csvFileName: 'attendances');
            didSucceed = didSucceed && await _csvGenerator.wasCreated;
          }
        }
        if (getEvents) {
          List<Event>_events = await db.getAllEvents();
          if (_events.isNotEmpty) {
            _csvGenerator = MoorSQLToCSV(_events, csvFileName: 'events');
            didSucceed = didSucceed && await_csvGenerator.wasCreated;
          }
        }
        return didSucceed;
    }

----

## Potential Contribution Ideas

1. Implement a way to view the generated CSVs that works across platforms. Right now I can't think of any. Tested out Open package and url_launcher with failure in one or more platforms. The only way to browse the generated CSVs is to manually browse to the storage folder.

2. Better documentation.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
