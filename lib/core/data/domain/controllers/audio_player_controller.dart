import 'package:flutter/material.dart';

class AudioTrack {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String audioPreviewUrl;

  AudioTrack({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.audioPreviewUrl,
  });
}

/// CONTROLLER: gestisce lo stato del player e delle tracce
class AudioPlayerController with ChangeNotifier {
  List<AudioTrack> _tracks = [];
  int _currentIndex = -1;

  void setTracks(List<AudioTrack> tracks) {
    _tracks = tracks;
    _currentIndex = -1;
    notifyListeners();
  }

  void playTrack(int index) {
    if (index < 0 || index >= _tracks.length) return;
    _currentIndex = index;
    notifyListeners();
  }

  void nextTrack() {
    if (_tracks.isEmpty) return;
    _currentIndex = (_currentIndex + 1) % _tracks.length;
    notifyListeners();
  }

  void previousTrack() {
    if (_tracks.isEmpty) return;
    _currentIndex = (_currentIndex - 1 + _tracks.length) % _tracks.length;
    notifyListeners();
  }

  AudioTrack? get currentTrack =>
      (_currentIndex >= 0 && _currentIndex < _tracks.length)
          ? _tracks[_currentIndex]
          : null;

  int get currentIndex => _currentIndex;

  List<AudioTrack> get tracks => List.unmodifiable(_tracks);
}

