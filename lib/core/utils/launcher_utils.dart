import 'dart:io';

import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/utils/safe_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<bool> launchUri(Uri uri) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
    return true;
  }
  return false;
}

Future<bool> launchLink(String link) async {
  if (await canLaunchUrlString(link)) {
    await launchUrlString(link);
    return true;
  }
  return false;
}

Future<bool> launchTel(String phone) async {
  final tel = "tel:$phone";
  if (await canLaunchUrlString(tel)) {
    await launchUrlString(tel);
    return true;
  }
  return false;
}

Future<bool> launchFile(File file) async {
  try {
    await OpenFile.open(file.absolute.path);
    return true;
  } catch (_) {
    return false;
  }
}

Future<bool> launchEmail(String phone) async {
  final tel = "mailto:$phone";
  if (await canLaunchUrlString(tel)) {
    await launchUrlString(tel);
    return true;
  }
  return false;
}

Future<ShareResult> share({
  String? text,
  String? subject,
  List<File>? files,
}) {
  return SharePlus.instance.share(
    ShareParams(
      text: text == null ? null : removeHtml(text),
      files: files == null ? null : [...files.map((e) => XFile(e.path, name: e.path.safeSplit('/').safeLast))],
      subject: subject == null ? null : removeHtml(subject),
    ),
  );
}

String getQrLink(String content) => "https://quickchart.io/qr?text=${Uri.encodeComponent(content)}&size='500x500'";
