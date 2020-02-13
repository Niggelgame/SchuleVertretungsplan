



import 'package:flutter/material.dart';
import 'package:vertretungsplanApp/events/apitoken_event.dart';
import 'package:vertretungsplanApp/repositories/userRepository.dart';
import 'package:vertretungsplanApp/states/apitoken_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiTokenBloc extends Bloc<ApiTokenEvent, ApiTokenState> {
  
  final UserRepository userRepository;

  ApiTokenBloc({@required this.userRepository}): assert(userRepository !=null);
  
  @override
  // DONE: implement initialState
  ApiTokenState get initialState => ApiTokenUninitialized();

  @override
  Stream<ApiTokenState> mapEventToState(ApiTokenEvent event) async*{
    

    if(event is PageOpenedEvent){
      yield ApiTokenLoading();
      try{
        String apiToken = await userRepository.getApiKey();
        yield ApiTokenLoaded(apiToken: apiToken);
      } catch (error){
        yield ApiTokenFailure(error: error);
      }
    }
    
  }
  
}