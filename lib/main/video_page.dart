import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rgmm/main/upload_content_page.dart';
import '../models/content.dart';
import '../widgets/content_widget.dart';
import '../layout/bottom_nav.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Inspirasi',
    'Keluarga',
    'Kategori Baru',
    'Mujizat',
    'Pertobatan',
    'Kesetiaan'
  ];

  Future<List<Content>> fetchContents() async {
    QuerySnapshot querySnapshot;
    if (_selectedCategory == 'All') {
      querySnapshot =
          await FirebaseFirestore.instance.collection('konten').get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('konten')
          .where('kategori', isEqualTo: _selectedCategory)
          .get();
    }
    return querySnapshot.docs.map((doc) => Content.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Konten RGMM',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF1788A8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Aksi untuk tombol search
              // Misalnya, Anda bisa membuka halaman pencarian di sini
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        value: _selectedCategory,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(
                            color: Color(0xFF1788A8), fontSize: 16),
                        underline: Container(
                          height: 2,
                          color: Color(0xFF1788A8),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                          });
                        },
                        items: _categories
                            .map<DropdownMenuItem<String>>((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const UploadContentPage(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: const Text(
                      'Add New',
                      style: TextStyle(color: Color(0xFF1788A8)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  FutureBuilder<List<Content>>(
                    future: fetchContents(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No content available'));
                      } else {
                        return Column(
                          children: snapshot.data!
                              .map((content) => Column(
                                    children: [
                                      ContentWidget(content: content),
                                      SizedBox(height: 20),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ],
                                  ))
                              .toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedPage: "video",
      ),
    );
  }
}
