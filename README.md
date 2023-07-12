# drift2csv / moor2csv

[![License](https://img.shields.io/github/license/dhi13man/moor2csv)](https://github.com/Dhi13man/moor2csv/blob/main/LICENSE)
[![Language](https://img.shields.io/badge/language-Dart-blue.svg)](https://dart.dev)
[![Language](https://img.shields.io/badge/language-Flutter-blue.svg)](https://flutter.dev)
[![Contributors](https://img.shields.io/github/contributors-anon/dhi13man/moor2csv?style=flat)](https://github.com/Dhi13man/moor2csv/graphs/contributors)
[![GitHub forks](https://img.shields.io/github/forks/dhi13man/moor2csv?style=social)](https://github.com/Dhi13man/moor2csv/network/members)
[![GitHub Repo stars](https://img.shields.io/github/stars/dhi13man/moor2csv?style=social)](https://github.com/Dhi13man/moor2csv/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/dhi13man/moor2csv)](https://github.com/Dhi13man/moor2csv/commits/main)
[![Build, Format](https://github.com/Dhi13man/moor2csv/actions/workflows/flutter.yml/badge.svg)](https://github.com/Dhi13man/moor2csv/actions)
[![moor2csv version](https://img.shields.io/pub/v/moor2csv.svg)](https://pub.dev/packages/moor2csv)

[!["Buy Me A Coffee"](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20an%20Ego%20boost&emoji=%F0%9F%98%B3&slug=dhi13man&button_colour=FF5F5F&font_colour=ffffff&font_family=Lato&outline_colour=000000&coffee_colour=FFDD00****)](https://www.buymeacoffee.com/dhi13man)

Supporting package for SQL/Drift/Moor, that allows easily **exporting SQL-based Moor database to a CSV form**, for external storage or sharing. Works on all platforms except Web.

**Find Package on Official Dart Pub:**

[![drift2csv version](https://img.shields.io/pub/v/moor2csv.svg)](https://pub.dev/packages/moor2csv)

## Usage Steps

First, perform necessary steps to provide Storage capability in the device you are developing for.
Example: Editing `android\app\src\main\AndroidManifest.xml` and [providing permissions](https://developer.android.com/about/versions/11/privacy/permissions) for Android.

1. Set up a Moor/Drift Database in your flutter project and create necessary Data Structures and tables. Example:

    ```dart
    class Employees extends Table {
      TextColumn get employeeID => text()();
      TextColumn get name => text().withLength(max: 100).nullable()();
      IntColumn get phoneNo => integer().nullable()();
      TextColumn get deviceID => text().nullable()();

      @override
      Set<Column> get primaryKey => {employeeID};
    }

    @DriftDatabase(tables: [Employees])
    class Database extends _$Database {
      Database(QueryExecutor e) : super(e);

      @override
      int get schemaVersion => 1;

      // DATABASE OPERATIONS
      //EMPLOYEES
      Future<List<Employee>> getAllEmployees({
        String orderBy = 'asce',
        String mode = 'name',
      }) =>
          (select(employees)
                ..orderBy(
                  [
                    (u) {
                      GeneratedColumn<String?> criteria = employees.employeeID;
                      final OrderingMode order =
                          (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                      if (orderBy == 'id') {
                        criteria = employees.employeeID;
                      } else if (orderBy == 'name') {
                        criteria = employees.name;
                      } else if (orderBy == 'device') {
                        criteria = employees.deviceID;
                      }
                      return OrderingTerm(expression: criteria, mode: order);
                    }
                  ],
                ))
              .get();
    }
    ```

2. Run a query to get your `List<DataClass>` item from the Database.  
Example: `List<Employee> _employees = await db.getAllEmployees();` in an `async` function gets us our `List<DataClass>` item from database `db`.

3. Simply Create a `DriftSQLToCSV` object and then use the `writeToCSV()` method by passing in the the `List<DataClass>` object as parameter to it (and optionally the CSV file name to save it as):

    ```dart
    // Assuming Employee is a DataClass
    final List<Employee> employees = [
        Employee(employeeID: '1', name: 'testA'),
        Employee(employeeID: '2', name: 'tenstB', phoneNo: 1203123112),
        Employee(employeeID: '3', name: 'temstC', deviceID: 'testDevice'),
        Employee(
            employeeID: '4', name: 'test,D', phoneNo: 132123124, deviceID: 's'),
      ]; // Replaced with values from database in actual implementation using select query get()

    // Using DriftSQLToCSV
    final DriftSQLToCSV DriftSQLToCSV = DriftSQLToCSV();
    await DriftSQLToCSV.writeToCSV(_employees, csvFileName: 'employees');
    ```

    It will do all the necessary work to export your Database to a CSV file. Example to store `_employees` object of type `Employee table` in `employees.csv`

4. The method also returns a `Future<File>` object that can be used to perform further operations on the saved CSV.

5. If the Database was successfully created, you will find it in:

    a. **Android and IoS:** Your Flutter App's internal Storage directory (eg. `Android\Data\com.*.*\appName` for Android), provided the permissions were given and the CSV was succesfully generated.

    b. **Desktop Systems:** Downloads Directory.

## Dependencies

1. [Moor/Drift](https://drift.simonbinder.eu/) (with Tables and DataClasses ready). (Moor requires dependencies like `moor_generator` and `build_runner` for full functioning. Make sure you are familiar before using this package)
2. [Path Provider](https://pub.dev/packages/path_provider): To provide paths to Download folder (in desktop) and App Internal Storage Directory (in Mobile platforms) which are the only places storage of files is allowed
3. [Permission Handler](https://pub.dev/packages/permission_handler): To provide Storage read/write permission on Mobile devices. Moor itself requires it too.
4. Also uses `dart:io` library for file handling.

## Available Methods

**1. DriftSQLToCSV (Class constuctor):** To create a DriftSQLToCSV object.

**2. writeToCSV (Method):** To write the CSV file to the device's storage. Returns a `Future<File>` object of the CSV file created.

**3. permissionStatus / hasFileWritePermission (Getter):** To get the current permission status of the app to write to storage.

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
