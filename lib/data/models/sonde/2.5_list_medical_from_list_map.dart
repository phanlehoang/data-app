



import '2_medical_check_glucose.dart';
import '3_medical_take_insulin.dart';

class ListMedicalFromListMap{
  static List<MedicalCheckGlucose> medicalCheckGlucoses(List<dynamic>? listMap){
    if (listMap == null) return [];
    List<MedicalCheckGlucose> ans = [];
    for (Map<String,dynamic> x in listMap) {
      try{
        ans.add(MedicalCheckGlucose.fromMap(x));
      }catch(e){
        continue;
      }

    }
    return ans;
  }
  //listMap to list of MedicalTakeInsulin
  static List<MedicalTakeInsulin> medicalTakeInsulins(List<dynamic >?
   listMap){
    if (listMap == null) return [];
    List<MedicalTakeInsulin> ans = [];
    for (Map<String,dynamic> x in listMap) {
      try{
        ans.add(MedicalTakeInsulin.fromMap(x));
      }catch(e){
        continue;
      }

    }
    return ans;
  }
  static List<dynamic> medicalActions(List<dynamic>? listMap){
    
    if (listMap == null) return [];
    List<dynamic> ans = [];
    for (Map<String,dynamic> x in listMap) {
      try{
        if (x['name'] == 'MedicalCheckGlucose')
          ans.add(MedicalCheckGlucose.fromMap(x));
        else if (x['name'] == 'MedicalTakeInsulin')
          ans.add(MedicalTakeInsulin.fromMap(x));
        else{
          continue;
        }
      }catch(e){
        continue;
      }

    }
    return ans;
  }
}






