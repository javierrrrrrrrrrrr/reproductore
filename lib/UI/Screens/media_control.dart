import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Business_logic/Provaiders/media_provider.dart';
import 'package:reproductor/Constants/contants.dart';
import 'package:reproductor/UI/Widgets/simple_appbar.dart';

import '../Widgets/custom_drawer.dart';

class MediaControl extends StatefulWidget {
  const MediaControl({Key? key}) : super(key: key);

  @override
  State<MediaControl> createState() => _MediaControlState();
}

class _MediaControlState extends State<MediaControl> {
  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();
    bool useRtlText = false;

    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: kprimarycolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: SimpleAppbar(),
              ),
              const SongImgContainer(),
              StreamBuilder<int?>(
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
                  }),
              const SizedBox(height: 18),
              StreamBuilder<int?>(
                  stream: playerProvider.player!.currentIndexStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ScrollingTitle(playerProvider, useRtlText);
                    }
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    return Container();
                  }),
              const SizedBox(height: 40),
              CustomProgressBar(playerProvider: playerProvider),
              const SizedBox(height: 15),
              const BellowProgressBar(),
              const SizedBox(height: 35),
              MediaComandsButton(playerProvider: playerProvider)
            ],
          ),
        ),
      ),
    );
  }

  Center ScrollingTitle(MediaProvider playerProvider, bool useRtlText) {
    return Center(
      child: SizedBox(
        height: 30,
        child: Marquee(
          text: playerProvider.currentSong!.title,
          style: const TextStyle(color: Color(0xffBDA7B7), fontSize: 25),
          crossAxisAlignment: CrossAxisAlignment.center,
          scrollAxis: Axis.horizontal,
          blankSpace: 20,
          velocity: 25,
          pauseAfterRound: const Duration(seconds: 1),
          showFadingOnlyWhenScrolling: true,
          fadingEdgeStartFraction: 0.1,
          fadingEdgeEndFraction: 0.1,
          numberOfRounds: 50,
          startPadding: 10,
          accelerationDuration: const Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
          textDirection: useRtlText ? TextDirection.rtl : TextDirection.ltr,

          // child: Text(
          //   maxLines: 1,
          //   textAlign: TextAlign.center,
          //   playerProvider.currentSong!.title,
          //   style: const TextStyle(
          //       color: Color(0xffBDA7B7), fontSize: 25),
          // ),
        ),
      ),
    );
  }
}

class BellowProgressBar extends StatefulWidget {
  const BellowProgressBar({
    Key? key,
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
                    size: 30,
                  )
                : Icon(
                    Icons.arrow_forward,
                    color: kiconocolor,
                    size: 30,
                  )),
        const SizedBox(
          width: 10,
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
                    size: 30,
                  )
                : Icon(
                    Icons.repeat,
                    color: kiconocolor,
                    size: 30,
                  )),
        const Spacer(),
        Icon(
          Icons.queue_music,
          color: kiconocolor,
          size: 30,
        ),
      ],
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    Key? key,
    required this.playerProvider,
  }) : super(key: key);

  final MediaProvider playerProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
        stream: playerProvider.player!.positionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProgressBar(
              timeLabelPadding: 10,
              baseBarColor: const Color(0xffBDA7B7),
              timeLabelTextStyle: TextStyle(color: kiconocolor),
              progressBarColor: kiconocolor,
              thumbColor: kiconocolor,
              timeLabelLocation: TimeLabelLocation.above,
              /** No se usa en archivos locales */
              // buffered: playerProvider.player!.bufferedPosition,
              progress: Duration(seconds: snapshot.data!.inSeconds),
              total: Duration(
                  seconds: playerProvider.player!.duration == null
                      ? 0
                      : playerProvider.player!.duration!.inSeconds),
              onSeek: (duration) {
                playerProvider.player!
                    .seek(Duration(seconds: duration.inSeconds));
              },
            );
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return Container();
        });
  }
}

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
              widget.playerProvider.player!.play();
              setState(() {});
            },
            child: const Icon(
              Icons.play_circle_outline,
              color: Color(0xffE4D1C1),
              size: 100,
            ),
          );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class SongImgContainer extends StatelessWidget {
  const SongImgContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<MediaProvider>(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          StreamBuilder<int?>(
              stream: playerProvider.player!.currentIndexStream,
              builder: (context, snapshot) {
                return QueryArtworkWidget(
                  artworkFit: BoxFit.cover,
                  id: playerProvider.currentSong!.id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: MediaQuery.of(context).size.height * 0.4,
                  artworkWidth: double.infinity,
                  artworkBorder: const BorderRadius.all(Radius.circular(40)),
                );
              }),
          Align(
              alignment: const Alignment(.9, -0.85),
              child: Icon(
                shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
                Icons.favorite_border,
                size: 30,
                color: kprimarycolor,
              )),
        ],
      ),
    );
  }
}
