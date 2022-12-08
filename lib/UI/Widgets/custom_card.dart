import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'package:reproductor/Business_logic/Provaiders/song_provider.dart';
import 'package:reproductor/Constants/contants.dart';

import '../Screens/reproducion_list_page.dart';

class CustomCard extends StatelessWidget {
  final String nameAlbum;
  final int cantSongs;
  final int id;
  final String? artistName;

  const CustomCard({
    Key? key,
    required this.nameAlbum,
    required this.cantSongs,
    required this.id,
    this.artistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<QueryProvider>(context);
    return GestureDetector(
      onTap: () async {
        List<SongModel> list = await provider.getSongFromAlbun(nameAlbum);

        list.map((e) => print(e.title)).toList();
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const ReproductionList()),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(size.height * 0.012),
          color: kprimarycolor,
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.001,
                  left: size.width * 0.001,
                  right: size.width * 0.001),
              height: size.height * 0.192,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.height * 0.012),
              ),
              child: QueryArtworkWidget(
                nullArtworkWidget:
                    Image.asset('assets/foto1.jpg', fit: BoxFit.cover),
                artworkBorder: BorderRadius.circular(size.height * 0.012),
                id: id,
                type: ArtworkType.ALBUM,
                artworkFit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: size.height * 0.036,
              left: size.height * 0.014,
              child: SizedBox(
                width: size.width * 0.40,
                child: Text(
                  nameAlbum,
                  style: TextStyle(
                      fontSize: size.height * 0.019,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            Positioned(
                bottom: size.height * 0.006,
                left: size.height * 0.014,
                child: Text(
                  '${cantSongs.toString()} pistas',
                  style: TextStyle(
                    fontSize: size.height * 0.019,
                    color: Colors.white,
                  ),
                )),
            Positioned(
                bottom: 0,
                right: size.height * 0.007,
                child: Icon(
                  Icons.queue_music_outlined,
                  size: size.height * 0.036,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
