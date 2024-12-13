// lib/models/course_model.dart
class CourseModel {
  String? name;
  String? description;
  List<Module>? courseContents;

  CourseModel({this.name, this.description, this.courseContents});

  CourseModel.fromJson(Map<String, dynamic> json) {
    name = json['body']['name'];
    description = json['body']['description'];
    if (json['body']['course_contents'] != null) {
      courseContents = [];
      json['body']['course_contents'].forEach((v) {
        courseContents?.add(Module.fromJson(v));
      });
    }
  }

  get videoSource => null;
}

class Module {
  String? moduleTitle;
  List<Lesson>? lessons;

  Module({this.moduleTitle, this.lessons});

  Module.fromJson(Map<String, dynamic> json) {
    moduleTitle = json['module_title'];
    if (json['lessons'] != null) {
      lessons = [];
      json['lessons'].forEach((v) {
        lessons?.add(Lesson.fromJson(v));
      });
    }
  }
}

class Lesson {
  String? lessonTitle;
  String? videoSource;

  Lesson({this.lessonTitle, this.videoSource});

  Lesson.fromJson(Map<String, dynamic> json) {
    lessonTitle = json['lesson_title'];
    videoSource = json['video_source'];
  }
}
