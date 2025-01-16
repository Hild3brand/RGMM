import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadContentPage extends StatefulWidget {
  const UploadContentPage({super.key});

  @override
  State<UploadContentPage> createState() => _UploadContentPageState();
}

class _UploadContentPageState extends State<UploadContentPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _pembicaraController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? _selectedCategory;

  @override
  void dispose() {
    _judulController.dispose();
    _pembicaraController.dispose();
    _deskripsiController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Upload Konten',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1788A8),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF1788A8),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Judul',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _judulController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Tulis judul di sini..',
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text('Pembicara',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _pembicaraController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Tulis nama pembicara di sini..',
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Deskripsi',
                      style: TextStyle(
                          color: Color(0xFF1788A8),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _deskripsiController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan deskripsi..',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Unggah Video',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _linkController,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan link youtube..',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    hint: const Text('Pilih Kategori'),
                    value: _selectedCategory,
                    items: <String>[
                      'Inspirasi',
                      'Keluarga',
                      'Kategori Baru',
                      'Mujizat',
                      'Pertobatan',
                      'Kesetiaan'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String judul = _judulController.text;
                        String pembicara = _pembicaraController.text;
                        String deskripsi = _deskripsiController.text;
                        String link = _linkController.text;
                        String? kategori = _selectedCategory;

                        if (judul.isNotEmpty &&
                            pembicara.isNotEmpty &&
                            deskripsi.isNotEmpty &&
                            link.isNotEmpty &&
                            kategori != null) {
                          await firestore.collection('konten').add({
                            'judul': judul,
                            'pembicara': pembicara,
                            'deskripsi': deskripsi,
                            'link': link,
                            'kategori': kategori,
                            'timestamp': FieldValue.serverTimestamp(),
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Konten berhasil diunggah!'),
                            ),
                          );

                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Semua field harus diisi!'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1788A8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Upload Konten'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFF1788A8),
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
