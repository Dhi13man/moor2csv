library moor2csv;

import 'dart:io';

import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Class handling the CSV generation.
class MoorSQLToCSV {
  final List<DataClass> _table; // Passed as parameter to Class constructor.
  String csvFileName; // Passed as parameter to Class constructor.
  String _pathToFile;

  Future<File> _file;
  bool _permitted = true, _prExisting;
  Future<bool> _status;

  ///  Gets boolean signifying whether the CSV was created.
  Future<bool> get wasCreated => _status;

  /// Gets path to directory where the CSV was created.
  String get pathToCSVDirectory => _pathToFile;

  /// Constructor of the MoorSQLToCSV class that gets the entire process started.
  ///
  /// Pass [_table] is a List<DataClass> that the utility iterates over, to generate CSV.
  ///  [csvFileName] is the file name that generated CSV is to be stored as
  MoorSQLToCSV(this._table, {this.csvFileName = 'table'}) {
    String _csvBody = _generateCSVBody();
    _pathToFile = 'No file created yet!'; // Initial State

    getPermission().then((value) => _permitted = value);
    this._file = _localFile(csvFileName);
    this._prExisting = false;

    _status = _writeToCSV(_csvBody);
  }

  /// Simple dart helper function to generate a String [out], which is the body of the generated CSV file.
  String _generateCSVBody() {
    String out = '';
    Map<String, dynamic> _template = _table[0].toJson();

    // Create headings
    _template.forEach((key, value) {
      out += '$key,';
    });
    out = out.replaceRange(out.length, out.length, '\n');

    _table.forEach((element) {
      _template = element.toJson();
      _template.forEach((key, value) {
        out += '$value,';
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

  /// Gets path to permitted file writing directories depending on the OS.
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
    final String path = await _localPath;
    _pathToFile = '$path/$name.csv';
    final File thisFile = File(_pathToFile);

    // Try getting permission again if not already given.
    if (!_permitted) _permitted = await getPermission();

    _prExisting = await thisFile.exists();
    if (!_prExisting) thisFile.writeAsString(initial);

    return thisFile;
  }

  /// Once everything else is handled final writing is done by this
  ///
  /// generates the file pointer with [_localFile] member,
  /// writes CSV String body [csvBody] to the created file pointer.
  Future<bool> _writeToCSV(String csvBody) async {
    // Write the file
    final File thisFile = await _file;
    if (!_permitted) _permitted = await getPermission();
    if (!_permitted) return false; // Still not permitted. Error.
    thisFile.writeAsString(csvBody);
    return true; // Success
  }
}
