import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImageUploadWidgetAnswer extends StatefulWidget {
  final double width;
  final double height;
  final File? path;
  final void Function(File)? onImageSelected;

  const ImageUploadWidgetAnswer({Key? key, 
    required this.height,
    required this.width,
    this.path,
    this.onImageSelected,
  }): super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImageUploadWidgetStateAnswer createState() => _ImageUploadWidgetStateAnswer();
}

class _ImageUploadWidgetStateAnswer extends State<ImageUploadWidgetAnswer> {
  File? _imageFile;
  final picker = ImagePicker();
  
    @override
  void initState() {
    super.initState();
      _imageFile = widget.path;
  }
  
  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        if (widget.onImageSelected != null) {
          widget.onImageSelected!(_imageFile!);
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ошибка'),
          content: const Text('Произошла ошибка при выборе изображения.'),
          actions: [
            TextButton(
              child: const Text('ОК'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleWidth = screenWidth * widget.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double rectangleHeight = screenHeight * widget.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: rectangleWidth,
          height: rectangleHeight,
          decoration: const BoxDecoration(
            color: Color.fromARGB(156, 233, 229, 229),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: GestureDetector(
              onTap: _pickImage,
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      fit: BoxFit.fill,
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/add.svg',
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
