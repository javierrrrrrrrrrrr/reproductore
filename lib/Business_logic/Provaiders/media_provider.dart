import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MediaProvider extends ChangeNotifier {
  bool play = false;
  AudioPlayer? player;
  List<AudioSource> audioSource = [];
  SongModel? currentSong;
  int? index;
  MediaProvider(this.player);

  List<AudioSource> createPlayList(List<SongModel> songs) {
    audioSource.clear();
    songs.map((item) {
      print('Esta es la uri${item.uri} ');
      print('Esta es la data${item.data} ');
      audioSource.add(AudioSource.uri(
        tag: MediaItem(
            artUri: Uri.parse(item.uri!),
            id: item.id.toString(),
            title: item.title,
            album: item.album,
            artist: item.artist),
        Uri.parse(item.uri!),
      ));
    }).toList();
    notifyListeners();
    return audioSource;
  }

  shuffledMethod(bool shuffleModeEnabled) async {
    if (shuffleModeEnabled == true) {
      await player!.setShuffleModeEnabled(false);
    } else {
      await player!.setShuffleModeEnabled(true);
    }
  }

  toogleLoopSong(LoopMode loop) async {
    if (loop == LoopMode.off) {
      await player!.setLoopMode(LoopMode.one);
    } else {
      await player!.setLoopMode(LoopMode.off);
    }
  }

  SongModel? updateSongPlaying(List<SongModel> list) {
    player!.currentIndexStream.listen((index) {
      currentSong = list[index!];
      notifyListeners();
    });
    return currentSong;
  }

//   Changevalue(bool val) {
//     play = val;
//     notifyListeners();
//     return play;
//   }
}
