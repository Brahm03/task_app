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
    print('Phone number keldi $phoneNumber');
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber.replaceAll(' ', ''),
        verificationCompleted: (value) async {
          print('COMPETED ✅ ${value.smsCode}');
          await FirebaseAuth.instance.signInWithCredential(value);
          emit(AuthSuccesState());
        }, // * success
        verificationFailed: (value) {
          print('FAILED ❌ ${value.message}');
          throw FirebaseException(plugin: 'try again');
        }, // ! error
        codeSent: (String verificationId, int? resendToken) async {
          print('CODE KELDI');
          print('code jontilindi');
          onCodeSent(verificationId);
        }, // ? sms
        codeAutoRetrievalTimeout: (value) {
          print('codeAutoRetrievalTimeout error ❌ $value');
          throw FirebaseException(plugin: 'try again');
        }, // ? time out
      );
    } on FirebaseException catch (e) {
      print('firebase exception xato ${e.message}');
      emit(AuthErrorState());
    } on TimeoutException catch (error) {
      print('TimeoutException exception xato ${error}');

      emit(AuthErrorState());
    } catch (error) {
      print('catch exception xato ${error}');

      emit(AuthErrorState());
    }
  }
}
