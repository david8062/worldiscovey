import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:worldiscovery/screens/register/model/register_model.dart';
class RegisterViewModel extends ChangeNotifier {

  
  final UserRegister userRegister = UserRegister(
    name: '',
    email: '',
    password: '',
    confirmPassword: '',
    phoneNumber: '',
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setName(String name) {
    userRegister.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    userRegister.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    userRegister.password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    userRegister.confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    userRegister.phoneNumber = phoneNumber;
    notifyListeners();
  }



  Future<void> register(BuildContext context) async {
    if (userRegister.password != userRegister.confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden'),
        ),
      );
      return;
    }
    try {

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userRegister.email,
        password: userRegister.password,
      );
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': userRegister.name,
        'email': userRegister.email,
        'phoneNumber': userRegister.phoneNumber,
      });
      await userCredential.user!.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Se ha registrado correctamente, por favor verifica tu correo electrónico'),
        ),
      );
    } catch (e) {
      print("Error al registrar: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
  
}