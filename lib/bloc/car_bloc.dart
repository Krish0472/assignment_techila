import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:applicatio01statemanagment/repo/apirepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';

class CartBloc extends Bloc<DataEvent,DataState> {
  //static final  Repo repo = Repo();
   final Repo _repo;

  // List<Product> productListCartItem=[];
  // List<Product> get items => productListCartItem;


  CartBloc(Repo repo)   :_repo = repo,  super(InitialState()){
    on<AddToCartEvent>(_addToCart);
    on<RemoveProduct>(_deleteFromCart);
  }
  void _addToCart(AddToCartEvent event ,Emitter<DataState> emit) async{
    emit(LoadingState());
    emit(CartState(_repo.addToCart(event.product) as List<Product>));
  }

  void _deleteFromCart(RemoveProduct event,Emitter<DataState> emit) {
   // emit(DeleteFromCartState(event.product as List<Product>));
    emit(LoadingState());
    //
    final cartResult = _deleteCartProduct(product: event.product);
    emit(ProductDeletedFromCartState(cartResult));

  }

  List<Product> _deleteCartProduct({required Product product}) => _repo.delFromCart(product);

}