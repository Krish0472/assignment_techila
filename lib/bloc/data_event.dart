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
