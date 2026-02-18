
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';

Future<void> showCustomImagePicker({
  required BuildContext context,
  required Function(XFile pickedFile) onImagePicked,
}) async {
  final picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Choose from Gallery'),
          onTap: () async {
            final image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              onImagePicked(image);
            }
            final success = true;
            if (success) {
              ToastUtil.showShortToast("Image uploaded successfully.");
            }
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Take a Photo'),
          onTap: () async {
            final image = await picker.pickImage(source: ImageSource.camera);
            if (image != null) {
              onImagePicked(image);
            }
            final success = true;
            if (success) {
              ToastUtil.showShortToast("Image uploaded successfully.");
            }
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
