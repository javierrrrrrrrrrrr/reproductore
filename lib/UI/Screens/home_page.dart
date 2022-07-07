import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reproductor/Business_logic/Provaiders/song_provider.dart';
import 'package:reproductor/UI/Widgets/custom_drawer.dart';

import '../../Constants/contants.dart';
import '../Widgets/album_grid.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/menu_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<QueryProvider>().requestPermision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: kprimarycolor,
      body: SafeArea(
        child: Column(
          children: const [
            CustomAppBar(),
            MenuNavegacionIconos(
              icon1: Icons.create_new_folder_outlined,
              icon2: Icons.delete,
              icon3: Icons.file_download_outlined,
              icon4: Icons.list_alt,
            ),
            SizedBox(height: 20),
            AlbumGrid(),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String texto;
  final IconData icono;
  const CustomListTile({
    Key? key,
    required this.texto,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 10,
      leading: Icon(
        icono,
        size: 30,
        color: kprimarycolor,
      ),
      title: Padding(
        padding: const EdgeInsets.only(
          top: 6.0,
        ),
        child: Text(
          texto,
          style: TextStyle(fontSize: 18, color: kprimarycolor),
        ),
      ),
    );
  }
}
