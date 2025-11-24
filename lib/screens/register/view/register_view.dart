import 'package:flutter/material.dart';
import 'package:worldiscovery/styles/colors.dart';
import '../viewmodel/login_view_model.dart';
import '../viewmodel/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel registerViewModel = RegisterViewModel();
  final LoginViewModel loginViewModel = LoginViewModel();
  bool isLogin = true;
  bool termsAccepted = false;

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
              height: 200,
              child: const Center(
                child: Text("Bogota Discover")
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          isLogin ? 'Iniciar Sesión' : 'Registrarse',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: isLogin,
                          onChanged: (value) {
                            setState(() {
                              isLogin = value;
                            });
                          },
                          activeColor: AppColors.bottonColor,
                          inactiveThumbColor: AppColors.secondaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: isLogin
                            ? buildLoginForm(context, loginViewModel)
                            : buildRegisterForm(context, registerViewModel),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildRegisterForm(BuildContext context, RegisterViewModel registerViewModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        'Completa los datos para registrarse',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre ejemplo',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(Icons.person),
              ),
              onChanged: (value) => registerViewModel.setName(value),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'ejemplo@correo.com',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(Icons.email),
              ),
              onChanged: (value) => registerViewModel.setEmail(value),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: '1234',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(Icons.lock),
              ),
              onChanged: (value) => registerViewModel.setPassword(value),
              obscureText: true,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirmar Password',
                hintText: '1234',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(Icons.lock),
              ),
              onChanged: (value) => registerViewModel.setConfirmPassword(value),
              obscureText: true,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Celular',
                hintText: '1234567890',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(Icons.phone),
              ),
              onChanged: (value) => registerViewModel.setPhoneNumber(value),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => registerViewModel.register(context),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                elevation: MaterialStateProperty.all(15.0),
                shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.8)),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(fontSize: 25, color: AppColors.textColor),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLoginForm(BuildContext context, LoginViewModel loginViewModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        'Bienvenido a Bogota Discovery',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
              ),
              onChanged: (value) => loginViewModel.setEmail(value),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: '1234',
                hintStyle: TextStyle(color: Colors.grey),
                icon: Icon(Icons.lock),
              ),
              onChanged: (value) => loginViewModel.setPassword(value),
              obscureText: true,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => loginViewModel.login(context),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                elevation: MaterialStateProperty.all(15.0),
                shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.8)),
              ),
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 25, color: AppColors.textColor),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Clipper personalizado
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
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
