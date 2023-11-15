// ignore_for_file: depend_on_referenced_packages
import 'dart:math';
import 'package:codequiz/AppConstants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CircleImageWidget extends StatefulWidget {
  final double width;
  final double height;
  final Function()? onImageChanged;

  const CircleImageWidget({required this.width, required this.height, this.onImageChanged, super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CircleImageWidgetState createState() => _CircleImageWidgetState();
}

class _CircleImageWidgetState extends State<CircleImageWidget> {
  // ignore: unused_field
  File? _image;
  late String _savedImagePath;
  final String _defaultImagePath = 'assets/images/avatar.svg'; // Path to the default image
  // ignore: non_constant_identifier_names
  bool Check = false;

  final supabase = SupabaseClient(
    "https://itcswmslhtagkazkjuit.supabase.co",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0Y3N3bXNsaHRhZ2themtqdWl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMzY3NzYsImV4cCI6MjAxMzgxMjc3Nn0.Lj0GiKJXMkN2ixwCARaOVrenlvlPSppueBtOks7VR8s",
  );

  @override
  void initState() {
    super.initState();
    _loadSavedImagePath();
  }

  Future<void> _loadSavedImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedImagePath = prefs.getString('imagePath') ?? _defaultImagePath;
    _updateImage(File(_savedImagePath));
  }

  Future<void> _saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future<void> getImage() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      await _saveImagePath(pickedImage.path);
      _updateImage(File(pickedImage.path));
      await saveImageToSupabase(File(pickedImage.path));
      widget.onImageChanged?.call();
    }
  }

  Future<void> saveImageToSupabase(File imageFile) async {
    Random random = Random();
    String randomNumber = random.nextInt(100000000).toString().padLeft(9, '0');
    String img = "img $randomNumber";

    // ignore: unused_local_variable
    final response = await supabase.storage
        .from('images')
        .upload('images/$img.jpg', imageFile);

    final imageUrl = supabase.storage
        .from('images')
        .getPublicUrl('images/$img.jpg');
        AppConstants.url = imageUrl.characters.string;
        await updateUrlById(AppConstants.userID, AppConstants.url);
  }

  Future<void> updateUrlById(int userId, String imageUrl) async {
    final response = await supabase
        .from('Users')
        .update({'image': imageUrl})
        .eq('id', userId)
        // ignore: deprecated_member_use
        .execute();

    if (response.status == 200) {
      Fluttertoast.showToast(
        msg: "Ошибка при изменении аватарки",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Аватар пользователя успешно обновлен!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _updateImage(File file) {
    setState(() {
      _image = file;
    });
    if (mounted) {
    setState(() {});
  }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    if(AppConstants.url != "")
    {
      Check = true;
    }

    return Center(
      child: GestureDetector(
        onTap: getImage,
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
                child: Check
                    ? Image.network(
                        AppConstants.url,
                        fit: BoxFit.fill,
                      )
                    : SvgPicture.asset(
                        'assets/images/avatar.svg',
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