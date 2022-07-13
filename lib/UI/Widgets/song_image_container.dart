import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class SongImgContainer extends StatelessWidget {
  const SongImgContainer({
    Key? key,
  }) : super(key: key);

  get kprimarycolor => null;

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<MediaProvider>(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          StreamBuilder<int?>(
              stream: playerProvider.player!.currentIndexStream,
              builder: (context, snapshot) {
                return QueryArtworkWidget(
                  artworkFit: BoxFit.cover,
                  id: playerProvider.currentSong!.id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: MediaQuery.of(context).size.height * 0.4,
                  artworkWidth: double.infinity,
                  artworkBorder: const BorderRadius.all(Radius.circular(40)),
                );
              }),
          Align(
              alignment: const Alignment(.9, -0.85),
              child: Icon(
                shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
                Icons.favorite_border,
                size: 30,
                color: kprimarycolor,
              )),
        ],
      ),
    );
  }
}
