import 'package:flutter/material.dart';
import 'package:flutter_project/features/pages/search/search_content.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/services/data_service.dart';
import '../../../core/data/domain/controllers/audio_player_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final DataService dataService = DataService();

  List<AudioTrack> tracks = [];
  bool loading = false;
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Pop',
    'Rock',
    'Jazz',
    'Hip Hop',
  ];

  // Mappa dei generi Deezer e i loro ID ufficiali
  final Map<String, int> genreMap = {
    'Pop': 132,
    'Rock': 152,
    'Jazz': 129,
    'Hip Hop': 116,
  };

  @override
  void initState() {
    super.initState();
    _fetchTracks();
  }

  Future<void> _fetchTracks({String query = ''}) async {
    setState(() => loading = true);

    try {
      dynamic result;

      if (query.isNotEmpty) {
        // Se c'è una query, faccio sempre ricerca generica (ignoro il genere)
        result = await dataService.get('/search?q=${Uri.encodeComponent(query)}');
      } else {
        // Query vuota, uso filtro genere o top globali
        if (selectedCategory == 'All') {
          result = await dataService.get('/chart/0/tracks');
        } else {
          final genreId = genreMap[selectedCategory] ?? 0;
          result = await dataService.get('/chart/$genreId/tracks');
        }
      }

      final list = result['data'] as List;
      final loaded = list.map((e) => AudioTrack.fromJson(e)).toList();

      setState(() => tracks = loaded);
    } catch (e) {
      setState(() => tracks = []);
    }

    setState(() => loading = false);
  }

  void _onSearch(String query) => _fetchTracks(query: query);

  void _onCategorySelected(String category) {
    setState(() => selectedCategory = category);
    _fetchTracks(query: _controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioCtrl = context.watch<AudioPlayerController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SearchContent(
          controller: _controller,
          onSearch: _onSearch,
          loading: loading,
          tracks: tracks,
          categories: categories,
          selectedCategory: selectedCategory,
          onCategorySelected: _onCategorySelected,
          audioCtrl: audioCtrl,
        ),
      ),
    );
  }
}
