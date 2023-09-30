import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/View/PhoneAuth/view/phone_auth.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

part 'phone_auth_event.dart';

part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  final PhoneAuthRepository phoneAuthRepository;
  final auth = FirebaseAuth.instance;

  PhoneAuthBloc({required this.phoneAuthRepository}) : super(PhoneAuthInitial()) {
    on<SendOtpToPhoneEvent>(_onSentOtp);

    on<VerifySentOtpEvent>(_onVerifyOtp);

    on<OnPhoneOtpSentEvent>((event, emit) {
      emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId));
    });

    on<OnPhoneAuthErrorEvent>((event, emit) {
      emit(PhoneAuthError(error: event.error));
    });

    on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);
  }

  FutureOr<void> _onSentOtp(SendOtpToPhoneEvent event, Emitter<PhoneAuthState> emit) async {
    emit(PhoneAuthLoading());
    try {
      await phoneAuthRepository.verifyPhone(event.phoneNumber, (e) {
        add(OnPhoneAuthErrorEvent(e.code));
        "Phone Number Error: $e".log();
      }, (credential) {
        add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
      }, (verificationId, forceResendToken) {
        add(OnPhoneOtpSentEvent(verificationId, forceResendToken));
      }, (verificationId) {});
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
      "Verification Error: $e".log();
    }
  }

  FutureOr<void> _onVerifyOtp(VerifySentOtpEvent event, Emitter<PhoneAuthState> emit) async {
    try {
      emit(PhoneAuthLoading());
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.otpCode);
      add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
      "Credential Error: $e".log();
    }
  }

  FutureOr<void> _loginWithCredential(OnPhoneAuthVerificationCompleteEvent event, Emitter<PhoneAuthState> emit) async {
    try {
      await auth.signInWithCredential(event.credential).then((user) {
        if (user.user != null) {
          emit(PhoneAuthVerified());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthError(error: e.code));
      "Exception Error: $e".log();
    } catch (e) {
      emit(PhoneAuthError(error: e.toString()));
      "User Error: $e".log();
    }
  }
}
