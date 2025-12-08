import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/utils/math_utils.dart';

extension SafeList<E> on List<E> {
  E? safeElementAt(int index) {
    if (index < length && index >= 0) {
      return elementAt(index);
    }
    return null;
  }

  E? get safeFirst {
    if (isNotEmpty) {
      return first;
    }
    return null;
  }

  E? get safeLast {
    if (isNotEmpty) {
      return last;
    }
    return null;
  }

  List<E> safeSublist(int start, [int? end]) {
    try {
      return sublist(start, end);
    } catch (_) {
      return this;
    }
  }

  E? safeFirstWhere(bool Function(E e) predicate) {
    if (any(predicate)) {
      return firstWhere(predicate);
    }
    return null;
  }

  int? safeFirstIndexWhere(bool Function(E e) predicate) {
    if (any(predicate)) {
      return indexWhere(predicate);
    }
    return null;
  }

  E? safeLastWhere(bool Function(E e) predicate) {
    if (any(predicate)) {
      return lastWhere(predicate);
    }
    return null;
  }

  int? safeLastIndexWhere(bool Function(E e) predicate) {
    if (any(predicate)) {
      return lastIndexWhere(predicate);
    }
    return null;
  }

  E? safeRemoveAt(int index) {
    try {
      return removeAt(index);
    } catch (_) {
      return null;
    }
  }

  E? safeRemoveLast() {
    try {
      return removeLast();
    } catch (_) {
      return null;
    }
  }
}

extension SafeString on String {
  List<String> safeSplit(Pattern pattern) {
    if (contains(pattern)) {
      return split(pattern);
    }
    return [];
  }

  String withDecimals(int count) => !validDouble(this) ? this : validateDouble(this).withDecimals(count);
}

extension EnumByName<E extends Enum> on Iterable<E> {
  E? safeByName(String name) {
    if (any((e) => e.name == name)) {
      return byName(name);
    }
    return null;
  }
}
