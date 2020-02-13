import 'package:flutter/material.dart';
import 'package:vertretungsplanApp/customenums/ServerState.dart';
import 'package:vertretungsplanApp/events/authentication_events.dart';
import 'package:vertretungsplanApp/repositories/userRepository.dart';
import 'package:vertretungsplanApp/states/authentication_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository}): assert(userRepository !=null);
  
  @override
  // DONE: implement initialState
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    // DONE: implement mapEventToState
    if(event is AppStarted){
      yield AuthenticationUninitialized();
      final ServerState hasToken = await userRepository.hasToken();

      if(hasToken == ServerState.authed) {
        yield AuthenticationAuthenticated();
      } else if (hasToken == ServerState.unauthed) {
        yield AuthenticationUnauthenticated();
      } else if (hasToken == ServerState.noConnection){
        yield AuthenticationNoConnection();
      }
    }

    if(event is LoggedIn){
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if(event is LoggedOut){
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
    
  }
  
}