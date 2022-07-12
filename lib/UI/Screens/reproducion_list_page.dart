import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Business_logic/Provaiders/song_provider.dart';
import 'package:reproductor/Constants/contants.dart';
import 'package:reproductor/UI/Screens/media_control.dart';
import 'package:reproductor/UI/Widgets/menu_icons.dart';
import '../../Business_logic/Provaiders/media_provider.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/custom_drawer.dart';
import '../Widgets/mini_reproductor.dart';
import '../Widgets/play_list_row.dart';

class ReproductionList extends StatefulWidget {
  const ReproductionList({
    Key? key,
  }) : super(key: key);

  @override
  State<ReproductionList> createState() => _ReproductionListState();
}

class _ReproductionListState extends State<ReproductionList> {
  @override
  bool play = false;

  @override
  Widget build(BuildContext context) {
    final playerProvider = context.read<MediaProvider>();
    return Scaffold(
      //key: ValueKey<bool>(playerProvider.player!.playing),

      drawer: const CustomDrawer(),
      backgroundColor: kprimarycolor,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              const CustomAppBar(),
              const MenuNavegacionIconos(
                icon1: Icons.shuffle,
                icon2: Icons.repeat,
                icon3: Icons.add_circle_outline,
                icon4: Icons.sort_by_alpha,
              ),
              const SizedBox(
                height: 20,
              ),
              const PlayList(),
              StreamBuilder<Duration>(
                  stream: playerProvider.player!.positionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! > const Duration(milliseconds: 1)) {
                        return GestureDetector(
                            onTap: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (context) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.964,
                                      child: const MediaControl()));
                            },
                            child: MiniReproductor(
                                playerProvider: playerProvider));
                      }
                    }

                    return Container();
                  }),
            ],
          ),

          // Builder(builder: (BuildContext context) {
          //   if (playerProvider.player!.playing == true) {
          //     return MiniReproductor(playerProvider: playerProvider).;
          //   } else {
          //     return Container();
          //   }
          //   //  setState(() {});
          // })

          // playerProvider.player!.playing == true
          //     ? MiniReproductor(playerProvider: playerProvider)
          //     : Container()
        ],
      )),
    );
  }
}

class PlayList extends StatelessWidget {
  const PlayList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: context.read<QueryProvider>().songsByAlbum.length,
          itemBuilder: (context, index) {
            return PlayListRow(
              index: index,
            );
          }),
    );
  }
}
