import 'package:flutter/material.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class StreamArtist extends StatelessWidget {
  const StreamArtist({
    Key? key,
    required this.playerProvider,
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
              style: const TextStyle(
                  color: Color(0xffBDA7B7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
