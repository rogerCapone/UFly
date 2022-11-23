import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flights/src/services/local_DB/goSoon_db.dart';
import 'package:flights/src/services/local_DB/trip_db.dart';

class ProfileEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMyTrips extends ProfileEvent {
  List<Object> get props => [];
}

class GetGoSoon extends ProfileEvent {
  //imporvised
  List<Object> get props => [];
}

class DeleteGoSoon extends ProfileEvent {
  GoSoon goSoon;
  DeleteGoSoon({this.goSoon});

  //imporvised
  List<Object> get props => [goSoon];
}

class DeleteMyTrip extends ProfileEvent {
  MyTrip myTrip;
  DeleteMyTrip({this.myTrip});

  //imporvised
  List<Object> get props => [myTrip];
}

class ProfileState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class MyTripsLoaded extends ProfileState {
  List<MyTrip> myTrips;
  MyTripsLoaded(this.myTrips);

  List<MyTrip> get getMyTrips => myTrips;
  @override
  // TODO: implement props
  List<Object> get props => [myTrips];
}

class GoSoonLoaded extends ProfileState {
  List<GoSoon> goSoon;
  GoSoonLoaded(this.goSoon);

  List<GoSoon> get goSoonList => goSoon;
  @override
  // TODO: implement props
  List<Object> get props => [goSoon];
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final uid;
  ProfileBloc({this.uid});
  @override
  // TODO: implement initialState
  ProfileState get initialState => ProfileLoading();

  @override
  Stream<ProfileState> mapEventToState(event) async* {
    // TODO: implement mapEventToState
    GoSoonDb db = GoSoonDb();
    TripDb tdb = TripDb();

    if (event is GetMyTrips) {
      print('myTrips was FIRED');
      try {
        await tdb.initDB();
        List<MyTrip> myTrips = await tdb.getMyTrips();

        yield MyTripsLoaded(myTrips);
      } catch (e) {
        print(e.toString());
        yield ProfileLoading();
      }
    } else if (event is GetGoSoon) {
      try {
        await db.initDB();
        List<GoSoon> goSoon = await db.getAllCities();
        print(goSoon);
        yield GoSoonLoaded(goSoon);
      } catch (_) {
        yield ProfileLoading();
      }
    } else if (event is DeleteGoSoon) {
      try {
        await db.initDB();
        await db.delete(event.goSoon);
        List<GoSoon> goSoon = await db.getAllCities();
        print(goSoon);
        yield GoSoonLoaded(goSoon);
      } catch (_) {
        yield ProfileLoading();
      }
    } else if (event is DeleteMyTrip) {
      try {
        await tdb.initDB();
        await tdb.delete(event.myTrip);
        List<MyTrip> myTrips = await tdb.getMyTrips();
        print(myTrips);
        yield MyTripsLoaded(myTrips);
      } catch (_) {
        yield ProfileLoading();
      }
    }
  }
}
