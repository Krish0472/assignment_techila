import 'package:assignment_techila/models/product.dart';
import 'package:equatable/equatable.dart';

class WishList extends Equatable {
  final List<Product> product;
  const WishList({this.product = const <Product>[]});
  @override
  List<Object?> get props => [product];
}
