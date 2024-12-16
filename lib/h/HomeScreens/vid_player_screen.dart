// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:sourcecad_app/h/controllers/downloaded_vid_controller.dart';
// import 'package:video_player/video_player.dart';

// class PlayerPage extends StatelessWidget {
//   final bool isOnline;
//   final String videoUrl;

//   PlayerPage({super.key, required this.videoUrl, this.isOnline = false});

//   final VideoController videoController = Get.put(VideoController());

//   @override
//   Widget build(BuildContext context) {
//     // Initialize the video when the screen is opened
//     videoController.initialize(videoUrl, isNetwork: isOnline);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Obx(() {
//           if (!videoController.isInitialized.value) {
//             return const Center(
//                 child: CircularProgressIndicator(color: Colors.white));
//           }

//           return GestureDetector(
//             onTap: () {
//               videoController.isLocked.value = !videoController.isLocked.value;
//             },
//             child: Stack(
//               children: [
//                 Center(
//                   child: AspectRatio(
//                     aspectRatio:
//                         videoController.videoPlayerController.value.aspectRatio,
//                     child: VideoPlayer(videoController.videoPlayerController),
//                   ),
//                 ),
//                 if (!videoController.isLocked.value)
//                   Positioned.fill(
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Slider(
//                             value: videoController.currentSliderValue.value,
//                             min: 0,
//                             max: videoController.duration.value.inSeconds
//                                 .toDouble(),
//                             activeColor: const Color(0xff6F94F4),
//                             onChanged: (value) {
//                               videoController
//                                   .seekTo(Duration(seconds: value.toInt()));
//                             },
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   videoController.isPlaying.value
//                                       ? Icons.pause
//                                       : Icons.play_arrow,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: videoController.playPause,
//                               ),
//                               IconButton(
//                                 icon: Icon(
//                                   videoController.isMuted.value
//                                       ? Icons.volume_off
//                                       : Icons.volume_up,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: videoController.toggleMute,
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.fullscreen,
//                                     color: Colors.white),
//                                 onPressed: () {
//                                   if (MediaQuery.of(context).orientation ==
//                                       Orientation.portrait) {
//                                     SystemChrome.setPreferredOrientations([
//                                       DeviceOrientation.landscapeLeft,
//                                       DeviceOrientation.landscapeRight,
//                                     ]);
//                                   } else {
//                                     SystemChrome.setPreferredOrientations([
//                                       DeviceOrientation.portraitUp,
//                                       DeviceOrientation.portraitDown,
//                                     ]);
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sourcecad_app/h/controllers/downloaded_vid_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class PlayerPage extends StatefulWidget {
  final bool isOnline;
  final List<String> downloadedVideos;

  const PlayerPage(
      {Key? key, this.isOnline = false, required this.downloadedVideos})
      : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController controller;
  final isMuted = false.obs;
  final isLocked = false.obs;
  final isInitialized = false.obs;
  final currentSliderValue = 0.0.obs;
  double _currentSliderValue = 0;
  bool _showControls = true;
  final isPlaying = false.obs;

  @override
  void initState() {
    Get.put(VideoController());
    initialize();
    _hideControlsAfterDelay();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initialize() {
    if (widget.isOnline) {
      // Same as before for online videos
    } else {
      // For downloaded videos
      if (widget.downloadedVideos.isNotEmpty) {
        controller = VideoPlayerController.file(File(
            widget.downloadedVideos[0])) // Select the first video as default
          ..initialize().then((_) {
            if (controller.value.isInitialized) {
              setState(() {
                isInitialized.value = true;
              });
            } else {
              print("Error: Video failed to initialize.");
            }
          }).catchError((error) {
            print("Error initializing video: $error");
          });

        controller.addListener(() {
          if (controller.value.position == controller.value.duration) {
            Get.find<VideoController>().isPlaying.value = false;
          }
          setState(() {
            _currentSliderValue =
                controller.value.position.inSeconds.toDouble();
          });
        });
      } else {
        print("No downloaded videos available.");
      }
    }
  }

  void _seekForward10Seconds() {
    final newPosition = controller.value.position + const Duration(seconds: 10);
    if (newPosition < controller.value.duration) {
      controller.seekTo(newPosition);
    } else {
      controller.seekTo(controller.value.duration);
    }
  }

  void _seekBackward10Seconds() {
    final newPosition = controller.value.position - const Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      controller.seekTo(newPosition);
    } else {
      controller.seekTo(Duration.zero);
    }
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_showControls) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  void _showQualityDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Format',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              SizedBox(height: 10),
              Text('720',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              Text('480',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              Text('320',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            ],
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(builder: (video) {
      return PopScope(
        canPop: !video.isLocked.value,
        onPopInvoked: (val) async => !video.isLocked.value,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: video.isLocked.value
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.black,
                )
              : SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showControls = !_showControls;
              });
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    Center(
                      child: controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: Stack(
                                children: [
                                  VideoPlayer(controller),
                                  if (_showControls)
                                    Positioned.fill(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: _seekBackward10Seconds,
                                              child: Container(
                                                color: Colors.transparent,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Image.asset(
                                                    "lib/assets/backward.png",
                                                    height: 40,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (video.isPlaying.value) {
                                                  controller.pause();
                                                  video.isPlaying.value = false;
                                                  video.update();
                                                } else {
                                                  controller.play();
                                                  video.isPlaying.value = true;
                                                  video.update();
                                                }
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: video.isPlaying.value
                                                    ? Image.asset(
                                                        "lib/assets/big_pause.png",
                                                        height: 40,
                                                        color: Colors.white)
                                                    : Image.asset(
                                                        "lib/assets/big_play.png",
                                                        height: 40,
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: _seekForward10Seconds,
                                              child: Container(
                                                color: Colors.transparent,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Image.asset(
                                                    "lib/assets/forward.png",
                                                    height: 40,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white),
                    ),
                    if (_showControls)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            height: 100,
                            child: video.isLocked.value
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        style: IconButton.styleFrom(
                                            backgroundColor: Colors.white12,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7))),
                                        icon: const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: Colors.white),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      IconButton(
                                        style: IconButton.styleFrom(
                                            backgroundColor: video.isMuted.value
                                                ? Colors.white12
                                                : const Color(0xff6F94F4),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7))),
                                        icon: video.isMuted.value
                                            ? Image.asset(
                                                "lib/assets/unmute.png",
                                                height: 22,
                                                color: Colors.white)
                                            : Image.asset("lib/assets/mute.png",
                                                height: 22,
                                                color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            video.isMuted.value =
                                                !video.isMuted.value;
                                            controller.setVolume(
                                                video.isMuted.value ? 0 : 1);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                          SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                video.isLocked.value
                                    ? const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 23),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                _formatDuration(
                                                    controller.value.position),
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            Text(
                                                _formatDuration(
                                                    controller.value.duration),
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                video.isLocked.value
                                    ? const SizedBox()
                                    : Slider(
                                        min: 0,
                                        max: controller.value.duration.inSeconds
                                            .toDouble(),
                                        value: _currentSliderValue,
                                        onChanged: (value) {
                                          setState(() {
                                            controller.seekTo(Duration(
                                                seconds: value.toInt()));
                                          });
                                        },
                                        activeColor: const Color(0xff6F94F4),
                                        inactiveColor: Colors.white12,
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.white12,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7))),
                                      icon: const Icon(Icons.fast_rewind,
                                          color: Colors.white),
                                      onPressed: _seekBackward10Seconds,
                                    ),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.white12,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7))),
                                      icon: video.isPlaying.value
                                          ? Image.asset(
                                              "lib/assets/big_pause.png",
                                              height: 40,
                                              color: Colors.white)
                                          : Image.asset(
                                              "lib/assets/big_play.png",
                                              height: 40,
                                              color: Colors.white),
                                      onPressed: () {
                                        if (video.isPlaying.value) {
                                          controller.pause();
                                          video.isPlaying.value = false;
                                          video.update();
                                        } else {
                                          controller.play();
                                          video.isPlaying.value = true;
                                          video.update();
                                        }
                                      },
                                    ),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.white12,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7))),
                                      icon: const Icon(Icons.fast_forward,
                                          color: Colors.white),
                                      onPressed: _seekForward10Seconds,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: _showQualityDialog,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(7)),
                                child: const Text(
                                  "HD Quality",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
