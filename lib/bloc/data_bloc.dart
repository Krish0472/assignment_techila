import 'package:assignment_techila/bloc/data_event.dart';
import 'package:assignment_techila/bloc/data_state.dart';
import 'package:assignment_techila/repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  static final Repo repo = Repo();

  DataBloc() : super(InitialState()) {
    on<FetchDataEvent>(_onFetchDataEvent);
  }
  void _onFetchDataEvent(FetchDataEvent event, Emitter<DataState> emit) async {
    emit(LoadingState());
    final pList = await repo.fetchData();
    emit(SuccessState(pList));
  }
}
