part of 'donate.bloc.dart';

abstract class DonateEvent extends Equatable {
  const DonateEvent();

  @override
  List<Object> get props => [];
}

class DonateSubmit extends DonateEvent {
  final SetDonateDTO setDonate;

  const DonateSubmit({required this.setDonate});

  @override
  List<Object> get props => [setDonate];
}

class DonateFormValidate extends DonateEvent {
  final SetDonateDTO setDonate;

  const DonateFormValidate({required this.setDonate});

  @override
  List<Object> get props => [setDonate];
}
