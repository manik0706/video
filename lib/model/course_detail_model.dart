// To parse this JSON data, do
//
//     final clinicData = clinicDataFromJson(jsonString);

import 'dart:convert';

ClinicData clinicDataFromJson(String str) =>
    ClinicData.fromJson(json.decode(str));

String clinicDataToJson(ClinicData data) => json.encode(data.toJson());

class ClinicData {
  String? status;
  String? message;
  Body? body;

  ClinicData({
    this.status,
    this.message,
    this.body,
  });

  factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
        status: json["status"],
        message: json["message"],
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "body": body?.toJson(),
      };
}

class Body {
  String? name;
  String? description;
  String? videoSource;
  List<CourseContent>? courseContents;
  String? aboutCourse;

  Body({
    this.name,
    this.description,
    this.videoSource,
    this.courseContents,
    this.aboutCourse,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        name: json["name"],
        description: json["description"],
        videoSource: json["video_source"],
        courseContents: json["course_contents"] == null
            ? []
            : List<CourseContent>.from(
                json["course_contents"]!.map((x) => CourseContent.fromJson(x))),
        aboutCourse: json["about_course"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "video_source": videoSource,
        "course_contents": courseContents == null
            ? []
            : List<dynamic>.from(courseContents!.map((x) => x.toJson())),
        "about_course": aboutCourse,
      };
}

class CourseContent {
  String? moduleTitle;
  List<Lesson>? lessons;

  CourseContent({
    this.moduleTitle,
    this.lessons,
  });

  factory CourseContent.fromJson(Map<String, dynamic> json) => CourseContent(
        moduleTitle: json["module_title"],
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(
                json["lessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "module_title": moduleTitle,
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  String? lessonTitle;
  String? videoSource;

  Lesson({
    this.lessonTitle,
    this.videoSource,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        lessonTitle: json["lesson_title"],
        videoSource: json["video_source"],
      );

  Map<String, dynamic> toJson() => {
        "lesson_title": lessonTitle,
        "video_source": videoSource,
      };
}
