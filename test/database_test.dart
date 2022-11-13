import 'package:drift/drift.dart';

part 'database_test.g.dart'; // For Generation of moor Database

// Base
class Employees extends Table {
  TextColumn get employeeID => text()();
  TextColumn get name => text().withLength(max: 100).nullable()();
  IntColumn get phoneNo => integer().nullable()();
  TextColumn get deviceID => text().nullable()();

  @override
  Set<Column> get primaryKey => {employeeID};
}

class Attendances extends Table {
  TextColumn get employeeID => text()();
  IntColumn get attendanceCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastAttendance => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {employeeID};
}

@DriftDatabase(tables: [Employees, Attendances])
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

  Future<List<Attendance>> getAllAttendances({
    String orderBy = 'last',
    String mode = 'asce',
  }) =>
      (select(attendances)
            ..orderBy(
              [
                (u) {
                  GeneratedColumn<dynamic> criteria = employees.employeeID;
                  final OrderingMode order =
                      (mode == 'desc') ? OrderingMode.desc : OrderingMode.asc;
                  if (orderBy == 'id') {
                    criteria = attendances.employeeID;
                  } else if (orderBy == 'number') {
                    criteria = attendances.attendanceCount;
                  } else if (orderBy == 'last') {
                    criteria = attendances.lastAttendance;
                  }
                  return OrderingTerm(expression: criteria, mode: order);
                }
              ],
            ))
          .get();
}
