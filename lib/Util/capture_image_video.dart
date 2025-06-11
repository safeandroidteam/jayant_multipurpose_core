import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class CaptureService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> captureImage() async {
    final status = await Permission.camera.request();
    alertPrint("Capturing Image");

    if (status.isGranted) {
      final XFile? file = await _picker.pickImage(source: ImageSource.camera);
      if (file == null) return null;
      warningPrint("Captured Image Path: ${file.path}");
      return File(file.path);
    } else if (status.isDenied) {
      
      warningPrint("Camera permission denied by user.");
      // Optionally show a dialog/snackbar here
    } else if (status.isPermanentlyDenied) {
      warningPrint(
        "Camera permission permanently denied. Ask user to open settings.",
      );
      await openAppSettings(); // opens the app settings
    }

    return null;
  }

  Future<File?> captureVideo() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
      return video != null ? File(video.path) : null;
    } else {
      throw Exception("Camera permission not granted");
    }
  }
}

class ImageUtils {
  /// Convert XFile to base64 after compression
  static Future<String?> compressXFileToBase64(File? xFile) async {
    if (xFile == null) return null;

    try {
      final originalFile = File(xFile.path);

      final dir = await getTemporaryDirectory();
      final targetPath =
          "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        targetPath,
        quality: 70,
      );

      if (compressedFile == null) return null;

      final bytes = await compressedFile.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      errorPrint("Compression/Base64 Error: $e");
      return null;
    }
  }
}

class VideoPreviewWidget extends StatefulWidget {
  final File videoFile;
  const VideoPreviewWidget({required this.videoFile, super.key});

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
        : const CircularProgressIndicator();
  }
}
