import 'enums.dart';

class EnumToString {
  static String enumToString(dynamic o) => o.toString().split('.').last;
  static String genderToString(Gender gender) {
    switch (gender) {
      case Gender.Male:
        return 'Nam';
      default:
        return 'Nữ';
    }
  }
}
