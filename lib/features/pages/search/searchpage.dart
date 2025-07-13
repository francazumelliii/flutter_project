import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';

import 'package:flutter_project/core/data/services/data_service.dart';

import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/widgets/lists/list_item.dart';
import '../albums/albumpage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final DataService dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');

  List<AudioTrack> _tracks = [];
  bool _isLoading = false;

  Future<void> _searchTracks(String query) async {
    if (query.isEmpty) {
      setState(() {
        _tracks = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {

      final jsonData = await dataService.get('/search?q=$query');

      final List<AudioTrack> loadedTracks = (jsonData['data'] as List)
          .map((item) => AudioTrack.fromJson(item))
          .toList();

      setState(() {
        _tracks = loadedTracks;
      });
    } catch (e) {
      setState(() {
        _tracks = [];
      });
      // Qui puoi gestire meglio l'errore, es. showSnackbar
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioPlayerController>();
    final currentIndex = audioController.currentIndex;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search tracks...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          onSubmitted: _searchTracks,
          textInputAction: TextInputAction.search,
        ),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tracks.isEmpty
          ? const Center(child: Text('No results', style: TextStyle(color: Colors.white54)))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _tracks.length,
        separatorBuilder: (_, __) => const Divider(color: Colors.grey),
        itemBuilder: (context, index) {
          final track = _tracks[index];
          final isSelected = index == currentIndex;

          return TrackListItem(
            index: index,
            track: track,
            isSelected: isSelected,
            onTap: () {
              context.read<AudioPlayerController>().setTracks(_tracks);
              context.read<AudioPlayerController>().playTrack(index);
            },
            onAlbumTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AlbumPage(albumId: track.albumId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
