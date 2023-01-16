enum MedicalMethod {
  TPN,
  Sonde,
}

enum Gender {
  Male,
  Female,
}

enum SondeStatus {
  firstAsk,
  noInsulin,
  yesInsulin,
  highInsulin,
  finish,
}

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

class StringToEnum {
  //gender
  static Gender stringToGender(String g) {
    switch (g) {
      case 'Nam':
        return Gender.Male;
      default:
        return Gender.Female;
    }
  }

  //medicalMethod
  static MedicalMethod stringToMedicalMethod(String m) {
    switch (m) {
      case 'TPN':
        return MedicalMethod.TPN;
      default:
        return MedicalMethod.Sonde;
    }
  }

  //sondeStatus
  static SondeStatus stringToSondeStatus(String s) {
    switch (s) {
      case 'firstAsk':
        return SondeStatus.firstAsk;
      case 'noInsulin':
        return SondeStatus.noInsulin;
      case 'yesInsulin':
        return SondeStatus.yesInsulin;
      case 'highInsulin':
        return SondeStatus.highInsulin;
      case 'finish':
        return SondeStatus.finish;
      default:
        return SondeStatus.firstAsk;
    }
  }
}
