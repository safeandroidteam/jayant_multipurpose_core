import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ImageWidget extends StatefulWidget {
  final String? text;
  final bool isVideo;
  final File? imageFile;
  final VoidCallback? onTap;

  const ImageWidget({
    super.key,
    this.text,
    this.isVideo = false,
    this.imageFile,
    this.onTap,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo && widget.imageFile != null) {
      _initializeVideo();
    }
  }

  @override
  void didUpdateWidget(covariant ImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVideo && widget.imageFile?.path != oldWidget.imageFile?.path) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    _videoPlayerController?.dispose();
    _videoPlayerController = VideoPlayerController.file(widget.imageFile!)
      ..initialize().then((value) {
        setState(() {
          _videoPlayerController?.setLooping(true);
          _videoPlayerController?.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        if (widget.imageFile != null) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text(
                    widget.isVideo ? "Video Preview" : "Image Preview",
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child:
                        widget.isVideo
                            ? _videoPlayerController != null &&
                                    _videoPlayerController!.value.isInitialized
                                ? AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController!.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController!),
                                )
                                : const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                            : Image.file(
                              widget.imageFile!,
                              fit: BoxFit.contain,
                            ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        widget.onTap?.call(); // Re-capture
                      },
                      child: const Text("Recapture"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Just close
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
          );
        } else {
          widget.onTap?.call(); // No file — directly trigger capture
        }
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.text ?? "",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: w * 0.035,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: h * 0.15,
            width: w * 0.4,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child:
                widget.isVideo
                    ? _videoPlayerController != null &&
                            _videoPlayerController!.value.isInitialized
                        ? AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        )
                        : SizedBox(
                          height: 50,
                          child: Center(
                            child:
                                widget.isVideo
                                    ? Icon(Icons.videocam_outlined)
                                    : CircularProgressIndicator(),
                          ),
                        )
                    : widget.imageFile != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(widget.imageFile!, fit: BoxFit.cover),
                    )
                    : SizedBox(
                      height: 50,
                      child: Center(
                        child: Icon(
                          widget.isVideo
                              ? Icons.videocam_outlined
                              : Icons.camera_alt_outlined,
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

class PreviewScreen extends StatefulWidget {
  final File file;
  final bool isVideo;

  const PreviewScreen({super.key, required this.file, required this.isVideo});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.file(widget.file)
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
          _controller!.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isVideo ? "Video Preview" : "Image Preview"),
      ),
      body: Center(
        child:
            widget.isVideo
                ? _controller != null && _controller!.value.isInitialized
                    ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                    : const CircularProgressIndicator()
                : Image.file(widget.file),
      ),
    );
  }
}
