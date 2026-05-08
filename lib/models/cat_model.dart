class Cat {
  const Cat({required this.id, required this.imageUrl, this.breedName});

  final String id;
  final String imageUrl;
  final String? breedName;

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breeds = json['breeds'];
    String? parsedBreed;
    if (breeds is List && breeds.isNotEmpty) {
      final firstBreed = breeds.first;
      if (firstBreed is Map<String, dynamic>) {
        parsedBreed = firstBreed['name'] as String?;
      }
    }

    return Cat(
      id: (json['id'] as String?) ?? '',
      imageUrl: (json['url'] as String?) ?? '',
      breedName: parsedBreed,
    );
  }

  String titleFor(int index) {
    final breed = breedName;
    if (breed != null && breed.isNotEmpty) {
      return breed;
    }
    return 'Cat #${index + 1}';
  }

  String get shortId {
    if (id.length <= 8) {
      return id;
    }
    return id.substring(0, 8);
  }
}
