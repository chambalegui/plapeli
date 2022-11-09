import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerMenu extends StatefulWidget {
  final ValueSetter setIndex;
  const DrawerMenu({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          drawerList(Icons.home, "Cursos", 0),
          drawerList(Icons.shop, "Tienda", 1),
          drawerList(Icons.menu_book, "Terminos y condiciones", 2),
          drawerList(Icons.people, "Acerca de nosotros", 3),
          drawerList(Icons.exit_to_app, "Cerrar sesión", 4),
        ],
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        widget.setIndex(index);
        ZoomDrawer.of(context)?.close();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
