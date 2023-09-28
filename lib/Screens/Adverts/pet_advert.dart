import 'dart:convert';

class PetAdvert {
  int id;
  String body;
  String title;
  String animalType;
  String imagePath;

  PetAdvert({
    required this.id,
    required this.body,
    required this.title,
    required this.animalType,
    required this.imagePath,
  });

  PetAdvert copyWith({
    int? id,
    String? body,
    String? title,
    String? animalType,
    String? imagePath,
  }) {
    return PetAdvert(
        id: id ?? this.id,
        body: body ?? this.body,
        title: title ?? this.title,
        animalType: animalType ?? this.animalType,
        imagePath: imagePath ?? this.imagePath);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
      'title': title,
      'animalType': animalType,
      'imagePath': imagePath
    };
  }

  factory PetAdvert.fromMap(Map<String, dynamic> map) {
    return PetAdvert(
      id: map['id'],
      body: map['body'],
      title: map['title'],
      animalType: map['animal_type'],
      imagePath: map['image_path'],
    );
  }

  String toJson() => json.encode(toMap());
}
