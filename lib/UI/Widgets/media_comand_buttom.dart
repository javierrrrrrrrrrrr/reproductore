import 'package:flutter/material.dart';
import 'package:reproductor/Business_logic/Provaiders/media_provider.dart';
import 'package:reproductor/UI/Widgets/play_buttom.dart';

class MediaComandsButton extends StatelessWidget {
  final double height;
  const MediaComandsButton({
    Key? key,
    required this.playerProvider,
    required this.height,
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
          child: Icon(
            Icons.replay_10,
            color: const Color(0xffB0A5A9),
            size: height * 0.055,
          ),
        ),
        GestureDetector(
          onTap: () {
            playerProvider.player!.seekToPrevious();
          },
          child: Icon(
            Icons.skip_previous,
            color: const Color(0xffB0A5A9),
            size: height * 0.085,
          ),
        ),
        PlayButton(
          playerProvider: playerProvider,
          height: height,
        ),
        GestureDetector(
          onTap: () async {
            await playerProvider.player!.seekToNext();
          },
          child: Icon(
            Icons.skip_next,
            color: const Color(0xffB0A5A9),
            size: height * 0.085,
          ),
        ),
        GestureDetector(
          onTap: () {
            playerProvider.player!.seek(
                playerProvider.player!.position + const Duration(seconds: 10));
          },
          child: Icon(
            Icons.forward_10_sharp,
            color: const Color(0xffB0A5A9),
            size: height * 0.055,
          ),
        ),
      ],
    );
  }
}
