import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:reproductor/Business_logic/Provaiders/media_provider.dart';
import 'package:reproductor/Business_logic/Provaiders/song_provider.dart';
import 'package:reproductor/UI/Screens/home_page.dart';

Future<void> main() async {
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => QueryProvider(OnAudioQuery()),
      ),
      ChangeNotifierProvider(
        create: (_) => MediaProvider(AudioPlayer()),
        lazy: true,
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
