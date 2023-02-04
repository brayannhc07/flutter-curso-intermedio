import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;
  late AnimationController controller;

  Duration _songDuration = const Duration(microseconds: 0);
  Duration _currentSongDuration = const Duration(microseconds: 0);

  String get songTotalDuration => printDuration(_songDuration);
  String get currentSecond => printDuration(_currentSongDuration);

  double get porcentaje => _songDuration.inSeconds > 0
      ? _currentSongDuration.inSeconds / _songDuration.inSeconds
      : 0;

  bool get playing => _playing;
  set playing(bool value) {
    _playing = value;
    notifyListeners();
  }

  Duration get currentSongDuration => _currentSongDuration;
  set currentDuration(Duration value) {
    _currentSongDuration = value;
    notifyListeners();
  }

  Duration get songDuration => _songDuration;
  set songDuration(Duration value) {
    _songDuration = value;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      return n >= 10 ? "$n" : "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
