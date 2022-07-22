import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';
import 'package:reproductor/UI/Screens/home_page.dart';

class CustomDrawer extends StatelessWidget {
  final double height;
  const CustomDrawer({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color.fromRGBO(242, 235, 233, 1),
        width: height * 0.40,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(topRight: Radius.circular(height * 0.036))),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: height * 0.29, top: height * 0.012),
              child: const IconCloseDrawer(),
            ),
            Padding(
              padding: EdgeInsets.only(left: height * 0.024),
              child: AvatarSection(
                height: height,
              ),
            ),
            Divider(
                indent: width * 0.06,
                endIndent: width * 0.06,
                thickness: 1,
                height: height * 0.060,
                color: kprimarycolor),
            const CustomListTile(icono: Icons.home, texto: "Home"),
            const CustomListTile(
                icono: Icons.queue_music_sharp, texto: "Lista de reproduccion"),
            const CustomListTile(icono: Icons.favorite, texto: "Favoritos"),
            const CustomListTile(
                icono: Icons.download_sharp, texto: "Descrgar Musica"),
            const Spacer(),
            const CustomListTile(icono: Icons.settings, texto: "Ajustes"),
            const CustomListTile(icono: Icons.key, texto: "Privacidad"),
            SizedBox(
              height: height * 0.022,
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarSection extends StatelessWidget {
  final double height;
  const AvatarSection({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: height * 0.038,
          backgroundColor: kprimarycolor,
        ),
        SizedBox(
          width: height * 0.020,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre de usuario',
                style: TextStyle(fontSize: height * 0.028)),
            Text('Algo que se debe mostrar',
                style: TextStyle(fontSize: height * 0.016)),
          ],
        )
      ],
    );
  }
}

class IconCloseDrawer extends StatelessWidget {
  const IconCloseDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).closeDrawer(),
      child: Icon(
        Icons.menu_open,
        size: 60,
        color: kprimarycolor,
      ),
    );
  }
}
