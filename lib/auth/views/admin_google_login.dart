import 'dart:ui';

import 'package:sems/core/constants/assets.dart';
import 'package:sems/auth/utils/terms_privacy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sems/shared/widget/refresh_dialog.dart';
import '../../router.dart';
import '../../../shared/utils/snacbar_helper.dart';
import '../../../shared/theme/theme_toggle_button.dart';
import '../bloc/auth_bloc.dart';
import 'admin_resgister.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() => showLoadingDialog(context));
          debugPrint('Auth Loading...');
        } else {
          setState(() => hideLoadingDialog(context));
          debugPrint('Auth Loaded✅');

          if (state is AuthAuthenticated) {

            debugPrint('Auth Authenticated✅');
            context.go(AppRoute.home.path);

          } else if (state is AuthRequiresRegistration) {
            debugPrint('New User Redirecting... to register as not registered');

            context.push(AppRoute.register.path, extra: {
              'uid': state.uid,
              'email': state.email,
              'name': state.name,
              'role': state.role
            });
          } else if (state is SignOut) {
            showLoadingDialog(context);
            context.go(AppRoute.roleSelection.path);
            debugPrint('Auth Signed Out✅');
          
          
          } else if (state is AuthError) {
            debugPrint('Auth Error❌');
            SnackbarHelper.showErrorSnackBar(context, state.message);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/logo/logo_sems-trans.png",
                            height: 180,
                          ),
                          const Text(
                            "SEMS",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Education Management System",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Google Sign-In Button
                    SizedBox(
                      width: 300.0,
                      child: state is AuthLoading
                          ? const Center(
                              child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ))
                          : ElevatedButton.icon(
                              icon: Image.network(
                                Assets.googleLogo,
                                height: 20,
                              ),
                              label: const Text("Sign in"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                              onPressed: state is AuthLoading
                                  ? null
                                  : () => _handleSignIn(context),
                            ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: 30,
                left: 30,
                bottom: 30,
                child: TermsAndPrivacyWidget(
                  privacyPolicyUrl: 'link here',
                  termsOfServiceUrl: 'link here',
                  textColor: Colors.white,
                  linkColor: Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSignIn(BuildContext context) {
    context.read<AuthBloc>().add(SignInWithGoogle(role: 'Admin'));
  }
}
