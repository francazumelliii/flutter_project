import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'package:flutter_project/core/data/domain/models/media_collection.dart';
import 'package:flutter_project/core/data/domain/controllers/audio_player_controller.dart';
import 'package:flutter_project/core/widgets/lists/track_list.dart';
import 'package:flutter_project/core/widgets/audio_player/global_audio_player.dart';
import 'package:flutter_project/features/pages/albums/collection_content.dart';
import 'package:flutter_project/features/pages/artists/artistpage.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  String searchType = 'track'; // 'track', 'album', 'playlist', 'artist'
  List<dynamic> results = [];
  bool isLoading = false;

  void _search() async {
    if (query.isEmpty) {
      setState(() {
        results = [];
      });
      return;
    }

    setState(() => isLoading = true);

    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/search/$searchType?q=$query');

    setState(() {
      results = response['data'] ?? [];
      isLoading = false;
    });
  }

  void _onResultTap(Map<String, dynamic> item) {
    final type = item['type'];
    final id = int.tryParse(item['id'].toString()) ?? 0;

    final audioController = context.read<AudioPlayerController>();

    if (type == 'track') {
      // Riproduci traccia singola
      audioController.setTracks([
        AudioTrack(
          imageUrl: item['album']?['cover_xl'] ?? '',
          title: item['title'] ?? '',
          subtitle: item['artist']?['name'] ?? '',
          audioPreviewUrl: item['preview'] ?? '',
        )
      ]);
      audioController.playTrack(0);
    } else if (type == 'album' || type == 'playlist') {
      final collection = MediaCollection(
        id: id,
        title: item['title'] ?? '',
        subtitle: (type == 'album')
            ? (item['artist']?['name'] ?? '')
            : (item['creator']?['name'] ?? ''),
        coverUrl: (type == 'album') ? item['cover_xl'] ?? '' : item['picture_xl'] ?? '',
        type: type,
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CollectionContent(collection: collection),
        ),
      );
    } else if (type == 'artist') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ArtistPage(artistId: id),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search Deezer',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: (val) {
            query = val;
          },
          onSubmitted: (val) {
            query = val;
            _search();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: _SearchTypeSelector(
            selectedType: searchType,
            onTypeSelected: (type) {
              setState(() {
                searchType = type;
                _search();
              });
            },
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : results.isEmpty
          ? const Center(child: Text('No results', style: TextStyle(color: Colors.white)))
          : ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(color: Colors.white24),
        itemBuilder: (context, index) {
          final item = results[index];
          return _SearchResultTile(
            item: item,
            onTap: () => _onResultTap(item),
          );
        },
      ),
      bottomNavigationBar: const GlobalAudioPlayer(),
    );
  }
}

class _SearchTypeSelector extends StatelessWidget {
  final String selectedType;
  final void Function(String) onTypeSelected;

  const _SearchTypeSelector({
    required this.selectedType,
    required this.onTypeSelected,
  });

  static const Map<String, String> types = {
    'track': 'Tracks',
    'album': 'Albums',
    'playlist': 'Playlists',
    'artist': 'Artists',
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: types.entries.map((entry) {
          final selected = entry.key == selectedType;
          return GestureDetector(
            onTap: () => onTypeSelected(entry.key),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF1DB954) : Colors.white12,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                entry.value,
                style: TextStyle(color: selected ? Colors.black : Colors.white),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _SearchResultTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final type = item['type'] ?? 'unknown';
    final title = item['title'] ?? '';
    final subtitle = (type == 'album' || type == 'playlist')
        ? (type == 'album'
        ? (item['artist']?['name'] ?? '')
        : (item['creator']?['name'] ?? ''))
        : (item['artist']?['name'] ?? '');

    final imageUrl = (type == 'album')
        ? (item['cover_small'] ?? '')
        : (type == 'playlist')
        ? (item['picture_small'] ?? '')
        : (item['artist']?['picture_small'] ?? '');

    return ListTile(
      onTap: onTap,
      leading: imageUrl.isNotEmpty
          ? ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      )
          : null,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      trailing: Text(type.toUpperCase(), style: const TextStyle(color: Colors.white54, fontSize: 12)),
    );
  }
}
