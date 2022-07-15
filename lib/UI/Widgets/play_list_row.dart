import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../Business_logic/Provaiders/media_provider.dart';
import '../../Business_logic/Provaiders/song_provider.dart';
import '../../Constants/contants.dart';

class PlayListRow extends StatefulWidget {
  final int index;
  const PlayListRow({
    Key? key,
    required this.index,
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
        Icon(Icons.more_vert_rounded, color: kiconocolor, size: 60),
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
            print(
                "-----------------Este es el audio source  ${playerProvider.player!.sequenceState!.currentIndex}");

            // await playerProvider!.setAudioSource(AudioSource.uri(
            //     Uri.parse(queryProvider.songsByAlbum[index].uri!)));

            playerProvider.player!.play();
            playerProvider.updateSongPlaying(queryProvider.songsByAlbum);

            // ignore: use_build_context_synchronously
          },
          child: Container(
            height: 90,
            width: 300,
            decoration: BoxDecoration(
              color: kprimarycolor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(width: 1.0, color: kiconocolor),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    color: kiconocolor,
                  ),
                  child: QueryArtworkWidget(
                    artworkHeight: 90,
                    artworkFit: BoxFit.cover,
                    artworkBorder: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    id: queryProvider.songsByAlbum[widget.index].id,
                    type: ArtworkType.AUDIO,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 172,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          queryProvider.songsByAlbum[widget.index].title,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: kiconocolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          queryProvider.songsByAlbum[widget.index].album!,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: kiconocolor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.more_vert_rounded,
                  color: kiconocolor,
                  size: 35,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
