part of 'phone_auth_bloc.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthError extends PhoneAuthState {
  final String error;

  PhoneAuthError({required this.error});

  @override
  List<Object> get props => [error];
}

class PhoneAuthVerified extends PhoneAuthState {}

class PhoneAuthCodeSentSuccess extends PhoneAuthState {
  final String verificationId;

  PhoneAuthCodeSentSuccess({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}
