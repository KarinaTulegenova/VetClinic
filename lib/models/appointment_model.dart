class AppointmentModel {
  const AppointmentModel({
    required this.doctorName,
    required this.specialty,
    required this.image,
    required this.day,
    required this.time,
    required this.price,
  });

  final String doctorName;
  final String specialty;
  final String image;
  final String day;
  final String time;
  final String price;

  Map<String, String> toJson() {
    return {
      'doctorName': doctorName,
      'specialty': specialty,
      'image': image,
      'day': day,
      'time': time,
      'price': price,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      doctorName: json['doctorName'] as String? ?? '',
      specialty: json['specialty'] as String? ?? '',
      image: json['image'] as String? ?? '',
      day: json['day'] as String? ?? '',
      time: json['time'] as String? ?? '',
      price: json['price'] as String? ?? '',
    );
  }
}
