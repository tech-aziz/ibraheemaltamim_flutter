class WishlistModel {
  final String title;
  final String description;
  final String doctor;
  final String deadline;
  final String category;
  final String imageUrl;
  final bool isFavorite;

  WishlistModel({
    required this.title,
    required this.description,
    required this.doctor,
    required this.deadline,
    required this.category,
    required this.imageUrl,
    this.isFavorite = false,
  });

  WishlistModel copyWith({
    String? title,
    String? description,
    String? doctor,
    String? deadline,
    String? category,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return WishlistModel(
      title: title ?? this.title,
      description: description ?? this.description,
      doctor: doctor ?? this.doctor,
      deadline: deadline ?? this.deadline,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
