import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';
import 'package:reproductor/UI/Screens/home_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color.fromRGBO(242, 235, 233, 1),
        width: width * 0.85,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(35))),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 200, top: 10),
              child: IconCloseDrawer(),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: AvatarSection(),
            ),
            Divider(
                indent: width * 0.06,
                endIndent: width * 0.06,
                thickness: 1,
                height: 50,
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
            const SizedBox(
              height: 18,
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
    return Row(
      children: [
        CircleAvatar(
          maxRadius: 30,
          backgroundColor: kprimarycolor,
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Nombre de usuario', style: TextStyle(fontSize: 20)),
            Text('Algo que se debe mostrar', style: TextStyle(fontSize: 12)),
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
