// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:sourcecad_app/h/HomeScreens/coursedetailscreen.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class DownloadsScreen extends StatelessWidget {
//   final GetStorage storage = GetStorage();

//   @override
//   Widget build(BuildContext context) {
//     final List<String> downloads =
//         storage.read<List<String>>('downloads') ?? [];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Downloaded Videos'),
//       ),
//       body: downloads.isNotEmpty
//           ? ListView.builder(
//               itemCount: downloads.length,
//               itemBuilder: (context, index) {
//                 final filePath = downloads[index];
//                 return ListTile(
//                   title: Text('Video ${index + 1}'),
//                   subtitle: Text(filePath),
//                   trailing: IconButton(
//                     icon: Icon(Icons.play_arrow),
//                     onPressed: () {
//                       Get.to(() => VideoPlayerScreen(filePath: filePath));
//                     },
//                   ),
//                 );
//               },
//             )
//           : Center(child: Text('No videos downloaded')),
//     );
//   }
// }

// class VideoPlayerScreen extends StatefulWidget {
//   final String filePath;

//   VideoPlayerScreen({required this.filePath});

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.filePath))
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Video Player')),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// class OfflineVideoScreen extends StatelessWidget {
//   final String videoPath;
//   OfflineVideoScreen({required this.videoPath});

//   @override
//   Widget build(BuildContext context) {
//     final fileUri = Uri.file(videoPath).toString();

//     return Scaffold(
//       appBar: AppBar(title: Text('Offline Video')),
//       body: VideoWebViews(url: fileUri),
//     );
//   }
// }

// class VideoWebViews extends StatefulWidget {
//   final String url;
//   const VideoWebViews({required this.url, Key? key}) : super(key: key);

//   @override
//   State<VideoWebViews> createState() => _VideoWebViewsState();
// }

// class _VideoWebViewsState extends State<VideoWebViews> {
//   WebViewController? _webController;
//   VideoPlayerController? _videoController;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.url.startsWith('http')) {
//       // Initialize WebView for online video
//       _webController = WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..loadRequest(Uri.parse(widget.url));
//     } else if (widget.url.startsWith('file://')) {
//       // Initialize VideoPlayer for local file
//       final filePath = widget.url.replaceFirst('file://', '');
//       if (File(filePath).existsSync()) {
//         _videoController = VideoPlayerController.file(File(filePath))
//           ..initialize().then((_) {
//             setState(() {}); // Update the widget after initialization
//             _videoController!.play();
//           });
//       } else {
//         debugPrint('File not found: $filePath');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_webController != null) {
//       // Render WebView for online videos
//       return WebViewWidget(controller: _webController!);
//     } else if (_videoController != null &&
//         _videoController!.value.isInitialized) {
//       // Render VideoPlayer for local videos
//       return AspectRatio(
//         aspectRatio: _videoController!.value.aspectRatio,
//         child: VideoPlayer(_videoController!),
//       );
//     } else if (_videoController != null) {
//       // Loading indicator for local videos
//       return Center(child: CircularProgressIndicator());
//     } else {
//       // Fallback for invalid URL or uninitialized controllers
//       return Center(
//         child: Text(
//           'Invalid video URL ',
//           style: TextStyle(color: Colors.red, fontSize: 16),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class DownloadedVideosScreen extends StatelessWidget {
  final GetStorage storage = GetStorage();

  DownloadedVideosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Safely cast to a List<String>
    final List<String> downloads = List<String>.from(
      storage.read<List<dynamic>>('downloads')?.whereType<String>() ?? [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Videos'),
      ),
      body: downloads.isEmpty
          ? Center(
              child: Text(
                'No downloaded videos available.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: downloads.length,
              itemBuilder: (context, index) {
                final filePath = downloads[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text('Video ${index + 1}'),
                    subtitle: Text(filePath),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        Get.to(() => VideoPlayerScreen(filePath: filePath));
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String filePath;

  const VideoPlayerScreen({required this.filePath, Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {}); // Refresh to show video once initialized
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
