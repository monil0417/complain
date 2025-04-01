import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/responsive.dart';
import '../../components/background.dart';
import 'components/sign_up_top_image.dart';
import 'components/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login'); // Navigate to Login Page
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(onSignUpSuccess: () => _navigateToLogin(context)),
          desktop: Row(
            children: [
              const Expanded(child: SignUpScreenTopImage()),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: SignUpForm(onSignUpSuccess: () => _navigateToLogin(context)),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  final VoidCallback onSignUpSuccess;

  const MobileSignupScreen({Key? key, required this.onSignUpSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(onSignUpSuccess: onSignUpSuccess),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
