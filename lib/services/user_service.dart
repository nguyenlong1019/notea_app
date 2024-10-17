import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(String uid, String username, String email, String phone, String hashedPassword) async {
    try {
      QuerySnapshot userSnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

      if (userSnapshot.docs.isNotEmpty) {
        return 'Email already exists!';
      }

      await _firestore.collection('users').add({
        'uid': uid,
        'username': username,
        'email': email,
        'phone': phone,
        'pwd': hashedPassword,
      });

      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }


  Future<Map<String, dynamic>> getUser(String email, String hashedPassword) async {
    try {
      QuerySnapshot userSnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userDoc = userSnapshot.docs.first;

        if (userDoc['pwd'] != hashedPassword) {
          return {
            'success': false,
            'message': 'Password is not correct!'
          };
        } else {
          return {
            'success': true,
            'message': "Oke",
            'userId': userDoc.id,
            'uid': userDoc['uid'],
            'username': userDoc['username'],
            'email': userDoc['email'],
            'phone': userDoc['phone'],
          };
        }
      }

      return {
        'success': false,
        'message': 'Email does not exist!'
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

}