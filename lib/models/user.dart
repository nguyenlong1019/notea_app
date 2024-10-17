class User {
  final String uid;
  final String username;
  final String email;
  final String phone;
  final String pwd;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.phone,
    required this.pwd
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phone': phone,
      'pwd': pwd,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      pwd: map['pwd'],
    );
  }
}