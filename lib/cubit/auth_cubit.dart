import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_wan_app/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future<void> submitCode({
    required String code,
    required String verificationId,
    required BuildContext context,
  }) async {
    try {
      print('CODE $code');
      print('Verfication id $verificationId');
      final crendential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      await FirebaseAuth.instance.signInWithCredential(crendential).onError((
        error,
        stack,
      ) {
        throw FirebaseException(plugin: error.toString());
      });
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } catch (e) {
      print("ERROR KELDI $e");
    }
  }

  Future<void> verifyWithPhoneNumber({
    required String phoneNumber,
    required Function(String verifcationID) onCodeSent,
  }) async {
    emit(AuthLoadingState());
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber.replaceAll(' ', ''),
        verificationCompleted: (value) async {
          await FirebaseAuth.instance.signInWithCredential(value);
          emit(AuthSuccesState());
        }, // * success
        verificationFailed: (value) {
          emit(AuthErrorState());
          throw FirebaseException(plugin: 'try again');
        }, // ! error
        codeSent: (String verificationId, int? resendToken) async {
          onCodeSent(verificationId);
        }, // ? sms
        codeAutoRetrievalTimeout: (value) {
          throw TimeoutException('Try again !');
        }, // ? time out
      );
    } on FirebaseException catch (error) {
      emit(AuthErrorState());
    } on TimeoutException catch (error) {
      emit(AuthErrorState());
    } catch (error) {
      emit(AuthErrorState());
    }
  }
}
