import '../models/training_course_model.dart';

class TrainingCourseService {
  static final List<TrainingCourse> courses = [

    TrainingCourse(
      title: "Loose Leash Walking",
      trainerName: "Kikopup",
      youtubeUrl: "https://www.youtube.com/watch?v=sFgtqgiAKoQ",
      thumbnailUrl: "https://img.youtube.com/vi/sFgtqgiAKoQ/0.jpg",
    ),
    TrainingCourse(
      title: "Stop Pulling on Leash",
      trainerName: "McCann Dogs",
      youtubeUrl: "https://www.youtube.com/watch?v=CSFuxPZph1k",
      thumbnailUrl: "https://img.youtube.com/vi/CSFuxPZph1k/0.jpg",
    ),

  ];
}