import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/UI/Widgets/list_reproduccion_view.dart';

import '../../Business_logic/Provaiders/song_provider.dart';

class ModalPlayList extends StatelessWidget {
  const ModalPlayList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final queryProvider = context.read<QueryProvider>();

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
                return ListReproduccionView(
                  song: queryProvider.songsByAlbum[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
