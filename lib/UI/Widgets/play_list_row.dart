import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../Business_logic/Provaiders/media_provider.dart';
import '../../Business_logic/Provaiders/song_provider.dart';
import '../../Constants/contants.dart';

class PlayListRow extends StatefulWidget {
  final double height;
  final int index;
  const PlayListRow({
    Key? key,
    required this.index,
    required this.height,
  }) : super(key: key);

  @override
  State<PlayListRow> createState() => _PlayListRowState();
}

class _PlayListRowState extends State<PlayListRow> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final playerProvider = context.read<MediaProvider>();
    final queryProvider = context.read<QueryProvider>();
    return Padding(
      padding: EdgeInsets.only(left: size.height * 0.030),
      child: Row(
        children: [
          Icon(Icons.drag_indicator,
              color: kiconocolor, size: size.height * 0.07),
          GestureDetector(
            onTap: () async {
              setState(() {
                playerProvider.index = widget.index;
              });
              // Define the playlist
              final playlist = ConcatenatingAudioSource(
                  // Start loading next item just before reaching it
                  useLazyPreparation: true,
                  // Customise the shuffle algorithm
                  shuffleOrder: DefaultShuffleOrder(),
                  // Specify the playlist items
                  children: playerProvider
                      .createPlayList(queryProvider.songsByAlbum));

              await playerProvider.player!.setAudioSource(playlist,
                  initialIndex: widget.index, initialPosition: Duration.zero);

              // await playerProvider!.setAudioSource(AudioSource.uri(
              //     Uri.parse(queryProvider.songsByAlbum[index].uri!)));

              playerProvider.player!.play();
              playerProvider.updateSongPlaying(queryProvider.songsByAlbum);
            },
            child: Container(
              height: size.height * 0.1,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                color: kprimarycolor,
                borderRadius: BorderRadius.circular(size.height * 0.01),
                border:
                    Border.all(width: size.height * 0.001, color: kiconocolor),
              ),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size.height * 0.01),
                          bottomLeft: Radius.circular(size.height * 0.01)),
                      color: kiconocolor,
                    ),
                    child: QueryArtworkWidget(
                      artworkHeight: size.height * 0.2,
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.height * 0.01),
                                bottomLeft:
                                    Radius.circular(size.height * 0.01)),
                            color: kiconocolor,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/foto1.jpg',
                                ))),
                        height: size.height * 0.2,
                      ),
                      artworkBorder: BorderRadius.only(
                          topLeft: Radius.circular(size.height * 0.01),
                          bottomLeft: Radius.circular(size.height * 0.01)),
                      id: queryProvider.songsByAlbum[widget.index].id,
                      type: ArtworkType.AUDIO,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.03),
                    child: SizedBox(
                      width: size.width * 0.42,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            queryProvider.songsByAlbum[widget.index].title,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: kiconocolor,
                                fontSize: size.height * 0.021,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            queryProvider.songsByAlbum[widget.index].album!,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: kiconocolor,
                                fontSize: size.height * 0.019,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.more_vert_rounded,
                    color: kiconocolor,
                    size: size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
