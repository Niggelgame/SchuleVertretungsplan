
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vertretungsplanApp/UI/Login/LoginForm.dart';
import 'package:vertretungsplanApp/blocs/authentication_bloc.dart';
import 'package:vertretungsplanApp/blocs/login_bloc.dart';
import 'package:vertretungsplanApp/repositories/userRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xFF212128), // Color for Android
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
    ));
    return Scaffold(
     backgroundColor: Color(0xFF212128),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}