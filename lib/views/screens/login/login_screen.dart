import 'package:flutter/material.dart';
import 'package:aqua_task/constant/image_constant.dart';
import 'package:aqua_task/constant/text_style_constant.dart';
import 'package:aqua_task/views/screens/login/widgets/login_button_widget.dart';
import 'package:aqua_task/views/screens/login/widgets/login_password_form_widget.dart';
import 'package:aqua_task/views/screens/login/widgets/login_username_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    ImageConstant.aquaTaskLogo,
                    height: 180,
                    width: 180,
                  ),
                ),
                Text('Masuk', style: TextStyleConstant.titleMedium),
                Text('Masuk ke akun kamu sekarang!',
                    style: TextStyleConstant.bodyMedium),
                const SizedBox(height: 24),
                const LoginUsernameFormWidget(),
                const SizedBox(height: 16),
                const LoginPasswordFormWidget(),
                const SizedBox(height: 16),
                const LoginButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
