import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptionService {
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}