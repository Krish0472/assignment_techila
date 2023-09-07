import 'package:json_annotation/json_annotation.dart';
part "product.g.dart";
// class ProductModel{
//   List<Product> products;
//   ProductModel({required this.products});
//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//     products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//   );
// }
@JsonSerializable()
class MyProducts {
  List<Product> products;
  MyProducts({required this.products});

  factory MyProducts.fromJson(Map<String,dynamic> json) => _$MyProductsFromJson(json);


}

@JsonSerializable()
class Product {
  int? quantity;
  num? total;
  num? discountPercentage;
  num? discountedPrice;
  String? brand;
  String? category;
  String? description;
  num? rating;
  int id;
  String title;
  num price;
  String thumbnail;
  List<String> images;
  bool isFavorite = false;

  Product(
      {this.quantity,
        this.total,
        this.discountPercentage,
        this.discountedPrice,
        this.brand,
        this.category,
        this.description,
        this.rating,
        required this.id,
        required this.title,
        required this.price,
        required this.thumbnail,
        required this.images});


  Map<String, dynamic> toJson() => _$ProductToJson(this);

  factory Product.fromJson(Map<String, dynamic> json){

   return Product(
     quantity: json['quantity'],
      total: json['total'],
      discountPercentage: json['discountPercentage'],
      discountedPrice: json['discountedPrice'],
      id: json['id'],
      title: json['title'],
      brand: json['brand'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      category: json['category'],
      description: json['description'],
      rating: json['rating'],
      images: List<String>.from(json["images"].map((x) => x)),
      // images: (json['category'] == 'smartphones') ? '$electronic${json['id']}'
      //     : (json['category'] == 'groceries') ? '$menClothing${json['id']}'
      //     : '$womenClothing${json['id']}'
    );
  }
}


String electronic = 'https://api.lorem.space/image/watch?w=640&h=480&r=';
String womenClothing = 'https://api.lorem.space/image/fashion?w=640&h=480&r=';
String menClothing = 'https://api.lorem.space/image/shoes?w=640&h=480&r=';

