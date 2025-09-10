import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';

class ProfilePage extends StatefulWidget {
  final String nama;
  final String nbi;
  final String email;
  final String ig;
  final String alamat;

  const ProfilePage({
    super.key,
    required this.nama,
    required this.nbi,
    required this.email,
    required this.ig,
    required this.alamat,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('profileImagePath');
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = pickedFile.name;
      final savedImage = await File(
        pickedFile.path,
      ).copy('${directory.path}/$fileName');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', savedImage.path);

      setState(() {
        _imagePath = savedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFB3E5FC),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(250),
                    bottomRight: Radius.circular(250),
                  ),
                ),
              ),
              const Positioned(
                top: 50,
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            (_imagePath != null &&
                                    File(_imagePath!).existsSync())
                                ? FileImage(File(_imagePath!))
                                : null,
                        child:
                            (_imagePath == null ||
                                    !File(_imagePath!).existsSync())
                                ? const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.lightBlue,
                                )
                                : null,
                      ),
                    ),

                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Ubah Foto Profil',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ProfileItem(icon: Icons.person, text: widget.nama),
                ProfileItem(icon: Icons.phone, text: widget.nbi),
                ProfileItem(icon: Icons.email, text: widget.email),
                ProfileItem(icon: Icons.location_on, text: widget.alamat),
                ProfileItemFa(
                  icon: FontAwesomeIcons.instagram,
                  text: widget.ig,
                ),
              ],
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SplashScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.lightBlue),
        title: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class ProfileItemFa extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileItemFa({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: FaIcon(icon, color: Colors.lightBlue),
        title: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
