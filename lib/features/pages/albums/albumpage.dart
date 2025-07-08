import 'package:flutter/material.dart';
import 'package:flutter_project/core/data/domain/models/album.dart';
import 'package:flutter_project/core/data/services/data_service.dart';
import 'album_content.dart';

class AlbumPage extends StatefulWidget {
  final int albumId;

  const AlbumPage({Key? key, required this.albumId}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  Album? album;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlbum();
  }

  Future<void> _loadAlbum() async {
    final dataService = DataService(baseUrl: 'https://corsproxy.io/?https://api.deezer.com');
    final response = await dataService.get('/album/${widget.albumId}');
    final fetchedAlbum = Album.fromJson(response);

    setState(() {
      album = fetchedAlbum;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : AlbumContent(album: album!),
    );
  }
}
