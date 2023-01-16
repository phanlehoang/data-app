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

enum NoInsulinSondeStatus {
  gettingCHO,
  checkingGlucose,
  checkedGlucose,
  givingInsulin,
  givenInsulin,
}

enum InsulinType {
  Glargine,
  Actrapid,
  NPH,
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

  //insulinType
  static InsulinType stringToInsulinType(String i) {
    switch (i) {
      case 'Glargine':
        return InsulinType.Glargine;
      case 'Actrapid':
        return InsulinType.Actrapid;
      case 'NPH':
        return InsulinType.NPH;
      default:
        return InsulinType.Actrapid;
    }
  }

  //noInsulinSondeStatus
  static NoInsulinSondeStatus stringToNoInsulinSondeStatus(String s) {
    switch (s) {
      case 'gettingCHO':
        return NoInsulinSondeStatus.gettingCHO;
      case 'checkingGlucose':
        return NoInsulinSondeStatus.checkingGlucose;
      case 'checkedGlucose':
        return NoInsulinSondeStatus.checkedGlucose;
      case 'givingInsulin':
        return NoInsulinSondeStatus.givingInsulin;
      case 'givenInsulin':
        return NoInsulinSondeStatus.givenInsulin;
      default:
        return NoInsulinSondeStatus.gettingCHO;
    }
  }
}
