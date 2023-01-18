import 'check_time_in_range.dart';

class SondeRange {
  static List<Range> sondeRange = [
    Range(HourMinute(5, 30), HourMinute(6, 30)),
    Range(HourMinute(11, 30), HourMinute(12, 30)),
    Range(HourMinute(17, 30), HourMinute(18, 30)),
    Range(HourMinute(21, 30), HourMinute(22, 30)),
  ];

  static bool inSondeRange(DateTime t) {
    List<bool> b = [for (int i = 0; i < 4; i++) inRange(t, sondeRange[i])];
    var result = b.any((element) => element == true);
    return result;
  }

  static bool inSondeRangeToday(DateTime t) {
    List<bool> b = [for (int i = 0; i < 4; i++) inRangeToday(t, sondeRange[i])];
    var result = b.any((element) => element == true);
    return result;
  }

  static int? rangeContain(DateTime t) {
    for (int i = 0; i < 4; i++) {
      if (inRange(t, sondeRange[i])) {
        return i;
      }
    }
    return null;
  }

  static int nextRange(DateTime t) {
    HourMinute hm = HourMinute(t.hour, t.minute);
    for (int i = 0; i < 4; i++) {
      if (hm < sondeRange[i].start) {
        return i;
      }
    }
    return 0;
  }

  static String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    int h = sondeRange[indexNextRange].start.hour;
    int m = sondeRange[indexNextRange].start.minute;
    return 'Bạn phải đợi đến $h: $m cho lần đo tiếp theo.';
  }

  static bool isHot(DateTime t) {
    return inSondeRangeToday(t) &&
        rangeContain(t) == rangeContain(DateTime.now());
  }
}
