// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'dart:convert';

class ProductField {
  static const idColumn = "_id";
  static const titleColumn = "name";
  static const priceColumn = "price";
  static const descriptionColumn = "description";
  static const imageColumn = "image";
  static final List<String> values = [
    idColumn,
    titleColumn,
    priceColumn,
    descriptionColumn,
    imageColumn
  ];
}

class ProductModel {
  final int? id;
  final String title;
  final double price;
  final String? category;
  final String? description;
  final String? image;
  const ProductModel({
    this.id,
    required this.title,
    required this.price,
    this.category,
    this.description,
    this.image,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? category,
    String? description,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      price: map['price'] as double,
      category: map['category'] != null ? map['category'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, category: $category, description: $description, image: $image)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        image.hashCode;
  }
}
