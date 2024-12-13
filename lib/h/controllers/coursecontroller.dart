import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sourcecad_app/model/course_model.dart';

class CourseController extends GetxController {
  var courses = <Course>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchCourses(int courseId) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          'https://staging3.sourcecad.com/api/courses/courses.php?course_id=$courseId'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          courses.value = List<Course>.from(
              data['body'].map((course) => Course.fromJson(course)));
        }
      } else {
        print("Failed to fetch courses: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      isLoading(false);
    }
  }
}
