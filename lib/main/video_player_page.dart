import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoURL;

  const VideoPlayerPage({super.key, required this.videoURL});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  String? judul;
  String? pembicara;
  String? deskripsi;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoURL)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    fetchContent(widget.videoURL);
  }

  Future<void> fetchContent(String link) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('konten')
          .where('link', isEqualTo: link)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          deskripsi = snapshot.docs.first['deskripsi'];
          judul = snapshot.docs.first['judul'];
          pembicara = snapshot.docs.first['pembicara'];
        });
      } else {
        setState(() {
          deskripsi = 'No content found for link: $link';
        });
      }
    } catch (e) {
      setState(() {
        deskripsi = 'Error fetching content: $e';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              _controller.addListener(() {});
            },
          ),
          if (deskripsi != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Judul: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 350,
                        child: Text(
                          judul!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'Pembicara: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 200,
                        child: Text(
                          pembicara!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deskripsi: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: 425,
                        child: Text(
                          deskripsi!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
