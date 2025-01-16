import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rgmm/auth_page/forgot_password_page.dart';
import 'package:rgmm/auth_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 512,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Buat Akun',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 512,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 512,
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 512,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 512,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      'Lupa Password?',
                      style: TextStyle(color: Color(0xFF1788A8)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 512,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (!context.mounted) return;
                      showNotification(
                          context, 'Akun berhasil dibuat', Colors.green);
                      User? currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        await firestore
                            .collection('users')
                            .doc(currentUser.uid)
                            .set({
                          'uid': currentUser.uid,
                          'username': usernameController.text,
                          'email': emailController.text,
                        });
                      }
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (context.mounted) {
                        showNotification(
                            context, e.message.toString(), Colors.red);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showNotification(context,
                            'An unexpected error occurred', Colors.red);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Color(0xFF1788A8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Buat Akun',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '- Atau Lanjutkan Dengan -',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF1788A8), width: 2),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.g_mobiledata),
                      iconSize: 40,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF1788A8), width: 2),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.facebook,
                        size: 40,
                        color: Color(0xFF1788A8), // Change icon color if needed
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Separate the account creation text and button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah Punya Akun',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Color(0xFF1788A8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNotification(BuildContext context, String message, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: warna,
      content: Text(message.toString()),
    ));
  }
}
