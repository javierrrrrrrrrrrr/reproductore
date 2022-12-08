import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Business_logic/Provaiders/song_provider.dart';

import 'custom_card.dart';

class AlbumGrid extends StatelessWidget {
  const AlbumGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<QueryProvider>(context);
    return Expanded(
        child: FutureBuilder<List<AlbumModel>>(
            future: provider.audioQuery.queryAlbums(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: AlbumSortType.NUM_OF_SONGS,
                uriType: UriType.EXTERNAL),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              }
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text('Nothing found'));
              }

              return GridView.builder(
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    left: size.width * 0.040,
                    right: size.width * 0.040,
                    top: size.height * 0.012),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 220,
                ),
                itemBuilder: (BuildContext context, index) {
                  return CustomCard(
                    id: snapshot.data![index].id,
                    cantSongs: snapshot.data![index].numOfSongs,
                    nameAlbum: snapshot.data![index].album,
                    artistName: snapshot.data![index].artist,
                  );
                },
              );
            }));
  }
}
