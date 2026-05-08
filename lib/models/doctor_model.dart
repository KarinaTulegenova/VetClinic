class DoctorModel {
  const DoctorModel({
    required this.name,
    required this.specialty,
    required this.image,
    required this.rating,
    required this.distance,
    required this.price,
    required this.experience,
  });

  final String name;
  final String specialty;
  final String image;
  final double rating;
  final String distance;
  final String price;
  final String experience;
}
