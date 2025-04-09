import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class HandleJsonFile {
  static Future<List> readJsonFile(String pathFile) async {
    try {
      String jsonString = await rootBundle.loadString(pathFile);

      if (jsonString.isEmpty) {
        throw const FormatException('Empty JSON file');
      }
      final dataJson = json.decode(jsonString);
      if (!dataJson.containsKey('Data') || !(dataJson['Data'] is List)) {
        throw const FormatException('Invalid JSON structure: missing or invalid Data field');
      }
      var listTopicJson = dataJson['Data'] as List<dynamic>;
      return listTopicJson;
    } catch (e) {
      print('Error reading JSON file ($pathFile): $e');
      rethrow;
    }
  }

  // List<Map<String, dynamic>> _dataListToJson(List<Topic> dataList) {
  //   return dataList.map((data) => data.toMap()).toList();
  // }

  // Future<void> writeListJsonTopicFile(List<dynamic> data) async {
  //   Directory? directory;
  //   try {
  //     directory = await getApplicationDocumentsDirectory();
  //     String filePath = '${directory.path}/dataCustomer.json';
  //     String tempPath = '$filePath.tmp';
  //
  //     // Write to temporary file first
  //     final tempFile = File(tempPath);
  //     final jsonDataList = _dataListToJson(data);
  //     final jsonData = jsonEncode({'Data': jsonDataList});
  //
  //     await tempFile.writeAsString(jsonData);
  //
  //     // If write was successful, move temp file to actual file
  //     final file = File(filePath);
  //     if (await tempFile.exists()) {
  //       await tempFile.rename(filePath);
  //       print('Data written to file successfully');
  //     } else {
  //       throw FileSystemException('Failed to write temporary file', tempPath);
  //     }
  //   } catch (e) {
  //     print('Error writing to file: $e');
  //     rethrow;
  //   } finally {
  //     // Clean up temp file if it still exists
  //     if (directory != null) {
  //       try {
  //         final tempFile = File('${directory.path}/dataCustomer.json.tmp');
  //         if (await tempFile.exists()) {
  //           await tempFile.delete();
  //         }
  //       } catch (e) {
  //         print('Error cleaning up temporary file: $e');
  //       }
  //     }
  //   }
  // }
}