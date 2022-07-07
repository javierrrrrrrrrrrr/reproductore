import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class QueryProvider extends ChangeNotifier {
  OnAudioQuery audioQuery;
  List<SongModel> songsByAlbum = [];

  QueryProvider(this.audioQuery);

  Future<void> requestPermision() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
      }
      notifyListeners();
    }
  }

  Future<List<SongModel>> getSongFromAlbun(String albunName) async {
    List<SongModel> list = [];
    if (songsByAlbum.isNotEmpty) {
      songsByAlbum.clear();
    }
    list = await audioQuery.querySongs();
    list.map((song) {
      if (song.album == albunName) {
        songsByAlbum.add(song);
      }
    }).toList();
    notifyListeners();
    return songsByAlbum;
  }
}
