import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:applicatio01statemanagment/repo/repository.dart';
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
    on<IncrementProductQuantity>(_incQty);
    on<DecreaseProductQuantity>(_decQty);

  }
   void _decQty (DecreaseProductQuantity event ,Emitter<DataState> emit) {
     final result = _repo.qtyRemove(event.productId);
     emit(CartState(result,_repo.setTotalAmount()));
   }

  void _incQty (IncrementProductQuantity event ,Emitter<DataState> emit) {
    final result = _repo.addQuantity(event.productId);
    emit(CartState(result,_repo.setTotalAmount()));
  }
  void _addToCart(AddToCartEvent event ,Emitter<DataState> emit) async{
    emit(LoadingState());
    emit(CartState(_repo.addToCart(event.product) as List<Product>,_repo.setTotalAmount()));
  }

  void _deleteFromCart(RemoveProduct event,Emitter<DataState> emit) {
   // emit(DeleteFromCartState(event.product as List<Product>));
   // emit(LoadingState());
    //
    final cartResult = _deleteCartProduct(product: event.product);
    emit(ProductDeletedFromCartState(cartResult,_repo.setTotalAmount()));

  }

  List<Product> _deleteCartProduct({required Product product}) => _repo.delFromCart(product);



}