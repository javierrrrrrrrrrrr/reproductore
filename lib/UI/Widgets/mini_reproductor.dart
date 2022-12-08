import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final playerProvider = context.read<MediaProvider>();
    return Container(
      height: size.height * 0.096,
      width: size.width,
      color: const Color.fromRGBO(19, 2, 19, 0.8),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.045,
          ),

          QueryArtworkWidget(
              artworkHeight: size.height * 0.08,
              artworkWidth: size.width * 0.18,
              artworkRepeat: ImageRepeat.noRepeat,
              keepOldArtwork: true,
              id: widget.playerProvider.currentSong!.id,
              type: ArtworkType.AUDIO),

          // const CircleAvatar(
          //   minRadius: 33,
          // ),
          // SizedBox(
          //   width: widget.size.height * 0.012,
          // ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<Duration>(
                  stream: widget.playerProvider.player!.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > const Duration(milliseconds: 1)) {
                        if (playerProvider.currentSong!.title.length > 30) {
                          return ScrollingTitle(playerProvider: playerProvider);
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(left: size.height * 0.01),
                            child: Text(
                              playerProvider.currentSong!.title,
                              style: const TextStyle(
                                  color: Color(0xffBDA7B7), fontSize: 21),
                            ),
                          );
                        }
                      }
                    }
                    return Container();
                  }),
              SizedBox(
                height: size.height * 0.007,
              ),
              StreamBuilder<Duration>(
                  stream: widget.playerProvider.player!.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > const Duration(milliseconds: 1)) {
                        return Container(
                          margin: EdgeInsets.only(left: size.height * 0.012),
                          width: size.width * 0.55,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.playerProvider.currentSong!.artist!,
                            style: TextStyle(
                                color: const Color(0xffBDA7B7),
                                fontSize: size.height * 0.02),
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
                      size: size.height * 0.05,
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
                      size: size.height * 0.05,
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

class ScrollingTitle extends StatelessWidget {
  const ScrollingTitle({
    Key? key,
    required this.playerProvider,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * 0.029,
        width: size.width * 0.55,
        child: Marquee(
          text: playerProvider.currentSong!.title,
          style: const TextStyle(color: Color(0xffBDA7B7), fontSize: 21),
          crossAxisAlignment: CrossAxisAlignment.center,
          scrollAxis: Axis.horizontal,
          blankSpace: 150,
          velocity: 25,
          pauseAfterRound: const Duration(seconds: 1),
          showFadingOnlyWhenScrolling: true,
          fadingEdgeStartFraction: 0.1,
          fadingEdgeEndFraction: 0.1,
          numberOfRounds: 150,
          startPadding: 0,
          accelerationDuration: const Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}
