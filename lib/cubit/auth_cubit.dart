import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_wan_app/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  Future<void> verifyWithPhoneNumber({required String phoneNumber}) async {
    emit(AuthLoadingState());
    print('Phone number keldi $phoneNumber');
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (value) {
          emit(AuthSuccesState());
        }, // * success
        verificationFailed: (value) {
          throw FirebaseException(plugin: 'try again');
        }, // ! error
        codeSent: (code, value) {
          print('code jontilindi');
        }, // ? sms
        codeAutoRetrievalTimeout: (value) {
          print('codeAutoRetrievalTimeout error $value');
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
