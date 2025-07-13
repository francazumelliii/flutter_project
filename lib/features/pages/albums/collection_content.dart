import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/widgets/albums/collection_header.dart';
import 'package:flutter_project/core/widgets/audio_player/global_audio_player.dart';
import 'package:flutter_project/core/widgets/lists/track_list.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/models/audio_track.dart';

class CollectionContent extends StatefulWidget {
  final MediaCollection collection;

  const CollectionContent({super.key, required this.collection});

  @override
  State<CollectionContent> createState() => _CollectionContentState();
}

class _CollectionContentState extends State<CollectionContent> {
  List<AudioTrack> tracks = [];

  @override
  void initState() {
    super.initState();
    _loadTracks();
  }

  Future<void> _loadTracks() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');

    final endpoint = widget.collection.type == 'album'
        ? '/album/${widget.collection.id}/tracks'
        : '/playlist/${widget.collection.id}/tracks';

    final response = await dataService.get(endpoint);

    if (response == null || response['data'] == null) {
      print('Nessuna traccia trovata.');
      return;
    }

    final List<dynamic> dataList = response['data'];

    final List<AudioTrack> loadedTracks = dataList.map((item) {
      return AudioTrack.fromJson(item);
    }).toList();

    setState(() => tracks = loadedTracks);
    context.read<AudioPlayerController>().setTracks(loadedTracks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, title: Text(widget.collection.title)),
      body: tracks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CollectionHeader(
              coverUrl: widget.collection.coverUrl,
              title: widget.collection.title,
              subtitle: widget.collection.subtitle,
              onPlayCollection: () {
                if (tracks.isNotEmpty) {
                  context.read<AudioPlayerController>().playTrack(0);
                }
              },
            ),
            TrackList(tracks: tracks),
          ],
        ),
      ),
      bottomNavigationBar: const GlobalAudioPlayer(),
    );
  }

}
