import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class VietnameseFieldBlocValidators {
  static String? required(dynamic value) {
    if (value == null) return 'Ô này cần điền';
    if (value == '') {
      return 'Ô này cần điền';
    }
    return null;
  }

  static String? lightRequired(dynamic value) {
    if (value == null) return 'Bạn chưa điền';
    if (value == '') {
      return 'Bạn chưa điền';
    }
    return null;
  }

  static String? email(String value) {
    if (FieldBlocValidators.email(value) != null) {
      return 'Email này định dạng chưa chuẩn';
    }
    return null;
  }
}
