import 'package:flutter/foundation.dart';

// blog and github for code *** EDIT THIS CODE ***
// https://suragch.medium.com/managing-playlists-in-flutter-with-just-audio-c4b8f2af12eb
// https://github.com/suragch/audio_playlist_flutter_demo

class RepeatButtonNotifier extends ValueNotifier<RepeatState> {
  RepeatButtonNotifier() : super(_initialValue);
  static const _initialValue = RepeatState.off;

  void nextState() {
    final next = (value.index + 1) % RepeatState.values.length;
    value = RepeatState.values[next];
  }
}

enum RepeatState {
  off,
  repeatSong,
  repeatPlaylist,
}
