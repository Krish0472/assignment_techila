import 'dart:async';

import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/wishlist_state.dart';
import 'package:applicatio01statemanagment/repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';

class WishListBloc extends Bloc<DataEvent, WishListState> {
  final Repo _repo;
  WishListBloc(Repo repo)
      : _repo = repo,
        super(WishListInitialState()) {
    on<AddToWishListEvent>(_addToWishList);
    on<RemoveProductFromWishList>(_delFromWishList);
  }

  FutureOr<void> _addToWishList(
      AddToWishListEvent event, Emitter<WishListState> emit) {
    emit(WishListInitialState());
    emit(WishListStateLoaded(_repo.addToWishList(event.prod)));
  }

  FutureOr<void> _delFromWishList(
      RemoveProductFromWishList event, Emitter<WishListState> emit) {
    final wishListResult = _deleteCartProduct(product: event.prod);
    emit(ProductDeletedFromWishListState(wishListResult));
    emit(loadSuccess(wishListResult));
  }

  List<Product> _deleteCartProduct({required Product product}) =>
      _repo.delFromWishList(product);
}
