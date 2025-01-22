// ignore_for_file: use_build_context_synchronously asd

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// {@template UploadImageDialog}
/// Dialog to select the source of the image
///
/// Dialogo para seleccionar la fuente de la imagen
/// {@endtemplate}
class UploadImageDialog extends StatefulWidget {
  /// {@macro UploadImageDialog}
  const UploadImageDialog({
    required this.onImageSelected,
    super.key,
  });

  /// Callback to return the selected image
  final ValueChanged<XFile> onImageSelected;
  @override
  State<UploadImageDialog> createState() => _UploadImageDialogState();
}

class _UploadImageDialogState extends State<UploadImageDialog> {
  final picker = ImagePicker();

  late XFile? _image;

  Future<void> pickImageFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => _image = pickedFile);
      widget.onImageSelected(_image ?? XFile(''));
      Navigator.pop(context);
    }
  }

  // Function to capture an image using the camera
  Future<void> captureImageWithCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() => _image = pickedFile);
      widget.onImageSelected(_image ?? XFile(''));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 35,
                height: 3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageSourceOption(
                  onTap: () => pickImageFromGallery(context),
                  icon: Icons.image_outlined,
                  text: 'Galeria',
                ),
                ImageSourceOption(
                  onTap: () => captureImageWithCamera(context),
                  icon: Icons.camera_alt_outlined,
                  text: 'Camera',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template ImageSourceOption}
/// Widget to display an option to select the source of the image
/// {@endtemplate}
class ImageSourceOption extends StatelessWidget {
  /// {@macro ImageSourceOption}
  const ImageSourceOption({
    required this.onTap,
    required this.icon,
    required this.text,
    super.key,
  });

  /// Function to execute when the option is selected
  final void Function() onTap;

  /// Icon to display
  final IconData icon;

  /// Text to display
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
