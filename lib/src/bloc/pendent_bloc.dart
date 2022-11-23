import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flights/src/models/search_user_model.dart';
import 'package:flights/src/services/database.dart';

class PendentEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchPendent extends PendentEvent {
  final _uid;
  FetchPendent(this._uid);
  List<Object> get props => [_uid];
}

class ReFetchPendent extends PendentEvent {
  //imporvised
  final _uid;
  ReFetchPendent(this._uid);
  List<Object> get props => [_uid];
}

class PendentState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

// class PendentListIsNotFired extends PendentState{

// }

class PendentListIsLoading extends PendentState {}

class PendentListLoaded extends PendentState {
  final _pendentList;
  PendentListLoaded(this._pendentList);

  List<UsersData> get getPdtList => _pendentList;
  @override
  // TODO: implement props
  List<Object> get props => [_pendentList];
}

class PendentListNotLoaded extends PendentState {}

class PendentBloc extends Bloc<PendentEvent, PendentState> {
  final uid;
  PendentBloc({this.uid});
  @override
  // TODO: implement initialState
  PendentState get initialState => PendentListIsLoading();

  @override
  Stream<PendentState> mapEventToState(event) async* {
    // TODO: implement mapEventToState
    if (event is FetchPendent) {
      try {
        List<UsersData> pendentList =
            await DataBase(uid: event._uid).getUsersPendingToAccept();
        yield PendentListLoaded(pendentList);
      } catch (_) {
        yield PendentListNotLoaded();
      }
    } else if (event is ReFetchPendent) {
      try {
        List<UsersData> pendentList =
            await DataBase(uid: event._uid).getUsersPendingToAccept();
        yield PendentListLoaded(pendentList);
      } catch (_) {
        yield PendentListNotLoaded();
      }
    }
  }
}
