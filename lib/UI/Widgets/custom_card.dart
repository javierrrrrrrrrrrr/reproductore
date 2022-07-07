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
        // height: 200,
        // width: 162,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: kprimarycolor,
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 3, left: 3, right: 3),
              height: 160,
              width: 162,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(10),
                id: id,
                type: ArtworkType.ALBUM,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 12,
              child: SizedBox(
                width: 150,
                child: Text(
                  nameAlbum,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            Positioned(
                bottom: 5,
                left: 12,
                child: Text(
                  '${cantSongs.toString()} pistas',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
            const Positioned(
                bottom: 0,
                right: 6,
                child: Icon(
                  Icons.queue_music_outlined,
                  size: 30,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
