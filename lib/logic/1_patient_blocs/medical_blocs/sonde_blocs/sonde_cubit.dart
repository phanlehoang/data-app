// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:data_app/presentation/screens/1_patient_screens/sonde_screens/sonde_fast_insulin/2_1_1_checking_glucose_widget.dart';

import '../../../../data/models/enums.dart';
import '../../../../data/models/profile.dart';
import '../../../../data/models/sonde/6_sonde_state.dart';
import '../../../../data/models/sonde/sonde_lib.dart';

class SondeCubit extends Cubit<SondeState> {
  SondeCubit(SondeState initialState) : super(initialState);
 
    //catch state error 
    @override
  void emit(dynamic state) {
    try {
      super.emit(state);
    } catch (e) {
      if (e == StateError('Cannot emit new states after calling close')) {
        return;
      }
    }
  }
  
  Future<void> goToNextStatus(Regimen regimen,
      Profile profile, SondeStatus oldStatus) async{
        emit(SondeState(status: SondeStatus.transfer,
        cho: state.cho,
        bonusInsulin: state.bonusInsulin ,
        weight: state.weight,
        ));
        transferData(regimen, profile);
        switch (oldStatus) {
          case SondeStatus.noInsulin:
           await switchStatusOnline(regimen, profile, SondeStatus.yesInsulin);
            return;
          case SondeStatus.yesInsulin:
           await switchStatusOnline(regimen, profile, SondeStatus.highInsulin);
            return;
          case SondeStatus.highInsulin:
            await switchStatusOnline(regimen, profile, SondeStatus.finish);
            return;
          default:
          return;
        }
  }
  Future<void> transferData(Regimen regimen,
      Profile profile) async{
        var ref =  RefProvider.fastInsulinStateRef(profile);
         var oldRegimen =await RefProvider.fastInsulinHistoryRef (profile)
        .add(regimen.toMap());
      }

  Future<void> switchStatusOnline(
    Regimen regimen,
      Profile profile, SondeStatus newStatus) async {
    var ref =  RefProvider.fastInsulinStateRef(profile);
  
     

    var switchNewStatus =await FirebaseFirestore.instance 
    .collection('groups').doc(profile.room)
    .collection('patients').doc(profile.id)
    .collection('medicalMethods').doc('Sonde')
    .update({
      'status': EnumToString.enumToString(newStatus),
    });
   
}
}



