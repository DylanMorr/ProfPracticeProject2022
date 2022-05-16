import 'package:flutter/material.dart';

// blog and github for code
// https://suragch.medium.com/managing-playlists-in-flutter-with-just-audio-c4b8f2af12eb
// https://github.com/suragch/audio_playlist_flutter_demo

class ProgressNotifier extends ValueNotifier<ProgressBarState> {
  ProgressNotifier() : super(_initialValue);
  static const _initialValue = ProgressBarState(
    current: Duration.zero,
    buffered: Duration.zero,
    total: Duration.zero,
  );
}

class ProgressBarState {
  const ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}
