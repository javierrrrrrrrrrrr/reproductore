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
    final playerProvider = context.read<MediaProvider>();
    final queryProvider = context.read<QueryProvider>();
    return Row(
      children: [
        Icon(Icons.more_vert_rounded,
            color: kiconocolor, size: widget.height * 0.1),
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
                children:
                    playerProvider.createPlayList(queryProvider.songsByAlbum));

            await playerProvider.player!.setAudioSource(playlist,
                initialIndex: widget.index, initialPosition: Duration.zero);

            // await playerProvider!.setAudioSource(AudioSource.uri(
            //     Uri.parse(queryProvider.songsByAlbum[index].uri!)));

            playerProvider.player!.play();
            playerProvider.updateSongPlaying(queryProvider.songsByAlbum);
          },
          child: Container(
            height: widget.height * 0.1,
            width: widget.height * 0.38,
            decoration: BoxDecoration(
              color: kprimarycolor,
              borderRadius: BorderRadius.circular(widget.height * 0.01),
              border:
                  Border.all(width: widget.height * 0.001, color: kiconocolor),
            ),
            child: Row(
              children: [
                Container(
                  width: widget.height * 0.096,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.height * 0.01),
                        bottomLeft: Radius.circular(widget.height * 0.01)),
                    color: kiconocolor,
                  ),
                  child: QueryArtworkWidget(
                    artworkHeight: widget.height * 0.1,
                    artworkFit: BoxFit.cover,
                    artworkBorder: BorderRadius.only(
                        topLeft: Radius.circular(widget.height * 0.01),
                        bottomLeft: Radius.circular(widget.height * 0.01)),
                    id: queryProvider.songsByAlbum[widget.index].id,
                    type: ArtworkType.AUDIO,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: widget.height * 0.012),
                  child: SizedBox(
                    width: widget.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          queryProvider.songsByAlbum[widget.index].title,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: kiconocolor,
                              fontSize: widget.height * 0.021,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          queryProvider.songsByAlbum[widget.index].album!,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: kiconocolor,
                              fontSize: widget.height * 0.019,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.more_vert_rounded,
                  color: kiconocolor,
                  size: widget.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
