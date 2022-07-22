import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Constants/contants.dart';

import '../../Business_logic/Provaiders/media_provider.dart';
import 'modal_playlist.dart';

class BellowProgressBar extends StatefulWidget {
  final double height;
  const BellowProgressBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  State<BellowProgressBar> createState() => _BellowProgressBarState();
}

class _BellowProgressBarState extends State<BellowProgressBar> {
  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<MediaProvider>(context);

    return Row(
      children: [
        GestureDetector(
            onTap: () async {
              await playerProvider
                  .shuffledMethod(playerProvider.player!.shuffleModeEnabled);
              await playerProvider.player!.shuffle();

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Shuffle ${playerProvider.player!.shuffleModeEnabled}")));
              setState(() {});
            },
            child: playerProvider.player!.shuffleModeEnabled
                ? Icon(
                    Icons.shuffle,
                    color: kiconocolor,
                    size: widget.height * 0.035,
                  )
                : Icon(
                    Icons.arrow_forward,
                    color: kiconocolor,
                    size: widget.height * 0.035,
                  )),
        SizedBox(
          width: widget.height * 0.012,
        ),
        GestureDetector(
            onTap: () {
              playerProvider.toogleLoopSong(playerProvider.player!.loopMode);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Reproducion continua ${playerProvider.player!.loopMode}")));
              setState(() {});
            },
            child: playerProvider.player!.loopMode == LoopMode.off
                ? Icon(
                    Icons.linear_scale_outlined,
                    color: kiconocolor,
                    size: widget.height * 0.036,
                  )
                : Icon(
                    Icons.repeat,
                    color: kiconocolor,
                    size: widget.height * 0.036,
                  )),
        const Spacer(),
        GestureDetector(
          child: Icon(
            Icons.queue_music,
            color: kiconocolor,
            size: widget.height * 0.036,
          ),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const ModalPlayList();
                });
          },
        ),
      ],
    );
  }
}
