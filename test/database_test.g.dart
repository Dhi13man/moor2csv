// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_test.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Employee extends DataClass implements Insertable<Employee> {
  final String employeeID;
  final String? name;
  final int? phoneNo;
  final String? deviceID;
  Employee({required this.employeeID, this.name, this.phoneNo, this.deviceID});
  factory Employee.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Employee(
      employeeID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      phoneNo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_no']),
      deviceID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}device_i_d']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_i_d'] = Variable<String>(employeeID);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || phoneNo != null) {
      map['phone_no'] = Variable<int?>(phoneNo);
    }
    if (!nullToAbsent || deviceID != null) {
      map['device_i_d'] = Variable<String?>(deviceID);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      employeeID: Value(employeeID),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phoneNo: phoneNo == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNo),
      deviceID: deviceID == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceID),
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      employeeID: serializer.fromJson<String>(json['employeeID']),
      name: serializer.fromJson<String?>(json['name']),
      phoneNo: serializer.fromJson<int?>(json['phoneNo']),
      deviceID: serializer.fromJson<String?>(json['deviceID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeID': serializer.toJson<String>(employeeID),
      'name': serializer.toJson<String?>(name),
      'phoneNo': serializer.toJson<int?>(phoneNo),
      'deviceID': serializer.toJson<String?>(deviceID),
    };
  }

  Employee copyWith(
          {String? employeeID, String? name, int? phoneNo, String? deviceID}) =>
      Employee(
        employeeID: employeeID ?? this.employeeID,
        name: name ?? this.name,
        phoneNo: phoneNo ?? this.phoneNo,
        deviceID: deviceID ?? this.deviceID,
      );
  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('employeeID: $employeeID, ')
          ..write('name: $name, ')
          ..write('phoneNo: $phoneNo, ')
          ..write('deviceID: $deviceID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeID, name, phoneNo, deviceID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.employeeID == this.employeeID &&
          other.name == this.name &&
          other.phoneNo == this.phoneNo &&
          other.deviceID == this.deviceID);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<String> employeeID;
  final Value<String?> name;
  final Value<int?> phoneNo;
  final Value<String?> deviceID;
  const EmployeesCompanion({
    this.employeeID = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNo = const Value.absent(),
    this.deviceID = const Value.absent(),
  });
  EmployeesCompanion.insert({
    required String employeeID,
    this.name = const Value.absent(),
    this.phoneNo = const Value.absent(),
    this.deviceID = const Value.absent(),
  }) : employeeID = Value(employeeID);
  static Insertable<Employee> custom({
    Expression<String>? employeeID,
    Expression<String?>? name,
    Expression<int?>? phoneNo,
    Expression<String?>? deviceID,
  }) {
    return RawValuesInsertable({
      if (employeeID != null) 'employee_i_d': employeeID,
      if (name != null) 'name': name,
      if (phoneNo != null) 'phone_no': phoneNo,
      if (deviceID != null) 'device_i_d': deviceID,
    });
  }

  EmployeesCompanion copyWith(
      {Value<String>? employeeID,
      Value<String?>? name,
      Value<int?>? phoneNo,
      Value<String?>? deviceID}) {
    return EmployeesCompanion(
      employeeID: employeeID ?? this.employeeID,
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      deviceID: deviceID ?? this.deviceID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeID.present) {
      map['employee_i_d'] = Variable<String>(employeeID.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (phoneNo.present) {
      map['phone_no'] = Variable<int?>(phoneNo.value);
    }
    if (deviceID.present) {
      map['device_i_d'] = Variable<String?>(deviceID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('employeeID: $employeeID, ')
          ..write('name: $name, ')
          ..write('phoneNo: $phoneNo, ')
          ..write('deviceID: $deviceID')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _employeeIDMeta = const VerificationMeta('employeeID');
  @override
  late final GeneratedColumn<String?> employeeID = GeneratedColumn<String?>(
      'employee_i_d', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _phoneNoMeta = const VerificationMeta('phoneNo');
  @override
  late final GeneratedColumn<int?> phoneNo = GeneratedColumn<int?>(
      'phone_no', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _deviceIDMeta = const VerificationMeta('deviceID');
  @override
  late final GeneratedColumn<String?> deviceID = GeneratedColumn<String?>(
      'device_i_d', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [employeeID, name, phoneNo, deviceID];
  @override
  String get aliasedName => _alias ?? 'employees';
  @override
  String get actualTableName => 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<Employee> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_i_d')) {
      context.handle(
          _employeeIDMeta,
          employeeID.isAcceptableOrUnknown(
              data['employee_i_d']!, _employeeIDMeta));
    } else if (isInserting) {
      context.missing(_employeeIDMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('phone_no')) {
      context.handle(_phoneNoMeta,
          phoneNo.isAcceptableOrUnknown(data['phone_no']!, _phoneNoMeta));
    }
    if (data.containsKey('device_i_d')) {
      context.handle(_deviceIDMeta,
          deviceID.isAcceptableOrUnknown(data['device_i_d']!, _deviceIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeID};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Employee.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Attendance extends DataClass implements Insertable<Attendance> {
  final String employeeID;
  final int attendanceCount;
  final DateTime? lastAttendance;
  Attendance(
      {required this.employeeID,
      required this.attendanceCount,
      this.lastAttendance});
  factory Attendance.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Attendance(
      employeeID: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d'])!,
      attendanceCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}attendance_count'])!,
      lastAttendance: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_attendance']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_i_d'] = Variable<String>(employeeID);
    map['attendance_count'] = Variable<int>(attendanceCount);
    if (!nullToAbsent || lastAttendance != null) {
      map['last_attendance'] = Variable<DateTime?>(lastAttendance);
    }
    return map;
  }

  AttendancesCompanion toCompanion(bool nullToAbsent) {
    return AttendancesCompanion(
      employeeID: Value(employeeID),
      attendanceCount: Value(attendanceCount),
      lastAttendance: lastAttendance == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttendance),
    );
  }

  factory Attendance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attendance(
      employeeID: serializer.fromJson<String>(json['employeeID']),
      attendanceCount: serializer.fromJson<int>(json['attendanceCount']),
      lastAttendance: serializer.fromJson<DateTime?>(json['lastAttendance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeID': serializer.toJson<String>(employeeID),
      'attendanceCount': serializer.toJson<int>(attendanceCount),
      'lastAttendance': serializer.toJson<DateTime?>(lastAttendance),
    };
  }

  Attendance copyWith(
          {String? employeeID,
          int? attendanceCount,
          DateTime? lastAttendance}) =>
      Attendance(
        employeeID: employeeID ?? this.employeeID,
        attendanceCount: attendanceCount ?? this.attendanceCount,
        lastAttendance: lastAttendance ?? this.lastAttendance,
      );
  @override
  String toString() {
    return (StringBuffer('Attendance(')
          ..write('employeeID: $employeeID, ')
          ..write('attendanceCount: $attendanceCount, ')
          ..write('lastAttendance: $lastAttendance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeID, attendanceCount, lastAttendance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attendance &&
          other.employeeID == this.employeeID &&
          other.attendanceCount == this.attendanceCount &&
          other.lastAttendance == this.lastAttendance);
}

class AttendancesCompanion extends UpdateCompanion<Attendance> {
  final Value<String> employeeID;
  final Value<int> attendanceCount;
  final Value<DateTime?> lastAttendance;
  const AttendancesCompanion({
    this.employeeID = const Value.absent(),
    this.attendanceCount = const Value.absent(),
    this.lastAttendance = const Value.absent(),
  });
  AttendancesCompanion.insert({
    required String employeeID,
    this.attendanceCount = const Value.absent(),
    this.lastAttendance = const Value.absent(),
  }) : employeeID = Value(employeeID);
  static Insertable<Attendance> custom({
    Expression<String>? employeeID,
    Expression<int>? attendanceCount,
    Expression<DateTime?>? lastAttendance,
  }) {
    return RawValuesInsertable({
      if (employeeID != null) 'employee_i_d': employeeID,
      if (attendanceCount != null) 'attendance_count': attendanceCount,
      if (lastAttendance != null) 'last_attendance': lastAttendance,
    });
  }

  AttendancesCompanion copyWith(
      {Value<String>? employeeID,
      Value<int>? attendanceCount,
      Value<DateTime?>? lastAttendance}) {
    return AttendancesCompanion(
      employeeID: employeeID ?? this.employeeID,
      attendanceCount: attendanceCount ?? this.attendanceCount,
      lastAttendance: lastAttendance ?? this.lastAttendance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeID.present) {
      map['employee_i_d'] = Variable<String>(employeeID.value);
    }
    if (attendanceCount.present) {
      map['attendance_count'] = Variable<int>(attendanceCount.value);
    }
    if (lastAttendance.present) {
      map['last_attendance'] = Variable<DateTime?>(lastAttendance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendancesCompanion(')
          ..write('employeeID: $employeeID, ')
          ..write('attendanceCount: $attendanceCount, ')
          ..write('lastAttendance: $lastAttendance')
          ..write(')'))
        .toString();
  }
}

class $AttendancesTable extends Attendances
    with TableInfo<$AttendancesTable, Attendance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendancesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _employeeIDMeta = const VerificationMeta('employeeID');
  @override
  late final GeneratedColumn<String?> employeeID = GeneratedColumn<String?>(
      'employee_i_d', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _attendanceCountMeta =
      const VerificationMeta('attendanceCount');
  @override
  late final GeneratedColumn<int?> attendanceCount = GeneratedColumn<int?>(
      'attendance_count', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _lastAttendanceMeta =
      const VerificationMeta('lastAttendance');
  @override
  late final GeneratedColumn<DateTime?> lastAttendance =
      GeneratedColumn<DateTime?>('last_attendance', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [employeeID, attendanceCount, lastAttendance];
  @override
  String get aliasedName => _alias ?? 'attendances';
  @override
  String get actualTableName => 'attendances';
  @override
  VerificationContext validateIntegrity(Insertable<Attendance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_i_d')) {
      context.handle(
          _employeeIDMeta,
          employeeID.isAcceptableOrUnknown(
              data['employee_i_d']!, _employeeIDMeta));
    } else if (isInserting) {
      context.missing(_employeeIDMeta);
    }
    if (data.containsKey('attendance_count')) {
      context.handle(
          _attendanceCountMeta,
          attendanceCount.isAcceptableOrUnknown(
              data['attendance_count']!, _attendanceCountMeta));
    }
    if (data.containsKey('last_attendance')) {
      context.handle(
          _lastAttendanceMeta,
          lastAttendance.isAcceptableOrUnknown(
              data['last_attendance']!, _lastAttendanceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeID};
  @override
  Attendance map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Attendance.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AttendancesTable createAlias(String alias) {
    return $AttendancesTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $AttendancesTable attendances = $AttendancesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [employees, attendances];
}
