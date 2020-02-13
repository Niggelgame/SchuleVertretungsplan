import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertretungsplanApp/blocs/authentication_bloc.dart';
import 'package:vertretungsplanApp/events/authentication_events.dart';


class NoConnectionScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(


          children: <Widget>[
            Spacer(flex: 1,),
            Text("No Connection"),
            RaisedButton(
              child: Text("Reconnect"),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
              },
            ),
            Spacer(flex: 1,)
          ],
        ),
      ),
    );
  }
}