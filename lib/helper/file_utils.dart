import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sky_vacation/helper/app_util.dart';

class AppFile{
  static Future<File> getLocalFile(String fileName) async {
    final path = await getLocalPath();
    return File('$path$fileName');
  }

  static Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    appLog("directory.path:: ${directory.path}");
    return "${directory.path}/NearSouq/";
  }

  static Future<File> writeContent(String fileName, String content) async {
    final file = await getLocalFile(fileName);
    if(file.existsSync())
    return file.writeAsString(content);

    File newFile = await new File(file.path).create(recursive: true);
    return newFile.writeAsString(content);
  }
  static Future<String> getContent(String fileName) async {
    try {
      final file = await getLocalFile(fileName);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }
}
