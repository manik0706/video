class Course {
  final int id;
  final String status;
  final String name;
  final String previewUrl;
  final String coverImage;
  final String avatarCover;
  final int difficulty;
  final int countLessons;
  final String courseSummary;

  Course({
    required this.id,
    required this.status,
    required this.name,
    required this.previewUrl,
    required this.coverImage,
    required this.avatarCover,
    required this.difficulty,
    required this.countLessons,
    required this.courseSummary,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['course_video_id'],
      status: json['status'],
      name: json['name'],
      previewUrl: json['preview_url'],
      coverImage: json['cover_image'],
      avatarCover: json['avatar_cover'],
      difficulty: json['difficulty'],
      countLessons: json['count_lessons'],
      courseSummary: json['course_summary'],
    );
  }
}
