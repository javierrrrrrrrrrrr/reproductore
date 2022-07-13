import 'package:flutter/material.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    Key? key,
    required this.playerProvider,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return widget.playerProvider.player!.playing == true
        ? GestureDetector(
            onTap: () async {
              widget.playerProvider.player!.pause();
              setState(() {});
            },
            child: const Icon(
              Icons.pause_circle_outline,
              color: Color(0xffE4D1C1),
              size: 100,
            ),
          )
        : GestureDetector(
            onTap: () async {
              setState(() {});
              widget.playerProvider.player!.play();
            },
            child: const Icon(
              Icons.play_circle_outline,
              color: Color(0xffE4D1C1),
              size: 100,
            ),
          );
  }
}
