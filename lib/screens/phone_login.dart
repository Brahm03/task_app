import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_wan_app/colors/app_colors.dart';
import 'package:task_wan_app/cubit/auth_cubit.dart';
import 'package:task_wan_app/cubit/auth_state.dart';
import 'package:task_wan_app/screens/sign_in.dart';
import 'package:task_wan_app/screens/verification.dart';
import 'package:task_wan_app/widgets/phone_number_field.dart';
import 'package:task_wan_app/widgets/remember_me.dart';
import 'package:task_wan_app/widgets/signup_with_phone.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// * SHA1 key ->
// * ID ->

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _codeController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showDialog(
              context: context,
              builder: (context) => Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CupertinoActivityIndicator(color: Colors.white),
              ),
            );
          } else if (state is AuthErrorState) {
            Navigator.pop(context);
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(message: "please try again later !"),
            );
          } else if (state is AuthSuccesState) {
            Navigator.pop(context);
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.info(message: "Check ur messages"),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                "assets/images/signup-vector.svg",
                height: MediaQuery.of(context).size.height / 2,
              ),
              Text(
                "Login to your Account",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontSize: 24.0),
              ),
              PhoneNumberField(
                countrCodeController: _codeController,
                phoneNumberController: _phoneNumberController,
              ),
              const RememberMe(),
              SignupWithPhone(
                name: "Sign in",
                onPressed: () {
                  context.read<AuthCubit>().verifyWithPhoneNumber(
                    phoneNumber:
                        "${_codeController.text} ${_phoneNumberController.text}",
                    onCodeSent: (verificationID) {
                      Navigator.pushNamed(
                        context,
                        '/verification',
                        arguments: [
                          "${_codeController.text} ${_phoneNumberController.text}",
                          verificationID,
                        ],
                      );
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign up",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
