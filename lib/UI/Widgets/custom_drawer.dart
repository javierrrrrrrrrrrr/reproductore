import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';
import 'package:reproductor/UI/Screens/home_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color.fromRGBO(242, 235, 233, 1),
        width: size.width * 0.90,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(size.height * 0.036))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: size.height * 0.29,
                  top: size.height * 0.018,
                  bottom: size.height * 0.025),
              child: const IconCloseDrawer(),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.height * 0.024),
              child: const AvatarSection(),
            ),
            Divider(
                indent: width * 0.06,
                endIndent: width * 0.06,
                thickness: 1,
                height: size.height * 0.060,
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
              height: size.height * 0.022,
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarSection extends StatelessWidget {
  const AvatarSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        CircleAvatar(
          maxRadius: size.height * 0.038,
          backgroundColor: kprimarycolor,
        ),
        SizedBox(
          width: size.width * 0.020,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre de usuario',
                style: TextStyle(fontSize: size.height * 0.028)),
            Text('Algo que se debe mostrar',
                style: TextStyle(fontSize: size.height * 0.016)),
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
        size: MediaQuery.of(context).size.width * 0.13,
        color: kprimarycolor,
      ),
    );
  }
}
