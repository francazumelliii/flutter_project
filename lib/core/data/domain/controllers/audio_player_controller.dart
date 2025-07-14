import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

import '../models/audio_track.dart';

class AudioPlayerController with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  List<AudioTrack> _tracks = [];
  int _currentIndex = -1;
  bool _isPlaying = false;

  AudioPlayerController() {
    _player.playerStateStream.listen((state) {
      final playing = state.playing;
      if (playing != _isPlaying) {
        _isPlaying = playing;
        notifyListeners();
      }
    });
  }

  AudioPlayer get audioPlayer => _player;

  void setTracks(List<AudioTrack> tracks) {
    _tracks = tracks;
    _currentIndex = -1;
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> playTrack(int index) async {
    if (index < 0 || index >= _tracks.length) return;

    final url = _tracks[index].audioPreviewUrl;

    if (url.isEmpty) {
      print('URL is empty, cannot play.');
      return;
    }

    try {
      await _player.stop();
      _currentIndex = index;

      await _player.setUrl(url);
      await _player.play();
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      print('Errore nel playTrack: $e');
    }
  }


  Future<void> pause() async {
    await _player.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resume() async {
    await _player.play();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> nextTrack() async {
    if (_tracks.isEmpty) return;
    _currentIndex = (_currentIndex + 1) % _tracks.length;
    await playTrack(_currentIndex);
  }

  Future<void> previousTrack() async {
    if (_tracks.isEmpty) return;
    _currentIndex = (_currentIndex - 1 + _tracks.length) % _tracks.length;
    await playTrack(_currentIndex);
  }

  AudioTrack? get currentTrack =>
      (_currentIndex >= 0 && _currentIndex < _tracks.length)
          ? _tracks[_currentIndex]
          : null;

  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  List<AudioTrack> get tracks => List.unmodifiable(_tracks);

  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
