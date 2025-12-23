import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:task_wan_app/cubit/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial(isPassWordVisible: false));

  void changeVisiblitiy() {
    bool isVisible = (state as SignUpInitial).isPassWordVisible;
    emit(SignUpInitial(isPassWordVisible: !isVisible));
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      emit(SignUploading());
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        emit(SignUpSuccess());
      } else {
        throw FirebaseException(plugin: '');
      }
    } on FirebaseException catch (e) {
      emit(SignUpError());
    } catch (error) {}
  }
}
