library moor2csv;

import 'dart:io';

import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Custom Json Serializer for converting classes to Json before converting to CSV
class CustomJsonSerializer extends ValueSerializer {
  const CustomJsonSerializer() : super();

  @override

  /// fromJson remains with same properties as default serializer.
  T fromJson<T>(dynamic json) {
    if (json == null) {
      return null;
    }

    if (T == DateTime) {
      return DateTime.parse(json as String) as T;
    }

    if (T == double && json is int) {
      return json.toDouble() as T;
    }

    // blobs are encoded as a regular json array, so we manually convert that to
    // a Uint8List
    if (T == Uint8List && json is! Uint8List) {
      final asList = (json as List).cast<int>();
      return Uint8List.fromList(asList) as T;
    }

    return json as T;
  }

  @override

  /// Override original toJson for DateTime as-is handling.
  dynamic toJson<T>(T value) {
    if (value is DateTime) {
      return value.toString();
    }

    return value;
  }
}

/// Class performing the entire CSV generation process.
class MoorSQLToCSV {
  final List<DataClass> _table; // Passed as parameter to Class constructor.
  String csvFileName; // Passed as parameter to Class constructor.
  String
      _pathToFile; // Saves the path to the generated file here once generation is done. (if failure, stores error)

  Future<File> _file;
  bool _permitted = true, _prExisting;
  Future<bool> _status;

  ///  Gets boolean signifying whether the CSV was created.
  Future<bool> get wasCreated => _status;

  /// Gets path to directory where the CSV was created. (or error, if operation failed)
  String get pathToCSVDirectory => _pathToFile;

  /// Constructor of the MoorSQLToCSV class that gets the entire process started.
  ///
  /// Pass [_table] is a List<DataClass> that the utility iterates over, to generate CSV.
  ///  [csvFileName] is the file name that generated CSV is to be stored as
  MoorSQLToCSV(this._table, {this.csvFileName = 'table'}) {
    // Initial State
    _pathToFile = 'No file created yet!';
    this._prExisting =
        false; // Assume file is not already existing. Will be modified later if it does.

    // Ask for permission and save permission state to _permitted.
    getPermission().then((value) => _permitted = value);

    // Generate File pointer.
    this._file = _localFile(csvFileName);
    // Generate the body of the CSV from the passed List<DataClass> _table
    String _csvBody = _generateCSVBody();
    // Finally, generated body of CSV to file
    _status = _writeToCSV(_csvBody); // Also set status if successfully created.
  }

  /// Simple dart helper function to generate a String [out], which is the body of the generated CSV file.
  String _generateCSVBody() {
    String out = '';
    // Set up Custom Json Serializer that can handle Dates as-is.
    CustomJsonSerializer _serializer = CustomJsonSerializer();
    Map<String, dynamic> _template = _table[0].toJson(serializer: _serializer);

    // Create headings
    _template.forEach((key, value) {
      out += '\"$key\",';
    });
    out = out.replaceRange(out.length, out.length, '\n');

    _table.forEach((element) {
      _template = element.toJson(serializer: _serializer);
      _template.forEach((key, value) {
        out += '\"$value\",';
      });
      out = out.replaceRange(out.length, out.length, '\n');
    });
    return out;
  }

  /// Gets Permission in Android and IOS devices.
  ///
  /// Not required for Desktop. Directly saves to Downloads folder.
  Future<bool> getPermission() async {
    // Don't need permission for desktop devices
    if (!Platform.isIOS && !Platform.isAndroid) return true;
    PermissionStatus permissionResult = await Permission.storage.request();
    return (permissionResult == PermissionStatus.granted);
  }

  /// Gets path to permitted file writing directories depending on the OS using path_provider package.
  Future<String> get _localPath async {
    Directory directory;
    if (Platform.isAndroid || Platform.isIOS)
      directory = await getApplicationDocumentsDirectory();
    else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS)
      directory = await getDownloadsDirectory();
    else
      directory = await getTemporaryDirectory();
    return directory.path;
  }

  /// Generates the File pointer [thisFile] where the CSV body will then be written into.
  Future<File> _localFile(String name, {String initial = ''}) async {
    try {
      final String path = await _localPath;
      _pathToFile = '$path/$name.csv';
      final File thisFile = File(_pathToFile);

      // Try getting permission again if not already given.
      if (!_permitted) _permitted = await getPermission();

      _prExisting = await thisFile.exists();
      if (!_prExisting) thisFile.writeAsString(initial);
      return thisFile;
    } catch (e) {
      return null;
    }
  }

  /// Once everything else is handled, final writing is done by this member.
  ///
  /// Generates the file pointer with [_localFile] member,
  /// writes CSV String body [csvBody] to the created file pointer.
  Future<bool> _writeToCSV(String csvBody) async {
    // Write the file
    try {
      final File thisFile = await _file;
      // Occurs when file name is not proper
      if (thisFile == null) throw ('Enter Valid Accessible File Name.');

      if (!_permitted) _permitted = await getPermission();
      if (!_permitted) return false; // Still not permitted. Error.
      thisFile.writeAsString(csvBody);
      return true; // Success
    } catch (e) {
      _pathToFile = 'Error Occured: ${e.toString()}';
      return false;
    }
  }
}
