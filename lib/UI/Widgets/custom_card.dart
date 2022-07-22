import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'package:reproductor/Business_logic/Provaiders/song_provider.dart';
import 'package:reproductor/Constants/contants.dart';

import '../Screens/reproducion_list_page.dart';

class CustomCard extends StatelessWidget {
  final double height;
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
    required this.height,
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
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(height * 0.012),
          color: kprimarycolor,
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: height * 0.003,
                  left: height * 0.003,
                  right: height * 0.003),
              height: height * 0.192,
              width: height * 0.199,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * 0.012),
              ),
              child: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(height * 0.012),
                id: id,
                type: ArtworkType.ALBUM,
              ),
            ),
            Positioned(
              bottom: height * 0.036,
              left: height * 0.014,
              child: SizedBox(
                width: height * 0.18,
                child: Text(
                  nameAlbum,
                  style: TextStyle(
                      fontSize: height * 0.019,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            Positioned(
                bottom: height * 0.006,
                left: height * 0.014,
                child: Text(
                  '${cantSongs.toString()} pistas',
                  style: TextStyle(
                    fontSize: height * 0.019,
                    color: Colors.white,
                  ),
                )),
            Positioned(
                bottom: 0,
                right: height * 0.007,
                child: Icon(
                  Icons.queue_music_outlined,
                  size: height * 0.036,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
