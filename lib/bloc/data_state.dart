import 'package:applicatio01statemanagment/models/product.dart';
import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  late Product products ;
  Product get prod => products;
  List<Product> productListCart =[];

  num totalBill =0;
  num get _totalBill =>totalBill;

  @override
  List<Object?> get props => [productListCart,_totalBill];
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
  @override
  num totalBill;
  List<Product> productListCart =[];

  CartState(this.productListCart,this.totalBill);

}



class ProductDeletedFromCartState extends DataState{
 final List<Product> productListCart;
 @override
 num totalBill;
 ProductDeletedFromCartState(this.productListCart,this.totalBill);

}

class IncrementQty extends DataState{
  final List<Product> productQuantities;
  IncrementQty(this.productQuantities);
  @override
  List<Object> get props => [productQuantities];

}

class DecrementQty extends DataState{
  final List<Product> productQuantities;
  DecrementQty(this.productQuantities);
  @override
  List<Object> get props => [productQuantities];

}