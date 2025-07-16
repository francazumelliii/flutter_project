import 'package:flutter/foundation.dart';
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

  void setPlaylist(List<AudioTrack> tracks) {
    _tracks = tracks;
    _currentIndex = -1;
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> playTrack(int index) async {
    if (index < 0 || index >= _tracks.length) return;

    final track = _tracks[index];
    if (track.audioPreviewUrl.isEmpty) {
      debugPrint('Impossibile riprodurre: URL non disponibile per "${track.title}"');
      return;
    }

    try {
      await _player.stop();
      _currentIndex = index;

      await _player.setUrl(track.audioPreviewUrl);
      await _player.play();

      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Errore durante la riproduzione di "${track.title}": $e');
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
    final nextIndex = (_currentIndex + 1) % _tracks.length;
    await playTrack(nextIndex);
  }

  Future<void> previousTrack() async {
    if (_tracks.isEmpty) return;
    final prevIndex = (_currentIndex - 1 + _tracks.length) % _tracks.length;
    await playTrack(prevIndex);
  }

  AudioTrack? get currentTrack {
    if (_currentIndex >= 0 && _currentIndex < _tracks.length) {
      return _tracks[_currentIndex];
    }
    return null;
  }

  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  List<AudioTrack> get tracks => List.unmodifiable(_tracks);

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
