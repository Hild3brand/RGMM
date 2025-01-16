import 'package:cloud_firestore/cloud_firestore.dart';

class Content {
  final String judul;
  final String pembicara;
  final String deskripsi;
  final String link;
  final Timestamp timestamp;

  Content({
    required this.judul,
    required this.pembicara,
    required this.deskripsi,
    required this.link,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'pembicara': pembicara,
      'deskripsi': deskripsi,
      'link': link,
      'timestamp': timestamp,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      judul: map['judul'],
      pembicara: map['pembicara'],
      deskripsi: map['deskripsi'],
      link: map['link'],
      timestamp: map['timestamp'],
    );
  }

  factory Content.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Content(
      judul: data['judul'],
      pembicara: data['pembicara'],
      deskripsi: data['deskripsi'],
      link: data['link'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'judul': judul,
      'pembicara': pembicara,
      'deskripsi': deskripsi,
      'link': link,
      'timestamp': timestamp,
    };
  }
}
