import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:applicatio01statemanagment/repo/apirepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';

class DataBloc extends Bloc<DataEvent,DataState> {
  static final  Repo repo =Repo();


  DataBloc() : super(InitialState()){
    on<FetchDataEvent>(_onFetchDataEvent);
    on<AddToCartEvent>(_AddToCart);
  }

  void _onFetchDataEvent(FetchDataEvent event ,Emitter<DataState> emit) async{
      emit(LoadingState());
      final pList = await repo.fetchhData();
     // final pList = await repo.fetchData();
      print(pList.length);
      emit(SuccessState(pList));

  }
  
  void _AddToCart(AddToCartEvent event ,Emitter<DataState> emit) async{
    emit(LoadingState());
    emit(CartState(repo.addToCart(event.product) as List<Product>));
  }

}