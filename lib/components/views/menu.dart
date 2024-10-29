import 'package:flutter/material.dart';
import 'package:worldiscovery/screens/maps/view/maps.dart';
import 'package:worldiscovery/screens/sections/views/sections.dart';
import 'package:worldiscovery/styles/colors.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Inicio'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Buscar'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Secciones'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Sections()));
          },
        ),
        ListTile(
          title: const Text('Mapa'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MapView(placeType: 'museos',)));
          },
        ),
        ListTile(
          title: const Text('Cuenta y Configuración'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text(
            'Cerrar Sesión',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
