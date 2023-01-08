import 'package:data_app/data/data_provider/search_document.dart';

class GroupValidator {
  static Future<String?> idExist(String id) async {
    var ans = await searchGroupId('groups', id);
    if (ans) {
      return null;
    }
    return 'Group ID does not exist';
  }

  static Future<String?> idCreateValid(String id) async {
    var ans = await searchGroupId('groups', id);
    if (ans) {
      return 'Group ID already exists';
    }
    return null;
  }
}
