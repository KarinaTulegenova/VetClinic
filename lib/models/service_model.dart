class ServiceModel {
  const ServiceModel({
    required this.title,
    required this.image,
    this.subtitle,
    this.price = 0,
  });

  final String title;
  final String image;
  final String? subtitle;
  final int price;
}
