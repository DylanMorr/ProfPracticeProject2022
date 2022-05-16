import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_project_2022/notifiers/play_button_notifier.dart';
import 'package:flutter_project_2022/notifiers/progress_notifier.dart';

// blog and github for code
// https://suragch.medium.com/managing-playlists-in-flutter-with-just-audio-c4b8f2af12eb
// https://github.com/suragch/audio_playlist_flutter_demo

// variable to hold song url
String? songURL;
String? songName;
String? artist;

class Player extends StatefulWidget {
  final String artist;
  final String title;
  final String url;
  final String image;

  Player(
      {required this.title,
      required this.artist,
      required this.url,
      required this.image});

  @override
  _PlayerState createState() => _PlayerState();
}

// use GetIt or Provider rather than a global variable in a real project
PageManager? _pageManager;

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();
    _init();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager?.dispose();
    super.dispose();
  }

  // instance of audio player
  AudioPlayer? _audioPlayer;

  void _init() async {
    String urlTest = widget.url;
    songName = widget.title;
    songURL = widget.url;
    artist = widget.artist;
    _audioPlayer = AudioPlayer();
    await _audioPlayer!.setUrl(urlTest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playing $songName"),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
      ),
      // main body of player page
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CurrentSongTitle(),
            AudioProgressBar(),
            AudioControlButtons(),
          ],
        ),
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return the current song title
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager!.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: TextStyle(fontSize: 20)),
        );
      },
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return an audio progress bar
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager!.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager!.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // only one child the play button
          PlayButton(),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return all different forms of the play button
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager!.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _pageManager!.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _pageManager!.pause,
            );
        }
      },
    );
  }
}

class PageManager {
  final currentSongTitleNotifier =
      ValueNotifier<String>('$songName - $artist');
  final progressNotifier = ProgressNotifier();
  final playButtonNotifier = PlayButtonNotifier();

  // get instance of audio player
  late AudioPlayer _audioPlayer;

  PageManager() {
    _init();
  }

  void _init() async {
    // create a url string and pass it song url variable
    String url = songURL!;
    // create an instance of audio player
    _audioPlayer = AudioPlayer();
    // set the url
    await _audioPlayer.setUrl(url);
    // listen for all changes
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
  }

  // look for any changes in the player state
  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      // check is playing
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      // it its loading or buffering show a loading icon
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        // else if not playing any song show pause icon
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        // else the playing icon
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  // listen for changes in the players position for the progress bar
  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  // listen for changes in buffer stream for progress bar
  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  // listen for changes in total duration for progress bar
  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void play() async {
    // call play method
    _audioPlayer.play();
  }

  void pause() {
    // call pause method
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    // call seek method with position
    _audioPlayer.seek(position);
  }

  void dispose() {
    // call dispose method
    _audioPlayer.dispose();
  }
}
