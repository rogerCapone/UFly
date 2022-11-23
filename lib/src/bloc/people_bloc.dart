import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flights/src/services/database.dart';

class PeopleEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AskForFriendship extends PeopleEvent {
  final myUid;
  final newFriendUid;
  AskForFriendship({this.myUid, this.newFriendUid});
  List<Object> get props => [myUid, newFriendUid];
}

class CancelAskForFriendship extends PeopleEvent {
  final myUid;
  final newFriendUid;
  CancelAskForFriendship({this.myUid, this.newFriendUid});
  List<Object> get props => [myUid, newFriendUid];
}

class DeleteFriendship extends PeopleEvent {
  final myUid;
  final newFriendUid;
  DeleteFriendship({this.myUid, this.newFriendUid});
  List<Object> get props => [myUid, newFriendUid];
}

class PeopleProfileState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

// class PendentListIsNotFired extends PendentState{

// }

class PeopleUnknown extends PeopleProfileState {
  //FOLLOW Button
}

class PeopleWaitingForFriendResponse extends PeopleProfileState {
  //PENDENT Button

  // final _pendentList;
  // PendentListLoaded(this._pendentList);

  //When we need to get DATA in the code // List<UsersData> get getPdtList => _pendentList;
  @override
  // TODO: implement props
  List<Object> get props => []; //_pendentList
}

class PeopleIsFriend extends PeopleProfileState {
  //UNFOLLOW Button
}

class PeopleBloc extends Bloc<PeopleEvent, PeopleProfileState> {
  // tag == follow/pendent/unfollow
  final tag;
  PeopleBloc({this.tag});
  @override
  // TODO: implement initialState
  PeopleProfileState get initialState => tag == 'false'
      ? PeopleUnknown()
      : tag == 'true' ? PeopleIsFriend() : PeopleWaitingForFriendResponse();

  @override
  Stream<PeopleProfileState> mapEventToState(event) async* {
    // TODO: implement mapEventToState
    if (event is AskForFriendship) {
      try {
        await DataBase(uid: event.myUid).askForFriendship(event.newFriendUid);
        yield PeopleWaitingForFriendResponse();
      } catch (_) {
        yield PeopleUnknown();
      }
    } else if (event is CancelAskForFriendship) {
      try {
        await DataBase(uid: event.myUid)
            .cancelAskForFriendship(event.newFriendUid);

        yield PeopleUnknown();
      } catch (_) {
        yield PeopleWaitingForFriendResponse();
      }
    } else if (event is DeleteFriendship) {
      try {
        await DataBase(uid: event.myUid).deleteFriend(event.newFriendUid);
        yield PeopleUnknown();
      } catch (_) {
        yield PeopleIsFriend();
      }
    }
  }
}
