import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_wan_app/cubit/cubit/sign_up_cubit.dart';
import 'package:task_wan_app/cubit/cubit/sign_up_state.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUploading) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: CupertinoActivityIndicator(color: Colors.blue),
              ),
            );
          } else if (state is SignUpError) {
            Navigator.pop(context);
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: 'something went wrong try again !'),
            );
          } else if (state is SignUpSuccess) {
            Navigator.pop(context);
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(message: 'Congrats'),
            );
          }
        },
        child: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoTextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    placeholder: 'Enter ur email',
                    controller: _emailController,
                  ),
                  SizedBox(height: 40),
                  CupertinoTextField(
                    suffix: IconButton(
                      onPressed: () {
                        context.read<SignUpCubit>().changeVisiblitiy();
                      },
                      icon: Icon(
                        state is SignUpInitial
                            ? state.isPassWordVisible
                                  ? Icons.remove_red_eye
                                  : Icons.panorama_fish_eye
                            : Icons.remove_red_eye,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    placeholder: 'Enter ur password',
                    obscureText: state is SignUpInitial
                        ? !state.isPassWordVisible
                        : true,
                    onSubmitted: (value) {
                      context.read<SignUpCubit>().signUpWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    },
                    controller: _passwordController,
                    textInputAction: TextInputAction.send,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
