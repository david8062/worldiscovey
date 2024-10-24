import 'package:flutter/material.dart';
import 'package:worldiscovery/components/views/menu.dart';
import 'package:worldiscovery/styles/colors.dart';

class Sections extends StatelessWidget {
  const Sections({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Secciones',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      drawer: const Drawer(
        child: Menu(),
      ),

    );
  }
}
