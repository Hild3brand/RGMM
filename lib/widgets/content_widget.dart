import 'package:flutter/material.dart';
import '../main/video_player_page.dart';
import '../models/content.dart';

class ContentWidget extends StatelessWidget {
  final Content content;

  const ContentWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoPlayerPage(videoURL: content.link),
                  ),
                );
              },
              child: Container(
                height: 175,
                width: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://img.youtube.com/vi/${content.link.split('v=')[1].split('&')[0]}/0.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(6, 9),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: const Icon(
                    Icons.play_circle_outline,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Text section on the right
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF1788A8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pembicara: ${content.pembicara}',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content.deskripsi,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
