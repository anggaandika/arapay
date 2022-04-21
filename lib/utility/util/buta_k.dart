import 'package:arapay/utility/main.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> getFilePath() async {
  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory.path; // 2
  String filePath = '$appDocumentsPath/butaka.txt'; // 3

  return filePath;
}

void buatKdAk() async {
  File file = File(await getFilePath());
  var kdMentah = DateFormat("ddMMyyyyHHmmss").format(DateTime.now());
  String kdSetMateng = hashed(kdMentah).substring(1, 12);
  if (file.existsSync() == false) {
    file.writeAsString(kdSetMateng);
  }
}

void readFile() async {
  try {
    File file = File(await getFilePath()); // 1
    String fileContent = await file.readAsString(); // 2

    // ignore: avoid_print
    print('File Content: $fileContent');
  } catch (e) {
    // ignore: avoid_print
    print('file : $e');
  }
}
