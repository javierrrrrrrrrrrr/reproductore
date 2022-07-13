import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:reproductor/Constants/contants.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class MiniReproductor extends StatefulWidget {
  const MiniReproductor({
    Key? key,
    required this.playerProvider,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  State<MiniReproductor> createState() => _MiniReproductorState();
}

class _MiniReproductorState extends State<MiniReproductor> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(19, 2, 19, 0.8),
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),

          QueryArtworkWidget(
              artworkHeight: 65,
              artworkWidth: 65,
              artworkRepeat: ImageRepeat.noRepeat,
              keepOldArtwork: true,
              id: widget.playerProvider.currentSong!.id,
              type: ArtworkType.AUDIO),

          // const CircleAvatar(
          //   minRadius: 33,
          // ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<Duration>(
                  stream: widget.playerProvider.player!.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > const Duration(milliseconds: 1)) {
                        return ScrollingTitle(widget.playerProvider);
                      }
                    }

                    return Container();
                  }),
              const SizedBox(
                height: 6,
              ),
              StreamBuilder<Duration>(
                  stream: widget.playerProvider.player!.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > const Duration(milliseconds: 1)) {
                        return Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 220,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.playerProvider.currentSong!.artist!,
                            style: const TextStyle(
                                color: Color(0xffBDA7B7), fontSize: 16),
                            maxLines: 1,
                          ),
                        );
                      }
                    }

                    return Container();
                  }),
            ],
          ),

          StreamBuilder<bool?>(
              stream: widget.playerProvider.player!.playingStream,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return GestureDetector(
                    child: Icon(
                      Icons.pause,
                      color: kiconocolor,
                      size: 40,
                    ),
                    onTap: () {
                      widget.playerProvider.player!.pause();
                      setState(() {});
                    },
                  );
                }

                if (snapshot.data == false) {
                  return GestureDetector(
                    child: Icon(
                      Icons.play_arrow,
                      color: kiconocolor,
                      size: 40,
                    ),
                    onTap: () {
                      widget.playerProvider.player!.play();
                      setState(() {});
                    },
                  );
                }

                return Container();
              }),
        ],
      ),
    );
  }
}

Center ScrollingTitle(MediaProvider playerProvider) {
  return Center(
    child: SizedBox(
      height: 20,
      width: 220,
      child: Marquee(
        text: playerProvider.currentSong!.title,
        style: const TextStyle(color: Color(0xffBDA7B7), fontSize: 18),
        crossAxisAlignment: CrossAxisAlignment.center,
        scrollAxis: Axis.horizontal,
        blankSpace: 20,
        velocity: 25,
        pauseAfterRound: const Duration(seconds: 1),
        showFadingOnlyWhenScrolling: true,
        fadingEdgeStartFraction: 0.1,
        fadingEdgeEndFraction: 0.1,
        numberOfRounds: 150,
        startPadding: 10,
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    ),
  );
}
