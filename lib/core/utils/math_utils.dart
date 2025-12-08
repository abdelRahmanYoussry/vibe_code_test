import 'dart:math';

double doubleInRange(Random source, num start, num end) => source.nextDouble() * (end - start) + start;

double degToRad(double deg) => (deg * pi) / 180;

double radToDeg(double rad) => (rad * 180) / pi;

String formatLargeNumbers(int number) {
  if (number > 1000000000000) {
    return "${(number / 1000000000000).withDecimals(1)}T";
  } else if (number > 1000000000) {
    return "${(number / 1000000000).withDecimals(1)}B";
  } else if (number > 1000000) {
    return "${(number / 1000000).withDecimals(1)}M";
  } else if (number > 1000) {
    return "${(number / 1000).withDecimals(1)}K";
  }
  return number.withDecimals(1);
}

int calculateOffset(int page, int limit) => limit * (page - 1);

extension MathX on num {
  String withDecimals(int count) {
    //has decimal
    if (this % 1 != 0) {
      //remove redundant zeros
      return toStringAsFixed(count).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    } else {
      return toStringAsFixed(0);
    }
  }
}
