// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sourcecad_app/h/controllers/course_detail_controller.dart';
// import 'package:sourcecad_app/h/controllers/faq_controller.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class CourseScreen extends StatelessWidget {
//   final int vidId;
//   CourseScreen({required this.vidId});
//   final CoursesController controller = Get.put(CoursesController());
//   // final FAQController faqController = Get.put(FAQController());
//   final GetStorage storage = GetStorage();

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchCourseDetails(vidId);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Course Details'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return _buildShimmerLoading();
//         }
//         return Column(
//           children: [
//             // Video Player
//             Obx(() {
//               return SizedBox(
//                 height: 200,
//                 width: double.infinity,
//                 child: controller.currentVideoUrl.value.isNotEmpty
//                     ? VideoWebView(
//                         url: controller.currentVideoUrl.value,
//                         key: ValueKey(controller.currentVideoUrl.value),
//                       )
//                     : Center(child: Text('No video to play')),
//               );
//             }),
//             // Download Button
//             ElevatedButton.icon(
//               onPressed: () async {
//                 final videoUrl = controller.currentVideoUrl.value;
//                 Text("videourl:${videoUrl}");

//                 if (videoUrl.isNotEmpty) {
//                   final result = await controller.downloadVideo(videoUrl);
//                   if (result != null) {
//                     Get.snackbar('Download Complete', 'Video saved at $result');
//                   } else {
//                     Get.snackbar('Error', 'Failed to download  $videoUrl');
//                   }
//                 } else {
//                   Get.snackbar('Error', 'No video URL to download');
//                 }
//               },
//               icon: Icon(Icons.download),
//               label: Text(
//                 'Download Video',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),

//             // Course Content
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.courseDetails.value.name ?? '',
//                       style:
//                           TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 16),
//                     ...controller.courseDetails.value.courseContents!
//                         .map((module) {
//                       return ExpansionTile(
//                         title: Text(module.moduleTitle ?? ''),
//                         children: module.lessons!.map((lesson) {
//                           final videoUrl = controller
//                               .processVideoUrl(lesson.videoSource ?? '');
//                           return ListTile(
//                             title: Text(lesson.lessonTitle ?? ''),
//                             trailing: IconButton(
//                               icon: Icon(Icons.play_arrow),
//                               onPressed: () {
//                                 controller.updateCurrentVideoUrl(videoUrl);
//                               },
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               ),
//             ),
//             // Obx(() {
//             //   if (faqController.isLoading.value) {
//             //     return Center(child: CircularProgressIndicator());
//             //   }
//             //   return Column(
//             //     children: [
//             //       SingleChildScrollView(
//             //         padding: EdgeInsets.all(16),
//             //         child: Column(
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           children: [
//             //             // Course Content (Insert your existing UI code here)

//             //             SizedBox(height: 24),
//             //             // FAQ Section
//             //             Text(
//             //               "Frequently Asked Questions",
//             //               style: TextStyle(
//             //                   fontSize: 18, fontWeight: FontWeight.bold),
//             //             ),
//             //             SizedBox(height: 8),
//             //             ...faqController.faqs.map((faq) {
//             //               return ExpansionTile(
//             //                 title: Text(faq["question"] ?? ""),
//             //                 children: [Text(faq["answer"] ?? "")],
//             //               );
//             //             }).toList(),

//             //             SizedBox(height: 24),
//             //             // Reviews Section
//             //             Text(
//             //               "Featured Reviews",
//             //               style: TextStyle(
//             //                   fontSize: 18, fontWeight: FontWeight.bold),
//             //             ),
//             //             SizedBox(height: 8),
//             //             ...faqController.reviews.map((review) {
//             //               return ListTile(
//             //                 title: Text(review["name"] ?? "",
//             //                     style: TextStyle(fontWeight: FontWeight.bold)),
//             //                 subtitle: Text(review["comment"] ?? ""),
//             //               );
//             //             }).toList(),
//             //           ],
//             //         ),
//             //       ),
//             //     ],
//             //   );
//             // }),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildShimmerLoading() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Container(
//               height: 200,
//               width: double.infinity,
//               color: Colors.grey[300],
//             ),
//           ),
//           SizedBox(height: 16),
//           // Other shimmer placeholders...
//         ],
//       ),
//     );
//   }
// }

// class VideoWebView extends StatefulWidget {
//   final String url;
//   const VideoWebView({required this.url, Key? key}) : super(key: key);

//   @override
//   State<VideoWebView> createState() => _VideoWebViewState();
// }

// class _VideoWebViewState extends State<VideoWebView> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();

//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }

//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('Page resource error: ${error.description}');
//           },
//         ),
//       );

//     // Set the controller and load the URL only if valid
//     if (widget.url.startsWith('http')) {
//       controller.loadRequest(Uri.parse(widget.url));
//     } else {
//       debugPrint('Invalid video URL: ${widget.url}');
//     }

//     _controller = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.url.startsWith('http')
//         ? WebViewWidget(controller: _controller)
//         : Center(
//             child: Text(
//               'Invalid video URL',
//               style: TextStyle(color: Colors.red, fontSize: 16),
//             ),
//           );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sourcecad_app/h/controllers/course_detail_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class CourseScreen extends StatelessWidget {
  final int vidId;
  CourseScreen({required this.vidId});
  final CoursesController controller = Get.put(CoursesController());
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    controller.fetchCourseDetails(vidId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerLoading();
        }
        return Column(
          children: [
            Obx(() {
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: controller.currentVideoUrl.value.isNotEmpty
                    ? VideoWebView(
                        url: controller.currentVideoUrl.value,
                        key: ValueKey(controller.currentVideoUrl.value),
                      )
                    : Center(child: Text('No video to play')),
              );
            }),
            ElevatedButton.icon(
              onPressed: () async {
                final videoUrl = controller.currentVideoUrl.value;

                if (videoUrl.isNotEmpty) {
                  final result = await controller.downloadVideo(videoUrl);
                  if (result != null) {
                    Get.snackbar('Download Complete', 'Video saved at $result');
                    print(result);
                  } else {
                    Get.snackbar('Error', 'Failed to download $videoUrl');
                  }
                } else {
                  Get.snackbar('Error', 'No video URL to download');
                }
              },
              icon: Icon(Icons.download),
              label:
                  Text('Download Video', style: TextStyle(color: Colors.black)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.courseDetails.value.name ?? '',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ...controller.courseDetails.value.courseContents!
                        .map((module) {
                      return ExpansionTile(
                        title: Text(module.moduleTitle ?? ''),
                        children: module.lessons!.map((lesson) {
                          final videoUrl = controller
                              .processVideoUrl(lesson.videoSource ?? '');
                          return ListTile(
                            title: Text(lesson.lessonTitle ?? ''),
                            trailing: IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: () {
                                controller.updateCurrentVideoUrl(videoUrl);
                              },
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class VideoWebView extends StatefulWidget {
  final String url;
  const VideoWebView({required this.url, Key? key}) : super(key: key);

  @override
  State<VideoWebView> createState() => _VideoWebViewState();
}

class _VideoWebViewState extends State<VideoWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: ${error.description}');
          },
        ),
      );

    if (widget.url.startsWith('http')) {
      controller.loadRequest(Uri.parse(widget.url));
    } else {
      debugPrint('Invalid video URL: ${widget.url}');
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return widget.url.startsWith('http')
        ? WebViewWidget(controller: _controller)
        : Center(
            child: Text(
              'Invalid video URL',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
  }
}