import 'package:flutter/material.dart';
import 'package:rgmm/layout/bottom_nav.dart';
import 'package:rgmm/main/add_schedule_page.dart';
import 'package:rgmm/main/notification_page.dart';
import 'package:rgmm/main/schedule_page.dart';
import 'package:rgmm/main/upload_content_page.dart';
import 'package:rgmm/main/video_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rgmm/auth_page/login_page.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'RGMM',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 28),
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, // Change this to your desired color
            ),
            backgroundColor: Color(0xFF1788A8),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const NotificationView(),
                      transitionDuration: Duration(milliseconds: 0),
                    ),
                  );
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF1788A8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/30097303/pexels-photo-30097303.jpeg',
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<String>(
                            future: _getUserEmail(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Text(
                                  snapshot.data ?? 'No username found',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            width: 128,
                            child: ElevatedButton(
                              onPressed: () async {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: Color(0xFF1788A8), fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.video_library),
                  title: Text('Lihat Video'),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            VideoPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_month_rounded),
                  title: Text('Lihat Jadwal'),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SchedulePage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people_alt_rounded),
                  title: Text('Lihat Partisipan'),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            VideoPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add_photo_alternate_outlined),
                  title: Text('Upload Konten'),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UploadContentPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.assignment_add),
                  title: Text('Tambah Jadwal'),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            AddSchedulePage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<String>(
                  future: _getUserEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        'Hello, ${snapshot.data}!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Upcoming Tasks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Scrollable Row untuk "Upcoming Tasks"
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTaskItem(
                        date: '23 Oktober 2024',
                        task: 'Shooting Konten Renungan "New Joy"',
                      ),
                      SizedBox(width: 16),
                      _buildTaskItem(
                        date: '25 Oktober 2024',
                        task: 'Post Konten Renungan "New Joy"',
                      ),
                      SizedBox(width: 16),
                      _buildTaskItem(
                        date: '28 Oktober 2024',
                        task: 'Review Konten "New Joy"',
                      ),
                      SizedBox(width: 16),
                      _buildTaskItem(
                        date: '30 Oktober 2024',
                        task: 'Live Streaming Renungan "New Joy"',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'My Task',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Card untuk "My Task"
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shooting Konten Renungan "New Joy"',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16),
                          SizedBox(width: 4),
                          Text('23 Oktober 2024'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16),
                          SizedBox(width: 4),
                          Text('11:00 AM - 13:00 PM'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.room, size: 16),
                          SizedBox(width: 4),
                          Text('Ruangan Studio Serafim'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNav(
            selectedPage: "home",
          )),
    );
  }

  Future<String> _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null) {
      throw Exception('User is not logged in');
    }
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data()?['username'] ?? 'No username found';
    } else {
      throw Exception('User document does not exist');
    }
  }

  Widget _buildTaskItem({required String date, required String task}) {
    return Container(
      width: 200, // Pastikan lebar konsisten
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1788A8),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            task,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
