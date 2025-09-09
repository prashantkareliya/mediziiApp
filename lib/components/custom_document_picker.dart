import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showFilePickerBottomSheet({
  required BuildContext context,
  required Function(List<String> paths) onFilesPicked,
}) async {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext ctx) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption(
              context,
              icon: Icons.camera_alt,
              label: "Camera",
              onTap: () async {
                Navigator.pop(ctx);
                var permission = await Permission.camera.request();
                if (permission.isGranted) {
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    onFilesPicked([pickedFile.path]);
                  }
                }
              },
            ),
            _buildOption(
              context,
              icon: Icons.photo_library,
              label: "Gallery",
              onTap: () async {
                Navigator.pop(ctx);
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: true,
                );
                if (result != null) {
                  final paths = result.paths.whereType<String>().toList();
                  onFilesPicked(paths);
                }
              },
            ),
            _buildOption(
              context,
              icon: Icons.insert_drive_file,
              label: "Document",
              onTap: () async {
                Navigator.pop(ctx);
                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
                if (result != null) {
                  final paths = result.paths.whereType<String>().toList();
                  onFilesPicked(paths);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildOption(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
  return ListTile(leading: Icon(icon, color: Theme.of(context).primaryColor), title: Text(label), onTap: onTap);
}
