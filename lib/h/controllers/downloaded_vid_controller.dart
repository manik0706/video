import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  final isPlaying = false.obs;
  final isMuted = false.obs;
  final isLocked = false.obs;
  final isInitialized = false.obs;
  final currentSliderValue = 0.0.obs;
  final duration = Duration.zero.obs;

  // void initialize(String videoUrl, {bool isNetwork = true}) {
  //   videoPlayerController = isNetwork
  //       ? VideoPlayerController.networkUrl(Uri.parse(videoUrl))
  //       : VideoPlayerController.asset(videoUrl);

  //   videoPlayerController
  //     ..initialize().then((_) {
  //       isInitialized.value = true;
  //       duration.value = videoPlayerController.value.duration;
  //       update();
  //     })
  //     ..addListener(() {
  //       if (videoPlayerController.value.position ==
  //           videoPlayerController.value.duration) {
  //         isPlaying.value = false;
  //       }
  //       currentSliderValue.value =
  //           videoPlayerController.value.position.inSeconds.toDouble();
  //     });
  // }

  // void playPause() {
  //   if (isPlaying.value) {
  //     videoPlayerController.pause();
  //   } else {
  //     videoPlayerController.play();
  //   }
  //   isPlaying.value = !isPlaying.value;
  // }

  // void seekTo(Duration position) {
  //   videoPlayerController.seekTo(position);
  // }

  // void toggleMute() {
  //   isMuted.value = !isMuted.value;
  //   videoPlayerController.setVolume(isMuted.value ? 0 : 1);
  // }

  // @override
  // void onClose() {
  //   videoPlayerController.dispose();
  //   super.onClose();
  // }
}

class DownloadedVideosController extends GetxController {
  var downloadedVideos = <File>[].obs;

  Future<void> fetchDownloadedVideos() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync().whereType<File>().toList();
    downloadedVideos.assignAll(files);
  }
}
