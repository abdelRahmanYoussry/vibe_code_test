class Repeater<T> {
  final List<T> pool;
  final int length;

  Repeater(this.pool, this.length);

  int index = 0;

  T get() {
    final item = getOf(index);
    index++;
    return item;
  }

  T getOf(int index) {
    final first = pool.first;
    final trueIndex = index % pool.length;
    final item = pool[trueIndex];
    final isLast = trueIndex == pool.length - 1;
    final isSameAsFirst = item == first;
    if (isLast && isSameAsFirst) {
      return getOf(index + 1);
    }
    return item;
  }
}
