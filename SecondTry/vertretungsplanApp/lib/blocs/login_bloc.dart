

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertretungsplanApp/events/authentication_events.dart';
import 'package:vertretungsplanApp/events/login_events.dart';
import 'package:vertretungsplanApp/repositories/userRepository.dart';
import 'package:vertretungsplanApp/states/login_states.dart';

import 'authentication_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  }) : assert (userRepository != null),
      assert (authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is LoginButtonPressed){
      yield LoginLoading();
      

      try{
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password
        );

        authenticationBloc.add(LoggedIn(token: token));
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if(event is SignupButtonPressed){
      yield LoginLoading();

      try{
        final token = await userRepository.signUp(
          firstname:  event.firstname,
          lastname: event.lastname,
          email: event.email,
          username: event.username,
          password: event.password
        );

        authenticationBloc.add(LoggedIn(token: token));
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }

  
}