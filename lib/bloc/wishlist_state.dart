// ignore_for_file: overridden_fields

import 'package:equatable/equatable.dart';

import '../models/product.dart';

class WishListState extends Equatable {
  List<Product> wishListProduct = [];
  @override
  List<Object?> get props => [];
}

abstract class ActionState extends WishListState {}

class loadSuccess extends ActionState {
  @override
  List<Product> wishListProduct = [];
  loadSuccess(this.wishListProduct);
  @override
  List<Object?> get props => [wishListProduct];
}

class WishListInitialState extends WishListState {}

class WishListStateLoaded extends WishListState {
  @override
  List<Product> wishListProduct = [];
  WishListStateLoaded(this.wishListProduct);
  @override
  List<Object?> get props => [wishListProduct];
}

class ProductDeletedFromWishListState extends WishListState {
  @override
  List<Product> wishListProduct = [];
  ProductDeletedFromWishListState(this.wishListProduct);
}
