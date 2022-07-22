import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:reproductor/Constants/contants.dart';

import '../../Business_logic/Provaiders/media_provider.dart';

class MiniReproductor extends StatefulWidget {
  final double height;
  const MiniReproductor({
    Key? key,
    required this.playerProvider,
    required this.height,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  State<MiniReproductor> createState() => _MiniReproductorState();
}

class _MiniReproductorState extends State<MiniReproductor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.096,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(19, 2, 19, 0.8),
      child: Row(
        children: [
          SizedBox(
            width: widget.height * 0.026,
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
          SizedBox(
            width: widget.height * 0.012,
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
                        return scrollingTitle(
                            widget.playerProvider, widget.height);
                      }
                    }

                    return Container();
                  }),
              SizedBox(
                height: widget.height * 0.007,
              ),
              StreamBuilder<Duration>(
                  stream: widget.playerProvider.player!.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > const Duration(milliseconds: 1)) {
                        return Container(
                          margin: EdgeInsets.only(left: widget.height * 0.012),
                          width: widget.height * 0.3,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.playerProvider.currentSong!.artist!,
                            style: TextStyle(
                                color: const Color(0xffBDA7B7),
                                fontSize: widget.height * 0.02),
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
                      size: widget.height * 0.05,
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
                      size: widget.height * 0.05,
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

Center scrollingTitle(MediaProvider playerProvider, double height) {
  return Center(
    child: SizedBox(
      height: height * 0.024,
      width: height * 0.3,
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
