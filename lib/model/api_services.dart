// lib/services/api_service.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sourcecad_app/h/controllers/course_detail_controller.dart';
import 'package:sourcecad_app/model/course_detail_model.dart';

class ApiService {
  final CoursesController controller = Get.put(CoursesController());

  Future<CourseModel?> fetchCourseDetails(vidId) async {
    var url = Uri.parse(
        'https://staging3.sourcecad.com/api/courses/courses.php?course_video_id=$vidId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return CourseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course details');
    }
  }
}
