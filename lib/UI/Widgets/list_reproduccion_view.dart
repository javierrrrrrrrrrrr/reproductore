import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Constants/contants.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class ListReproduccionView extends StatelessWidget {
  final SongModel song;
  final int currentindex;
  const ListReproduccionView({
    Key? key,
    required this.song,
    required this.currentindex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.014, vertical: size.width * 0.0075),
        child: Row(
          children: [
            playerProvider.index == currentindex
                ? SizedBox(
                    height: size.height * 0.045,
                    width: size.width * 0.07,
                    child: const Image(
                      image: AssetImage('assets/music.gif'),
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.equalizer,
                    color: Colors.blue,
                    size: size.height * 0.040,
                  ),
            SizedBox(
              width: size.width * 0.006,
            ),
            SizedBox(
              width: size.width * 0.62,
              child: Text(
                '${song.artist!} - ${song.title} ',
                style: TextStyle(
                    color: Colors.blue, fontSize: size.height * 0.025),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: size.width * 0.012,
            ),
            const Spacer(),
            Icon(
              Icons.close,
              color: const Color.fromRGBO(255, 255, 255, 0.8),
              size: size.height * 0.038,
            ),
            SizedBox(
              width: size.width * 0.028,
            ),
            Icon(
              Icons.menu,
              color: const Color.fromRGBO(255, 255, 255, 0.8),
              size: size.height * 0.038,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    Key? key,
    required this.playerProvider,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
        stream: playerProvider.player!.positionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProgressBar(
              timeLabelPadding: 10,
              baseBarColor: const Color(0xffBDA7B7),
              timeLabelTextStyle: TextStyle(color: kiconocolor),
              progressBarColor: kiconocolor,
              thumbColor: kiconocolor,
              timeLabelLocation: TimeLabelLocation.above,
              /** No se usa en archivos locales */
              // buffered: playerProvider.player!.bufferedPosition,
              progress: Duration(seconds: snapshot.data!.inSeconds),
              total: Duration(
                  seconds: playerProvider.player!.duration == null
                      ? 0
                      : playerProvider.player!.duration!.inSeconds),
              onSeek: (duration) {
                playerProvider.player!
                    .seek(Duration(seconds: duration.inSeconds));
              },
            );
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Container();
        });
  }
}
