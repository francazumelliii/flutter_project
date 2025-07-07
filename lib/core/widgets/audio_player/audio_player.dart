import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String audioUrl;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const CustomAudioPlayer({
    super.key,
    required this.audioUrl,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _setUrl(widget.audioUrl);
  }

  @override
  void didUpdateWidget(covariant CustomAudioPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioUrl != widget.audioUrl) {
      _setUrl(widget.audioUrl);
    }
  }

  Future<void> _setUrl(String url) async {
    try {
      await _player.setUrl(url);
      _player.play();
    } catch (e) {
      print('Errore caricando audio: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest2<Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.durationStream,
            (position, duration) => PositionData(position, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(
          value: _player.duration == null || _player.duration!.inMilliseconds == 0
              ? 0
              : _player.position.inMilliseconds / _player.duration!.inMilliseconds,
          color: Colors.greenAccent,
          backgroundColor: Colors.white.withOpacity(0.2),
          minHeight: 5,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: widget.onPrevious,
              color: Colors.white,
            ),
            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final playing = playerState?.playing ?? false;
                if (playing) {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: _player.pause,
                    color: Colors.white,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: _player.play,
                    color: Colors.white,
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: widget.onNext,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration duration;
  PositionData(this.position, this.duration);
}
