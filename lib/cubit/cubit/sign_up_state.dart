abstract class SignUpState {}

final class SignUpInitial extends SignUpState {
  final bool isPassWordVisible;
  SignUpInitial({required this.isPassWordVisible});
}

final class SignUpSuccess extends SignUpState {}

final class SignUploading extends SignUpState {}

final class SignUpError extends SignUpState {}
