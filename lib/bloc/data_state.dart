import 'package:applicatio01statemanagment/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  late Product products ;
  Product get prod => products;
  List<Product> productListCart =[];

  @override
  List<Object?> get props => [products,productListCart];
}

class InitialState extends DataState{}

class LoadingState extends DataState{

}

class SuccessState extends DataState{
  List<Product> productList =[];
  SuccessState(this.productList);
}
class CartInitial extends DataState {}

class CartLoaded extends DataState {
  final Product product;

   CartLoaded( this.product);

  @override
  List<Object> get props => [product];
}
class CartState extends DataState{
  List<Product> productListCart =[];
  CartState(this.productListCart);
}

class ProductDeletedFromCartState extends DataState{
 final List<Product> productListCart;
 ProductDeletedFromCartState(this.productListCart);

}