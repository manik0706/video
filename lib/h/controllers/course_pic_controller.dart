import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoursesPicController extends GetxController {
  var isLoading = true.obs;
  var courses = [].obs;

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(
            'https://staging3.sourcecad.com/api/courses/courses.php?courses=all'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          courses.value = data['body'];
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      isLoading(false);
    }
  }
}
