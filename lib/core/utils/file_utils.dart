import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> fileFromAsset(String path) async {
  final bytes = await rootBundle.load(path);
  final buffer = bytes.buffer;
  final dir = await getTemporaryDirectory();
  final ext = path.split('.').last;
  final tmp = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.$ext';
  final file = File(tmp);
  if (!await file.exists()) {
    await file.create();
  }
  await file.writeAsBytes(
    buffer.asUint8List(
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    ),
  );
  return file;
}

Future<File?> downloadFile(BuildContext context, String url, String fileName, {bool temp = false, bool app = false, String? subDir}) async {
  HttpClient httpClient = HttpClient();
  String dir = (app
              ? await getApplicationDocumentsDirectory()
              : temp
                  ? await getTemporaryDirectory()
                  : Platform.isIOS
                      ? await getApplicationDocumentsDirectory()
                      : await getDownloadsDirectory())
          ?.path ??
      '';
  if (subDir != null && subDir.isNotEmpty) {
    dir = '$dir/$subDir';
  }
  File file;

  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      final filePath = '$dir/$fileName';
      file = File(filePath);
      if (!await file.exists()) {
        await file.create(recursive: true);
      }
      await file.writeAsBytes(bytes);
    } else {
      return null;
    }
  } catch (ex) {
    return null;
  }

  return file;
}

Future<File?> saveFromMemoryRaw(String fileName, String raw) async {
  try {
    final bytes = base64Decode(raw);
    final dir = await getApplicationDocumentsDirectory();
    final file = File([dir.path, fileName].join('/'));
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsBytes(bytes);
    return file;
  } catch (e) {
    return null;
  }
}
