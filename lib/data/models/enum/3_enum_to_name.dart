import 'enums.dart';

class EnumToName {
  //SondeStatus to name
  static String sondeStatusToName(SondeStatus status) {
    switch (status) {
      case SondeStatus.firstAsk:
        return 'Hỏi';
      case SondeStatus.noInsulin:
        return 'Phác đồ không tiêm ';
      case SondeStatus.transferToYes:
        return 'Phác đồ không tiêm ';
      case SondeStatus.yesInsulin:
        return 'Phác đồ có tiêm';
      case SondeStatus.transferToHigh:
        return 'Phác đồ có tiêm';
      case SondeStatus.highInsulin:
        return 'Phác đồ liều cao';
      case SondeStatus.transferToFinish:
        return 'Phác đồ liều cao';
      case SondeStatus.finish:
        return 'Kết thúc';
      default:
        return 'Đang chờ';
    }
  }
}
