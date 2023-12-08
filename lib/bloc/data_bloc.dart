import 'package:applicatio01statemanagment/bloc/data_event.dart';
import 'package:applicatio01statemanagment/bloc/data_state.dart';
import 'package:applicatio01statemanagment/repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataBloc extends Bloc<DataEvent,DataState> {
  static final  Repo repo =Repo();

  DataBloc() : super(InitialState()){
    on<FetchDataEvent>(_onFetchDataEvent);
  }
  void _onFetchDataEvent(FetchDataEvent event ,Emitter<DataState> emit) async{
      emit(LoadingState());
      final pList = await repo.fetchhData();
      emit(SuccessState(pList));
  }


  





}