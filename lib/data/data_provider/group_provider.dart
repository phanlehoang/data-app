import 'package:data_app/data/data_provider/search_document.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

class GroupCreate {
  static Future<String?> createGroup(String id, ) async {
    var db = FirebaseStorage.instance;
    var ref = db.ref('groups/$id');
    var ans = await ref.putData([]));
    if (ans.state == TaskState.success) {
      return null;
    }
    return 'Error creating group';
  }
}
