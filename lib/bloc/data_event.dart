// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:assignment_techila/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class FetchDataEvent extends DataEvent{}

class AddToCartEvent extends DataEvent{
  @override
  List<Object> get props => [product];
  final Product product;
  AddToCartEvent(this.product);

}

class AddToWishListEvent extends DataEvent{
  final Product prod ;
  AddToWishListEvent(this.prod);
  @override
  List<Object> get props => [prod];
}
class RemoveProductFromWishList extends DataEvent {
  final Product prod;
  RemoveProductFromWishList(this.prod);
  @override
  List<Object> get props => [prod];
}



class RemoveProduct extends DataEvent {
  final Product product;
  RemoveProduct(this.product);
  @override
  List<Object> get props => [product];
}

class CartTotalEvent extends DataEvent{
  num _totalAmount =0;
  num get totalAmount => _totalAmount;
  CartTotalEvent(this._totalAmount);
}

class IncrementProductQuantity extends DataEvent {
  final int productId;
  IncrementProductQuantity(this.productId);
  @override
  List<Object> get props => [productId];
}
class DecreaseProductQuantity extends DataEvent {
  final int productId;
  DecreaseProductQuantity(this.productId);
  @override
  List<Object> get props => [productId];
}






