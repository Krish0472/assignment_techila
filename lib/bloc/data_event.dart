import 'package:applicatio01statemanagment/models/product.dart';
import 'package:applicatio01statemanagment/webservices/webservise.dart';
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

// class RemoveProduct extends DataEvent {
//  final Product product;
//
//    RemoveProduct(this.product);
//
//   @override
//   List<Object> get props => [product];
// }



// class DeleteToCart extends DataEvent{
//   final Product product;
//   DeleteToCart(this.product);
// }
