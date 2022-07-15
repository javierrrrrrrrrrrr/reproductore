import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              child: const Icon(
                Icons.pause_circle_outline,
                color: Color(0xffE4D1C1),
                size: 100,
              ),
            );
          }
          if (snapshot.data == false) {
            return GestureDetector(
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

          return Container();
        });
    // return widget.playerProvider.player!.playing == true
    // ? GestureDetector(
    //     onTap: () async {
    //       widget.playerProvider.player!.pause();
    //       setState(() {});
    //     },
    //     child: const Icon(
    //       Icons.pause_circle_outline,
    //       color: Color(0xffE4D1C1),
    //       size: 100,
    //     ),
    //   )
    // : GestureDetector(
    //     onTap: () async {
    //       setState(() {});
    //       widget.playerProvider.player!.play();
    //     },
    //     child: const Icon(
    //       Icons.play_circle_outline,
    //       color: Color(0xffE4D1C1),
    //       size: 100,
    //     ),
    //   );
  }
}
