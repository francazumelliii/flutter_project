import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/domain/models/audio_track.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/headers/collection_header/collection_header.dart';
import '../../../core/widgets/lists/track_list/track_list.dart';
import '../../../core/widgets/audio_player/global_audio_player.dart';

class CollectionContent extends StatefulWidget {
  final MediaCollection collection;

  const CollectionContent({super.key, required this.collection});

  @override
  State<CollectionContent> createState() => _CollectionContentState();
}

class _CollectionContentState extends State<CollectionContent> {
  List<AudioTrack> tracks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTracks();
  }

  void loadTracks() async {
    final dataService = DataService();
    String endpoint = '/album/${widget.collection.id}/tracks';

    if (widget.collection.type != 'album') {
      endpoint = '/playlist/${widget.collection.id}/tracks';
    }

    final result = await dataService.get(endpoint);

    if (result != null && result['data'] != null) {
      final List<dynamic> list = result['data'];
      final loadedTracks = list.map((e) => AudioTrack.fromJson(e)).toList();

      setState(() {
        tracks = loadedTracks;
        loading = false;
      });

      context.read<AudioPlayerController>().setPlaylist(loadedTracks);
    } else {
      setState(() {
        loading = false;
      });
      print('Nessuna traccia trovata');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.collection.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CollectionHeader(
            coverUrl: widget.collection.coverUrl,
            title: widget.collection.title,
            subtitle: widget.collection.subtitle,
            onPlay: () {
              if (tracks.isNotEmpty) {
                context.read<AudioPlayerController>().playTrack(0);
              }
            },
          ),
          Expanded(
            child: TrackList(tracks: tracks),
          ),
        ],
      ),
      bottomNavigationBar: const GlobalAudioPlayer(),
    );
  }
}
