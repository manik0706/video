import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FAQController extends GetxController {
  var isLoading = true.obs;
  var faqs = <Map<String, String>>[].obs;
  var reviews = <Map<String, String>>[].obs;

  @override
  void onInit() {
    fetchFAQAndReviews();
    super.onInit();
  }

  Future<void> fetchFAQAndReviews() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(
            'https://staging3.sourcecad.com/api/courses/courses.php?courses=all'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Simulated FAQ Data
        faqs.assignAll([
          {
            "question": "What will I get with a free account?",
            "answer": "Access to free courses and materials."
          },
          {
            "question": "Do I need a credit card for free signup?",
            "answer": "No, credit card is not required."
          },
          {
            "question": "Can I cancel the subscription anytime?",
            "answer": "Yes, you can cancel anytime."
          },
        ]);

        // Simulated Reviews Data
        reviews.assignAll([
          {
            "name": "Hesham Tawfeek",
            "comment":
                "Courses I had completed are very comprehensive covering everything that I need to get started using AutoCAD."
          },
          {
            "name": "Sharon Anne Clark",
            "comment":
                "I used SourceCAD as supplementary practice for my AutoCAD course. After four months, I passed the certification!"
          },
        ]);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch FAQs or reviews.");
    } finally {
      isLoading(false);
    }
  }
}
