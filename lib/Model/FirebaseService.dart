import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waterdropdash/Model/UserModel.dart';


class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserData(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}
