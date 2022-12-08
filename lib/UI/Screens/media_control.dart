import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Business_logic/Provaiders/media_provider.dart';
import 'package:reproductor/Constants/contants.dart';
import 'package:reproductor/UI/Widgets/list_reproduccion_view.dart';
import 'package:reproductor/UI/Widgets/media_comand_buttom.dart';
import 'package:reproductor/UI/Widgets/simple_appbar.dart';
import '../Widgets/below_progress_bar.dart';
import '../Widgets/custom_drawer.dart';
import '../Widgets/mini_reproductor.dart';
import '../Widgets/song_image_container.dart';
import '../Widgets/stream_artist.dart';

class MediaControl extends StatefulWidget {
  const MediaControl({Key? key}) : super(key: key);

  @override
  State<MediaControl> createState() => _MediaControlState();
}

class _MediaControlState extends State<MediaControl> {
  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: kprimarycolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SimpleAppbar(
                height: height,
              ),
            ),
            SongImgContainer(height: height),
            StreamArtist(playerProvider: playerProvider, height: height),
            const SizedBox(height: 18),
            StreamBuilder<int?>(
                stream: playerProvider.player!.currentIndexStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (playerProvider.currentSong!.title.length > 30) {
                      return ScrollingTitle(playerProvider: playerProvider);
                    } else {
                      return Text(
                        textAlign: TextAlign.center,
                        playerProvider.currentSong!.title,
                        style: const TextStyle(
                            color: Color(0xffBDA7B7), fontSize: 21),
                      );
                    }
                  }
                  if (snapshot.data == null) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                }),
            const SizedBox(height: 30),
            CustomProgressBar(playerProvider: playerProvider),
            const SizedBox(height: 15),
            const BellowProgressBar(),
            const SizedBox(height: 23),
            MediaComandsButton(
              playerProvider: playerProvider,
              height: height,
            )
          ],
        ),
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
