// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class CircleImageWidget extends StatefulWidget {
  final double width;
  final double height;

  const CircleImageWidget({required this.width, required this.height});

  @override
  _CircleImageWidgetState createState() => _CircleImageWidgetState();
}

class _CircleImageWidgetState extends State<CircleImageWidget> {
  late File? _image = File("");
  late String _savedImagePath;
  final String _defaultImagePath = 'assets/images/avatar.svg'; // Путь к дефолтному изображению

  @override
  void initState() {
    super.initState();
    _loadSavedImagePath();
  }

  Future<void> _loadSavedImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedImagePath = prefs.getString('imagePath') ?? _defaultImagePath;
    setState(() {
      _image = File(_savedImagePath);
    });
  }

  Future<void> _saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future getImage() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      var imagePath = pickedImage.path;
      _saveImagePath(imagePath);
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return Center(
      child: GestureDetector(
        onTap: () {
          getImage();
        },
        child: Container(
          width: rectangleWidth,
          height: rectangleHeight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(202, 104, 117, 0),
          ),
         child: ClipOval(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: rectangleWidth,
                height: rectangleHeight,
                child: _image != null && _image!.path.isNotEmpty && _image!.existsSync()
                  ? Image.file(
                      _image!,
                      fit: BoxFit.fill,
                    )
                  : SvgPicture.asset(
                      _defaultImagePath,
                      fit: BoxFit.fill,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}