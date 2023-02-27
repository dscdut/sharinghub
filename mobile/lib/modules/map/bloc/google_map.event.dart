import 'package:equatable/equatable.dart';

abstract class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();

  @override
  List<Object?> get props => [];
}

class GoogleMapRequetPermission extends GoogleMapEvent {}

class GoogleMapGetMarkers extends GoogleMapEvent {
  const GoogleMapGetMarkers();

  @override
  List<Object?> get props => [];
}

class GoogleMapGetProject extends GoogleMapEvent {
  const GoogleMapGetProject();

  @override
  List<Object?> get props => [];
}
