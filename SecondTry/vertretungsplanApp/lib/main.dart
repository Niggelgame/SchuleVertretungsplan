import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertretungsplanApp/UI/IntrayPage.dart';
import 'package:vertretungsplanApp/UI/Login/LoginPage.dart';
import 'package:vertretungsplanApp/UI/NoConnectionScreen.dart';
import 'package:vertretungsplanApp/UI/SplashScreen.dart';
import 'package:vertretungsplanApp/blocs/authentication_bloc.dart';
import 'package:vertretungsplanApp/events/authentication_events.dart';
import 'package:vertretungsplanApp/models/widgets/login_indicator.dart';
import 'package:vertretungsplanApp/repositories/userRepository.dart';
import 'package:vertretungsplanApp/states/authentication_states.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override 
  void onEvent(Bloc bloc, Object event){
    super.onEvent(bloc, event);
    print(event);
  }

  @override 
  void onTransition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    print(transition);
  }


  @override 
  void onError(Bloc bloc, Object error, StackTrace stacktrace){
    super.onError(bloc, error, stacktrace);
    print(error);
  }

}

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository) ..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    )
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.grey, // Color for Android
      statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
    ));
    OneSignal.shared.init(
      "5c2db3b9-64d0-4c42-b2c9-2054484b4da3",
      iOSSettings: {
        OSiOSSettings.autoPrompt: true,
        OSiOSSettings.inAppLaunchUrl: true
      }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        bottom: false,
        child: Container(
          child: SafeArea(
            bottom: false,
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state){
                if(state is AuthenticationUninitialized){
                  return AnimatedSwitcher(child: SplashScreen(), duration: Duration(milliseconds: 500),);
                }
                if(state is AuthenticationAuthenticated){
                  return AnimatedSwitcher(duration:Duration(milliseconds: 500),child: IntrayPage());
                }
                if(state is AuthenticationUnauthenticated){
                  return AnimatedSwitcher(duration:Duration(milliseconds: 500),child: LoginPage(userRepository: userRepository,));
                }
                if(state is AuthenticationLoading){
                  return AnimatedSwitcher(duration:Duration(milliseconds: 500),child:LoadingIndicator());
                }
                if(state is AuthenticationNoConnection){
                  return AnimatedSwitcher(duration:Duration(milliseconds: 500),child:NoConnectionScreen());
                }
              },
            )
          ),
        ),
      ),
    );
  }
}