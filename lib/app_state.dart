import 'package:flutter/material.dart';
import 'package:note_app/services/encryption_service.dart';
import 'package:note_app/services/user_service.dart';
import 'package:uuid/uuid.dart';

class ApplicationState extends ChangeNotifier {
  final Uuid _uuid = const Uuid();
  final EncryptionService _encryptionService = EncryptionService();
  final UserService _userService = UserService();

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  String? userId;
  String? uid;
  String? username;
  String? email;
  String? phone;

  Future<String> signUp(String username, String email, String phone, String password) async {
    String uid = _uuid.v4();
    String hashedPassword = _encryptionService.hashPassword(password);
    String res = await _userService.createUser(uid, username, email, phone, hashedPassword);
    return res;
  }   

  Future<String> signIn(String email, String password) async {
    String hashedPassword = _encryptionService.hashPassword(password);
    Map<String, dynamic> result = await _userService.getUser(email, hashedPassword);
    if (result['success']) {
      userId = result['userId'];
      uid = result['uid'];
      username = result['username'];
      this.email = result['email'];
      phone = result['phone'];

      _loggedIn = true;
      notifyListeners();
      return 'Success';
    } else {
      return result['message'];
    }
  } 


  void signOut() {
    userId = null;
    uid = null;
    username = null;
    email = null;
    phone = null;

    _loggedIn = false;
    notifyListeners();
  }
}