import 'package:flutter/material.dart';
import 'package:worldiscovery/components/views/menu.dart';
import 'package:worldiscovery/styles/colors.dart';

import '../../maps/view/maps.dart';

class Sections extends StatelessWidget {
  const Sections({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> textos = [
      'museum',
      'theatres',
      'shops',
      'cafe',
      'restaurant',
      'Bar'
    ];

    final List<String> images = [
      'assets/images/Museos.png',
      'assets/images/Museos.png',
      'assets/images/Teatro.png',
      'assets/images/Compras.png',
      'assets/images/Comida.png',
      'assets/images/Bares.png'
    ];

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
        body: Stack(children: [
          Positioned(
            top: 125,
            left: 0,
            right: 0,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 80.0,
              mainAxisSpacing: 80.0,
              padding: const EdgeInsets.all(20.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(textos.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapView(placeType: textos[index]),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          textos[index],
                          style: const TextStyle(
                              color: AppColors.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            top: 80, // Posición del primer Grid desde la parte superior
            left: 0, // Puedes ajustar esto según necesites
            right: 0,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 80.0,
              mainAxisSpacing: 80.0,
              padding: const EdgeInsets.all(20.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(images.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapView(placeType: textos[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.boxColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Image.asset(
                        images[index],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ]));
  }
}
