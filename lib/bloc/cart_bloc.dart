import 'package:assignment_techila/bloc/data_event.dart';
import 'package:assignment_techila/bloc/data_state.dart';
import 'package:assignment_techila/repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';


class CartBloc extends Bloc<DataEvent,DataState> {
  final Repo _repo;
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
  void _addToCart(AddToCartEvent event ,Emitter<DataState> emit){
    emit(LoadingState());
    emit(CartState(_repo.addToCart(event.product),_repo.setTotalAmount()));
  }

  void _deleteFromCart(RemoveProduct event,Emitter<DataState> emit) {
    final cartResult = _deleteCartProduct(product: event.product);
    emit(ProductDeletedFromCartState(cartResult,_repo.setTotalAmount()));
  }
  List<Product> _deleteCartProduct({required Product product}) => _repo.delFromCart(product);



}