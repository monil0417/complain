import 'package:flutter/material.dart';
import '../../components/background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';
import 'package:flutter_auth/responsive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // Function to handle successful login
  void _handleLoginSuccess(BuildContext context, String customerID, String customerName, String emailOrPhone, String password) {
    Navigator.pushReplacementNamed(
      context,
      '/dashboard',
      arguments: {
        'customerID': customerID.isNotEmpty ? customerID : 'Unknown',
        'customerName': customerName.isNotEmpty ? customerName : 'Guest',
        'emailOrPhone': emailOrPhone.isNotEmpty ? emailOrPhone : 'N/A',
        'password': password.isNotEmpty ? password : 'N/A',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(
            onLoginSuccess: (customerID, customerName, emailOrPhone, password) {
              _handleLoginSuccess(context, customerID, customerName, emailOrPhone, password);
            },
          ),
          desktop: Row(
            children: [
              const Expanded(child: LoginScreenTopImage()),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(
                        onLoginSuccess: (customerID, customerName, emailOrPhone, password) {
                          _handleLoginSuccess(context, customerID, customerName, emailOrPhone, password);
                        },
                      ),
                    ),
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

// Mobile version of Login Screen
class MobileLoginScreen extends StatelessWidget {
  final Function(String, String, String, String) onLoginSuccess;

  const MobileLoginScreen({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(onLoginSuccess: onLoginSuccess),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
