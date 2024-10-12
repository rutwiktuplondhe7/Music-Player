import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: "Khwab",
      artistName: "Iqlipdr Nova",
      albumArtImagePath: "assets/images/khwab.jpg",
      audioPath: "audio/Khwab.mp3",
    ),
    Song(
      songName: "Chaand Baaliyan",
      artistName: "Aditya A",
      albumArtImagePath: "assets/images/chandBaliya.jpg",
      audioPath: "audio/ChaandBaaliyan.mp3",
    ),
    Song(
      songName: "Choo lo",
      artistName: "The Local Train",
      albumArtImagePath: "assets/images/chooLo.jpg",
      audioPath: "audio/ChooLo.mp3",
    ),
    Song(
      songName: "Wishes",
      artistName: "Hasan Raheem, Umair and Talwiinder",
      albumArtImagePath: "assets/images/wishes.jpg",
      audioPath: "audio/Wishes.mp3",
    ),
  ];

  int? _currentSongIndex;

  //AUDIO PLAYERS

  //audio play
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  //pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        //if not the last song then increment by 1
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //go back to first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //list to duration
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen(
      (newDuration) {
        _totalDuration = newDuration;
        notifyListeners();
      },
    );

    //listen for current duration
    _audioPlayer.onPositionChanged.listen(
      (newPostion) {
        _currentDuration = newPostion;
        notifyListeners();
      },
    );

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen(
      (event) {
        playNextSong();
      },
    );
  }
  //dispose of the audio player

  //GETTERS
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  //SETTERS
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
