import 'package:flutter/material.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class StreamArtist extends StatelessWidget {
  final double height;
  const StreamArtist({
    Key? key,
    required this.playerProvider,
    required this.height,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int?>(
        stream: playerProvider.player!.currentIndexStream,
        builder: (context, snapshot) {
          return Center(
            child: Text(
              textAlign: TextAlign.center,
              playerProvider.currentSong!.artist!,
              style: TextStyle(
                  color: const Color(0xffBDA7B7),
                  fontSize: height * 0.03,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
