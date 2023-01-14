import 'package:hive/hive.dart';

part "product_model.g.dart";

@HiveType(typeId: 1)
class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.quantity,
    required this.description,
    required this.image,
  });
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  double? price;
  @HiveField(4)
  String? category;
  @HiveField(5)
  int quantity;
  @HiveField(6)
  String? description;
  @HiveField(7)
  String? image;

  ProductModel copyWith({
    String? id,
    String? title,
    double? price,
    String? category,
    int? quantity,
    String? description,
    String? image,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        category: category ?? this.category,
        quantity: quantity ?? this.quantity,
        description: description ?? this.description,
        image: image ?? this.image,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        category: json["category"],
        quantity: json["quantity"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "category": category,
        "quantity": quantity,
        "description": description,
        "image": image,
      };

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, category: $category,quantity : $quantity, description: $description, image: $image)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.category == category &&
        other.quantity == quantity &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        category.hashCode ^
        quantity.hashCode ^
        description.hashCode ^
        image.hashCode;
  }
}
