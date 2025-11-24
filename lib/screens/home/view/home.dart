import 'package:flutter/material.dart';
import 'package:worldiscovery/styles/colors.dart';
import 'package:worldiscovery/screens/register/view/register_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
            const Text("Bienvenido a Bogota Discover"),
            const SizedBox(height: 200.0),  // Espacio entre la imagen y el botón
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                elevation: MaterialStateProperty.all<double>(15.0), 
                shadowColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.8)), 
              ) ,
              child: const Text('Iniciar', 
              style: TextStyle(fontSize: 25, color: AppColors.textColor),
              ),  
            ),
          ],
        ),
      ),
    );
  }
}
