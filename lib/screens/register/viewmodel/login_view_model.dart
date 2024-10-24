import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worldiscovery/screens/register/model/register_model.dart';
import 'package:worldiscovery/screens/sections/views/sections.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final UserLogin userLogin = UserLogin(
      email: '',
      password: '',
  );
  void setEmail(String email) {
    userLogin.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    userLogin.password = password;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userLogin.email,
        password: userLogin.password,
      );


      if (userCredential.user!.emailVerified) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Sections()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor verifica tu correo electrónico'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuario no encontrado'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contraseña incorrecta'),
          ),
        );
      }
    }
}

}