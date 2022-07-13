import 'package:flutter/material.dart';
import 'package:reproductor/Business_logic/Provaiders/media_provider.dart';
import 'package:reproductor/UI/Widgets/play_buttom.dart';

class MediaComandsButton extends StatelessWidget {
  const MediaComandsButton({
    Key? key,
    required this.playerProvider,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            playerProvider.player!.seek(
                playerProvider.player!.position - const Duration(seconds: 10));
          },
          child: const Icon(
            Icons.replay_10,
            color: Color(0xffB2A5AB),
            size: 50,
          ),
        ),
        GestureDetector(
          onTap: () {
            playerProvider.player!.seekToPrevious();
          },
          child: const Icon(
            Icons.skip_previous,
            color: Color(0xffB2A5AB),
            size: 50,
          ),
        ),
        PlayButton(playerProvider: playerProvider),
        GestureDetector(
          onTap: () async {
            await playerProvider.player!.seekToNext();
          },
          child: const Icon(
            Icons.skip_next,
            color: Color(0xffB2A5AB),
            size: 50,
          ),
        ),
        GestureDetector(
          onTap: () {
            playerProvider.player!.seek(
                playerProvider.player!.position + const Duration(seconds: 10));
          },
          child: const Icon(
            Icons.forward_10_sharp,
            color: Color(0xffB2A5AB),
            size: 50,
          ),
        ),
      ],
    );
  }
}
