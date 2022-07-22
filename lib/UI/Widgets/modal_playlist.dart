import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/UI/Widgets/list_reproduccion_view.dart';

import '../../Business_logic/Provaiders/media_provider.dart';
import '../../Business_logic/Provaiders/song_provider.dart';

class ModalPlayList extends StatefulWidget {
  const ModalPlayList({
    Key? key,
  }) : super(key: key);

  @override
  State<ModalPlayList> createState() => _ModalPlayListState();
}

class _ModalPlayListState extends State<ModalPlayList> {
  @override
  Widget build(BuildContext context) {
    final queryProvider = context.read<QueryProvider>();
    final playerProvider = context.read<MediaProvider>();
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(78, 9, 78, 0.8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.shuffle,
                  color: Colors.blue,
                  size: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Aleatorio - ',
                  style: TextStyle(color: Colors.blue, fontSize: 19),
                ),
                Text(
                  queryProvider.songsByAlbum.length > 1
                      ? '${queryProvider.songsByAlbum.length} pistas'
                      : '${queryProvider.songsByAlbum.length} pista',
                  style: const TextStyle(color: Colors.white, fontSize: 19),
                ),
                const Spacer(),
                const Icon(
                  Icons.playlist_add,
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  size: 35,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  Icons.delete,
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  size: 35,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: queryProvider.songsByAlbum.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      playerProvider.index = index;
                    });
                    /**roger es el mimso codigo que al seleccionar 
                     * ver como organizar para no repetirlo
                     * 
                     */
                    final playlist = ConcatenatingAudioSource(
                        // Start loading next item just before reaching it
                        useLazyPreparation: true,
                        // Customise the shuffle algorithm
                        shuffleOrder: DefaultShuffleOrder(),
                        // Specify the playlist items
                        children: playerProvider
                            .createPlayList(queryProvider.songsByAlbum));

                    await playerProvider.player!.setAudioSource(playlist,
                        initialIndex: index, initialPosition: Duration.zero);
                    print(
                        "-----------------Este es el audio source  ${playerProvider.player!.sequenceState!.currentIndex}");

                    // await playerProvider!.setAudioSource(AudioSource.uri(
                    //     Uri.parse(queryProvider.songsByAlbum[index].uri!)));

                    playerProvider.player!.play();
                    playerProvider
                        .updateSongPlaying(queryProvider.songsByAlbum);
                  },
                  child: ListReproduccionView(
                    height: height,
                    song: queryProvider.songsByAlbum[index],
                    currentindex: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
