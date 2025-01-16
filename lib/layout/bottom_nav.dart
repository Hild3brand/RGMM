import 'package:flutter/material.dart';
import 'package:rgmm/main/add_schedule_page.dart';
import 'package:rgmm/main/main_page.dart';
import 'package:rgmm/main/schedule_page.dart';
import 'package:rgmm/main/upload_content_page.dart';
import 'package:rgmm/main/video_page.dart';

class BottomNav extends StatefulWidget {
  final String selectedPage; // Halaman yang dipilih

  const BottomNav({
    super.key,
    required this.selectedPage,
  });

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  // Elemen navigasi bawah
  final List<BottomNavigationBarItem> _allItems = const [
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Icon(Icons.home),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Icon(Icons.video_library),
      ),
      label: 'Video',
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.all(0),
        child: Icon(Icons.add_circle, size: 40),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Icon(Icons.calendar_today),
      ),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Icon(Icons.people),
      ),
      label: 'People',
    ),
  ];

  int _getSelectedIndex() {
    switch (widget.selectedPage) {
      case 'home':
        return 0;
      case 'video':
        return 1;
      case 'add':
        return 2;
      case 'calendar':
        return 3;
      case 'people':
        return 4;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Home
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 1: // Video
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                VideoPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 2: // Add
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Stack(
              children: [
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: AlertDialog(
                    backgroundColor: Colors.transparent,
                    actions: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const UploadContentPage(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Upload \nKonten',
                                style: TextStyle(
                                    color: Color(0xFF1788A8), fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 150,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const AddSchedulePage(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tambah \nJadwal',
                                    style: TextStyle(
                                        color: Color(0xFF1788A8), fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
        break;
      case 3: // Calendar
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SchedulePage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 4: // People
        // Add your logic for the "People" page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _allItems,
      currentIndex: _getSelectedIndex(),
      onTap: _onItemTapped,
      selectedItemColor: const Color.fromRGBO(33, 150, 243, 1),
      unselectedItemColor: const Color(0xFF1788A8),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed, // Hindari animasi shifting
    );
  }
}
