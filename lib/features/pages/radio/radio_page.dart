import 'package:flutter/material.dart';
import 'package:flutter_project/features/pages/radio/radio_content.dart';
import 'package:provider/provider.dart';

import '../../../core/data/services/data_service.dart';
import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/data/domain/models/audio_track.dart';


class ArtistRadioPage extends StatefulWidget {
  const ArtistRadioPage({
    super.key,
    required this.artistId,
    required this.artistName,
    required this.artistImageUrl,
  });

  final int artistId;
  final String artistName;
  final String artistImageUrl;

  @override
  State<ArtistRadioPage> createState() => _ArtistRadioPageState();
}

class _ArtistRadioPageState extends State<ArtistRadioPage> {
  bool loading = true;
  List<AudioTrack> radioTracks = [];

  @override
  void initState() {
    super.initState();
    _loadRadio();
  }

  Future<void> _loadRadio() async {
    final dataService = DataService();
    try {
      final radioData = await dataService.get('/artist/${widget.artistId}/radio');
      final loaded = (radioData['data'] as List).map((t) {
        final md5 = t['album']?['md5_image'];
        final cover = (md5 != null)
            ? 'https://e-cdns-images.dzcdn.net/images/cover/$md5/250x250-000000-80-0-0.jpg'
            : (t['album']?['cover_xl'] ?? '');
        return AudioTrack(
          title: t['title'] ?? '',
          subtitle: t['artist']?['name'] ?? '',
          imageUrl: cover ?? '',
          audioPreviewUrl: t['preview'] ?? '',
          albumId: t['album']?['id'] ?? 0,
          artistId: t['artist']?['id'] ?? 0,
        );
      }).toList();

      if (!mounted) return;
      setState(() {
        radioTracks = loaded;
        loading = false;
      });
      context.read<AudioPlayerController>().setPlaylist(loaded);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
      debugPrint('Errore radio artista: $e');
    }
  }

  void _onTrackSelected(int index) {
    context.read<AudioPlayerController>().playTrack(index);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Radio ${widget.artistName}')),
        backgroundColor: Colors.black,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return ArtistRadioContent(
      artistName: widget.artistName,
      artistImageUrl: widget.artistImageUrl,
      tracks: radioTracks,
      onTrackSelected: _onTrackSelected,
      onPlayAll: _onPlayAll,
    );
  }

  void _onPlayAll() {
    final audio = context.read<AudioPlayerController>();
    if (radioTracks.isEmpty) return;
    audio.playTrack(0);
  }
}
