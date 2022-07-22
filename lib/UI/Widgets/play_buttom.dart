import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class PlayButton extends StatefulWidget {
  final double height;
  const PlayButton({
    Key? key,
    required this.playerProvider,
    required this.height,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();

    return StreamBuilder<bool>(
        stream: playerProvider.player!.playingStream,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return GestureDetector(
              onTap: () async {
                widget.playerProvider.player!.pause();
                setState(() {});
              },
              child: Icon(
                Icons.pause_circle_outline,
                color: const Color(0xffE4D1C1),
                size: widget.height * 0.13,
              ),
            );
          }
          if (snapshot.data == false) {
            return GestureDetector(
              onTap: () async {
                setState(() {});
                widget.playerProvider.player!.play();
              },
              child: Icon(
                Icons.play_circle_outline,
                color: const Color(0xffE4D1C1),
                size: widget.height * 0.13,
              ),
            );
          }

          return Container();
        });
  }
}
