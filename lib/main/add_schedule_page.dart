import 'package:flutter/material.dart';
import 'package:rgmm/layout/bottom_nav.dart';

class AddSchedulePage extends StatelessWidget {
  const AddSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text(
              'Tambah Jadwal',
              style: TextStyle(
                color: Color(0xFF1788A8),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption(
                icon: Icons.videocam,
                title: 'Rekaman',
                description: 'Atur jadwal shooting renungan.',
                onTap: () {
                  // Aksi untuk Rekaman
                },
              ),
              const SizedBox(height: 16),
              _buildOption(
                icon: Icons.edit,
                title: 'Edit Video',
                description: 'Atur jadwal untuk edit video konten renungan.',
                onTap: () {
                  // Aksi untuk Edit Video
                },
              ),
              const SizedBox(height: 16),
              _buildOption(
                icon: Icons.post_add,
                title: 'Post Konten',
                description: 'Atur jadwal posting konten video renungan.',
                onTap: () {
                  // Aksi untuk Post Konten
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(
          selectedPage: "add",
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF1788A8),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
