class NiceDateTime {
  static String dayMonth(DateTime t) {
    num d = t.day;
    num m = t.month;

    return '$d Th $m';
  }

  static String hourMinute(DateTime t) {
    num h = t.hour;
    num m = t.minute;

    return '$h:$m';
  }
}
