// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_test.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Employee extends DataClass implements Insertable<Employee> {
  final String employeeID;
  final String name;
  final int phoneNo;
  final String deviceID;
  Employee({@required this.employeeID, this.name, this.phoneNo, this.deviceID});
  factory Employee.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Employee(
      employeeID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}employee_i_d']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      phoneNo:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}phone_no']),
      deviceID: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}device_i_d']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || employeeID != null) {
      map['employee_i_d'] = Variable<String>(employeeID);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phoneNo != null) {
      map['phone_no'] = Variable<int>(phoneNo);
    }
    if (!nullToAbsent || deviceID != null) {
      map['device_i_d'] = Variable<String>(deviceID);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      employeeID: employeeID == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeID),
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
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Employee(
      employeeID: serializer.fromJson<String>(json['employeeID']),
      name: serializer.fromJson<String>(json['name']),
      phoneNo: serializer.fromJson<int>(json['phoneNo']),
      deviceID: serializer.fromJson<String>(json['deviceID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeID': serializer.toJson<String>(employeeID),
      'name': serializer.toJson<String>(name),
      'phoneNo': serializer.toJson<int>(phoneNo),
      'deviceID': serializer.toJson<String>(deviceID),
    };
  }

  Employee copyWith(
          {String employeeID, String name, int phoneNo, String deviceID}) =>
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
  int get hashCode => $mrjf($mrjc(employeeID.hashCode,
      $mrjc(name.hashCode, $mrjc(phoneNo.hashCode, deviceID.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Employee &&
          other.employeeID == this.employeeID &&
          other.name == this.name &&
          other.phoneNo == this.phoneNo &&
          other.deviceID == this.deviceID);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<String> employeeID;
  final Value<String> name;
  final Value<int> phoneNo;
  final Value<String> deviceID;
  const EmployeesCompanion({
    this.employeeID = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNo = const Value.absent(),
    this.deviceID = const Value.absent(),
  });
  EmployeesCompanion.insert({
    @required String employeeID,
    this.name = const Value.absent(),
    this.phoneNo = const Value.absent(),
    this.deviceID = const Value.absent(),
  }) : employeeID = Value(employeeID);
  static Insertable<Employee> custom({
    Expression<String> employeeID,
    Expression<String> name,
    Expression<int> phoneNo,
    Expression<String> deviceID,
  }) {
    return RawValuesInsertable({
      if (employeeID != null) 'employee_i_d': employeeID,
      if (name != null) 'name': name,
      if (phoneNo != null) 'phone_no': phoneNo,
      if (deviceID != null) 'device_i_d': deviceID,
    });
  }

  EmployeesCompanion copyWith(
      {Value<String> employeeID,
      Value<String> name,
      Value<int> phoneNo,
      Value<String> deviceID}) {
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
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNo.present) {
      map['phone_no'] = Variable<int>(phoneNo.value);
    }
    if (deviceID.present) {
      map['device_i_d'] = Variable<String>(deviceID.value);
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
  final GeneratedDatabase _db;
  final String _alias;
  $EmployeesTable(this._db, [this._alias]);
  final VerificationMeta _employeeIDMeta = const VerificationMeta('employeeID');
  GeneratedTextColumn _employeeID;
  @override
  GeneratedTextColumn get employeeID => _employeeID ??= _constructEmployeeID();
  GeneratedTextColumn _constructEmployeeID() {
    return GeneratedTextColumn(
      'employee_i_d',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, true, maxTextLength: 100);
  }

  final VerificationMeta _phoneNoMeta = const VerificationMeta('phoneNo');
  GeneratedIntColumn _phoneNo;
  @override
  GeneratedIntColumn get phoneNo => _phoneNo ??= _constructPhoneNo();
  GeneratedIntColumn _constructPhoneNo() {
    return GeneratedIntColumn(
      'phone_no',
      $tableName,
      true,
    );
  }

  final VerificationMeta _deviceIDMeta = const VerificationMeta('deviceID');
  GeneratedTextColumn _deviceID;
  @override
  GeneratedTextColumn get deviceID => _deviceID ??= _constructDeviceID();
  GeneratedTextColumn _constructDeviceID() {
    return GeneratedTextColumn(
      'device_i_d',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [employeeID, name, phoneNo, deviceID];
  @override
  $EmployeesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'employees';
  @override
  final String actualTableName = 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<Employee> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_i_d')) {
      context.handle(
          _employeeIDMeta,
          employeeID.isAcceptableOrUnknown(
              data['employee_i_d'], _employeeIDMeta));
    } else if (isInserting) {
      context.missing(_employeeIDMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('phone_no')) {
      context.handle(_phoneNoMeta,
          phoneNo.isAcceptableOrUnknown(data['phone_no'], _phoneNoMeta));
    }
    if (data.containsKey('device_i_d')) {
      context.handle(_deviceIDMeta,
          deviceID.isAcceptableOrUnknown(data['device_i_d'], _deviceIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeID};
  @override
  Employee map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Employee.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EmployeesTable _employees;
  $EmployeesTable get employees => _employees ??= $EmployeesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [employees];
}
