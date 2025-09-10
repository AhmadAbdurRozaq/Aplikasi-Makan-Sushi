import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  List<dynamic> images = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    final url = Uri.parse('https://picsum.photos/v2/list?page=1&limit=5');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        images = json.decode(response.body);
      });
    } else {
      print('Failed to load images');
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.red.shade300,
                  child: Image.network(
                    image['download_url'],
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '"${image['author']}"',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _launchURL(image['download_url']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child: const Text(
                    'Download',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
