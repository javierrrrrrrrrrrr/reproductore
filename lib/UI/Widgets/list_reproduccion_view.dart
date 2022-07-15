import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Constants/contants.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class ListReproduccionView extends StatelessWidget {
  final SongModel song;
  final int currentindex;
  const ListReproduccionView(
      {Key? key, required this.song, required this.currentindex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();
    return SizedBox(
      width: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            playerProvider.index == currentindex
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: Image(
                      image: AssetImage('assets/play.gif'),
                    ),
                  )
                : const Icon(
                    Icons.equalizer,
                    color: Colors.blue,
                    size: 30,
                  ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 248,
              child: Text(
                '${song.artist!} - ${song.title} ',
                style: const TextStyle(color: Colors.blue, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Spacer(),
            const Icon(
              Icons.close,
              color: Color.fromRGBO(255, 255, 255, 0.8),
              size: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.menu,
              color: Color.fromRGBO(255, 255, 255, 0.8),
              size: 30,
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
