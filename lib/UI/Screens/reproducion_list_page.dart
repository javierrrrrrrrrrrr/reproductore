import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Business_logic/Provaiders/media_provider.dart';

import 'package:reproductor/Business_logic/Provaiders/song_provider.dart';
import 'package:reproductor/Constants/contants.dart';
import 'package:reproductor/UI/Screens/media_control.dart';
import 'package:reproductor/UI/Widgets/menu_icons.dart';

import '../Widgets/custom_appbar.dart';
import '../Widgets/custom_drawer.dart';

class ReproductionList extends StatelessWidget {
  const ReproductionList({
    Key? key,
  }) : super(key: key);

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
            icon1: Icons.shuffle,
            icon2: Icons.repeat,
            icon3: Icons.add_circle_outline,
            icon4: Icons.sort_by_alpha,
          ),
          SizedBox(
            height: 20,
          ),
          PlayList(),
        ],
      )),
    );
  }
}

class PlayList extends StatelessWidget {
  const PlayList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: context.read<QueryProvider>().songsByAlbum.length,
          itemBuilder: (context, index) {
            return PlayListRow(
              index: index,
            );
          }),
    );
  }
}

class PlayListRow extends StatelessWidget {
  final int index;
  const PlayListRow({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();
    final queryProvider = context.read<QueryProvider>();
    return Row(
      children: [
        Icon(Icons.more_vert_rounded, color: kiconocolor, size: 60),
        GestureDetector(
          onTap: () async {
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
                initialIndex: index, initialPosition: Duration.zero);
            print(
                "-----------------Este es el audio source  ${playerProvider.player!.sequenceState!.currentIndex}");

            // await playerProvider!.setAudioSource(AudioSource.uri(
            //     Uri.parse(queryProvider.songsByAlbum[index].uri!)));

            playerProvider.player!.play();
            playerProvider.updateSongPlaying(queryProvider.songsByAlbum);

            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const MediaControl()),
              ),
            );
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
                    id: queryProvider.songsByAlbum[index].id,
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
                          queryProvider.songsByAlbum[index].title,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: kiconocolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          queryProvider.songsByAlbum[index].album!,
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
