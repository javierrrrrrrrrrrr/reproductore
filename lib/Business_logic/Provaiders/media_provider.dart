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
      audioSource.add(AudioSource.uri(
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
