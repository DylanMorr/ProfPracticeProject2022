import 'package:flutter/material.dart';

// blog and github for code *** EDIT THIS CODE ***
// https://suragch.medium.com/managing-playlists-in-flutter-with-just-audio-c4b8f2af12eb
// https://github.com/suragch/audio_playlist_flutter_demo

class PlayButtonNotifier extends ValueNotifier<ButtonState> {
  PlayButtonNotifier() : super(_initialValue);
  static const _initialValue = ButtonState.paused;
}

enum ButtonState {
  paused,
  playing,
  loading,
}
