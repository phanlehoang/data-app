enum Gender {
  Male,
  Female,
}

enum MedicalMethod {
  TPN,
  Sonde,
}

enum SondeStatus {
  firstAsk,
  noInsulin,
  transferToYes,
  yesInsulin,
  transferToHigh,
  highInsulin,
  transferToFinish,
  finish,
}

enum RegimenStatus {
  error,
  checkingGlucose,
  givingInsulin,
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
      case 'transferToYes':
        return SondeStatus.transferToYes;
      case 'yesInsulin':
        return SondeStatus.yesInsulin;
      case 'transferToHigh':
        return SondeStatus.transferToHigh;
      case 'highInsulin':
        return SondeStatus.highInsulin;
      case 'transferToFinish':
        return SondeStatus.transferToFinish;
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

  //regimenStatus
  static RegimenStatus stringToRegimenStatus(String r) {
    switch (r) {
      case 'checkingGlucose':
        return RegimenStatus.checkingGlucose;
      case 'givingInsulin':
        return RegimenStatus.givingInsulin;
      default:
        return RegimenStatus.checkingGlucose;
    }
  }
}
