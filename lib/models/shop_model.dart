class Shop {
  final String id;
  final String name;
  final String category;
  final String description;
  final double rating;
  final List<String> imageUrls;
  final String priceRange;
  final String location;
  final String phone;
  final String googleMapsUrl;

  const Shop({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.rating,
    required this.imageUrls,
    required this.priceRange,
    required this.location,
    required this.phone,
    this.googleMapsUrl = '',
  });

  /// Creates a [Shop] from a JSON map.
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: (json['id'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      category: (json['category'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      rating: ((json['rating'] as num?) ?? 0).toDouble(),
      imageUrls: (json['imageUrls'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      priceRange: (json['priceRange'] as String?) ?? '',
      location: (json['location'] as String?) ?? '',
      phone: (json['phone'] as String?) ?? '',
      googleMapsUrl: (json['googleMapsUrl'] as String?) ?? '',
    );
  }

  /// Converts this [Shop] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'rating': rating,
      'imageUrls': imageUrls,
      'priceRange': priceRange,
      'location': location,
      'phone': phone,
      'googleMapsUrl': googleMapsUrl,
    };
  }

  /// Returns a copy of this [Shop] with the given fields replaced.
  Shop copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    double? rating,
    List<String>? imageUrls,
    String? priceRange,
    String? location,
    String? phone,
    String? googleMapsUrl,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      imageUrls: imageUrls ?? this.imageUrls,
      priceRange: priceRange ?? this.priceRange,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      googleMapsUrl: googleMapsUrl ?? this.googleMapsUrl,
    );
  }

  @override
  String toString() => 'Shop(id: $id, name: $name, category: $category)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Shop && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
