import 'package:flutter/material.dart';
import 'package:worldiscovery/styles/colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              color: AppColors.backgroundColor,
              height: 200, // Ajusta la altura según lo que necesites
              child: Center(
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: 150, // Ajusta el tamaño de la imagen
                  height: 150,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            height: 500,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(15), // Bordes redondeados
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Color de la sombra
                  spreadRadius: 2, // Radio de expansión de la sombra
                  blurRadius: 5, // Radio de difuminado de la sombra
                  offset: const Offset(0, 3), // Desplazamiento de la sombra
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  isLogin ? 'Iniciar Sesión' : 'Registrarse',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                    width: 10), // Espaciado entre el texto y el Switch
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin =
                          !isLogin; // Cambia el estado al hacer clic en el Switch
                    });
                  },
                  child: SizedBox(
                    width: 60,
                    height: 30,
                    child: Switch(
                      value: isLogin,
                      onChanged: (value) {
                        setState(() {
                          isLogin = value;
                        });
                      },
                      activeColor: AppColors.bottonColor,
                      inactiveThumbColor: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Formulario dinámico
          isLogin ? buildLoginForm() : buildRegisterForm(),
        ],
      ),
    );
  }
}

Widget buildLoginForm() {
  return Container(
    child: const Text('Login Form'),
  );
}

Widget buildRegisterForm() {
  return Container(
    child: const Text('Register Form'),
  );
}

// Clipper personalizado para hacer la curva en la parte inferior del contenedor
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
