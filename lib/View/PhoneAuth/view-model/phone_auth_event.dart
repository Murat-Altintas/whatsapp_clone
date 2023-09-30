part of 'phone_auth_bloc.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpToPhoneEvent extends PhoneAuthEvent {
  final String phoneNumber;

  SendOtpToPhoneEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifySentOtpEvent extends PhoneAuthEvent {
  final String otpCode;
  final String verificationId;

  VerifySentOtpEvent(this.otpCode, this.verificationId);

  @override
  List<Object> get props => [otpCode, verificationId];
}

class OnPhoneOtpSentEvent extends PhoneAuthEvent {
  final String verificationId;
  final int? forceResendToken;

  OnPhoneOtpSentEvent(this.verificationId, this.forceResendToken);

  @override
  List<Object> get props => [verificationId];
}

class OnPhoneAuthErrorEvent extends PhoneAuthEvent {
  final String error;

  OnPhoneAuthErrorEvent(this.error);

  @override
  List<Object> get props => [error];
}

class OnPhoneAuthVerificationCompleteEvent extends PhoneAuthEvent {
  final AuthCredential credential;

  OnPhoneAuthVerificationCompleteEvent({required this.credential});
}
