// lib/controllers/course_controller.dart
import 'dart:io';

import 'package:get/get.dart';
import 'package:sourcecad_app/model/api_services.dart';
import 'package:sourcecad_app/model/course_detail_model.dart';
import 'package:video_player/video_player.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CoursesController extends GetxController {
  var isLoading = true.obs;
  var courseDetails = ClinicData().obs;
  VideoPlayerController? mainVideoController;
  var videoControllers = <String, VideoPlayerController>{}.obs;
  var currentVideoUrl = ''.obs; // Add this line
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchCourseDetails(vidId) async {
    try {
      isLoading(true);
      var details = await ApiService().fetchCourseDetails(vidId);
      if (details != null) {
        courseDetails.value = details;

        // Initialize the main video controller with a processed URL
        if (details.body?.videoSource != null &&
            details.body!.videoSource!.isNotEmpty) {
          mainVideoController = VideoPlayerController.network(
              processVideoUrl(details.body!.videoSource!));
        }

        _initializeVideoControllers();
      }
    } finally {
      isLoading(false);
    }
  }

  // Function to clean up and process the video URL
  String processVideoUrl(String url) {
    // Step 1: Clean up backslashes (remove "\/")
    String cleanedUrl = url.replaceAll(r'\/', '/');

    // Step 2: Change the word 'play' to 'embed'
    cleanedUrl = cleanedUrl.replaceAll('play', 'embed');

    // Step 3: Append .mp4 extension if necessary (example approach)
    // if (!cleanedUrl.endsWith('?autoplay=true')) {
    //   cleanedUrl += '?autoplay=true';
    // }

    return cleanedUrl;
  }

  void updateCurrentVideoUrl(String newUrl) {
    currentVideoUrl.value = newUrl;
  }

  // Future<String?> downloadVideo(String url) async {
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       final directory = await getApplicationDocumentsDirectory();
  //       final filePath =
  //           '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
  //       final file = File(filePath);
  //       await file.writeAsBytes(response.bodyBytes);

  //       // Save file path in GetStorage for later access
  //       final List<String> downloads =
  //           storage.read<List<String>>('downloads') ?? [];
  //       downloads.add(filePath);
  //       storage.write('downloads', downloads);

  //       return filePath;
  //     }
  //   } catch (e) {
  //     print('Download error: $e');
  //   }
  //   return null;
  // }
  Future<String?> downloadVideo(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Save file path in GetStorage for later access
        List<dynamic> downloads = storage.read('downloads') ?? [];
        downloads = downloads.cast<String>(); // Ensure type consistency
        downloads.add(filePath);
        storage.write('downloads', downloads);
        storage.write('downloadedVideoPath', filePath);
        print(filePath);

        return filePath;
      }
    } catch (e) {
      print('Download error: $e');
    }
    return null;
  }

  void _initializeVideoControllers() {
    // Initialize video controllers for each lesson with a video source
    for (var module in courseDetails.value.body?.courseContents ?? []) {
      for (var lesson in module.lessons ?? []) {
        if (lesson.videoSource != null && lesson.videoSource!.isNotEmpty) {
          videoControllers[lesson.lessonTitle ?? ""] =
              VideoPlayerController.network(
                  processVideoUrl(lesson.videoSource!));
        }
      }
    }
  }

  @override
  void onClose() {
    // Dispose video controllers
    mainVideoController?.dispose();
    for (var controller in videoControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}
