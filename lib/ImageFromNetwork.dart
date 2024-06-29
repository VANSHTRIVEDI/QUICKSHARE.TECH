import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageFromNetwork extends StatefulWidget {
  final String imageUrl;

  const ImageFromNetwork({super.key, required this.imageUrl});

  @override
  _ImageFromNetworkState createState() => _ImageFromNetworkState();
}

class _ImageFromNetworkState extends State<ImageFromNetwork> {
  late Uint8List _imageBytes = Uint8List(0); // Initialize to an empty Uint8List

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final response = await http.get(Uri.parse(widget.imageUrl));
      if (response.statusCode == 200) {
        setState(() {
          _imageBytes = response.bodyBytes;
        });
      } else {
        if (kDebugMode) {
          print("Failed to load image. Status code: ${response.statusCode}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("ERROR : ==>  $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _imageBytes.isNotEmpty
            ? Image.memory(
                _imageBytes,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
