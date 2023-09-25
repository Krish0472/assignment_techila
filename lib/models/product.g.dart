// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProducts _$MyProductsFromJson(Map<String, dynamic> json) => MyProducts(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyProductsToJson(MyProducts instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      quantity: json['quantity'] as int?,
      total: json['total'] as num?,
      discountPercentage: json['discountPercentage'] as num?,
      discountedPrice: json['discountedPrice'] as num?,
      brand: json['brand'] as String?,
      category: json['category'] as String,
      description: json['description'] as String?,
      rating: json['rating'] as num?,
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as num,
      thumbnail: json['thumbnail'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    )..isFavorite = json['isFavorite'] as bool;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'total': instance.total,
      'discountPercentage': instance.discountPercentage,
      'discountedPrice': instance.discountedPrice,
      'brand': instance.brand,
      'category': instance.category,
      'description': instance.description,
      'rating': instance.rating,
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'thumbnail': instance.thumbnail,
      'images': instance.images,
      'isFavorite': instance.isFavorite,
    };
