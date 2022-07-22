import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Constants/contants.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class ListReproduccionView extends StatelessWidget {
  final double height;
  final SongModel song;
  final int currentindex;
  const ListReproduccionView(
      {Key? key,
      required this.song,
      required this.currentindex,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();
    return SizedBox(
      width: height * 0.096,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: height * 0.014, vertical: 0.009),
        child: Row(
          children: [
            playerProvider.index == currentindex
                ? SizedBox(
                    height: height * 0.036,
                    width: height * 0.036,
                    child: const Image(
                      image: AssetImage('assets/play.gif'),
                    ),
                  )
                : Icon(
                    Icons.equalizer,
                    color: Colors.blue,
                    size: height * 0.040,
                  ),
            SizedBox(
              width: height * 0.006,
            ),
            SizedBox(
              width: height * 0.3,
              child: Text(
                '${song.artist!} - ${song.title} ',
                style: TextStyle(color: Colors.blue, fontSize: height * 0.025),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: height * 0.012,
            ),
            const Spacer(),
            Icon(
              Icons.close,
              color: const Color.fromRGBO(255, 255, 255, 0.8),
              size: height * 0.038,
            ),
            SizedBox(
              width: height * 0.014,
            ),
            Icon(
              Icons.menu,
              color: const Color.fromRGBO(255, 255, 255, 0.8),
              size: height * 0.038,
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
