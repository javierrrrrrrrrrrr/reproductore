import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:reproductor/Business_logic/Provaiders/media_provider.dart';

Center ScrollingTitle(MediaProvider playerProvider) {
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
      ),
    ),
  );
}
