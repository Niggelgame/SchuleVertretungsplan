import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vertretungsplanApp/blocs/login_bloc.dart';
import 'package:vertretungsplanApp/events/login_events.dart';
import 'package:vertretungsplanApp/models/global.dart';
import 'package:vertretungsplanApp/states/login_states.dart';

class LoginForm extends StatefulWidget {
  @override 
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override 
  Widget build(BuildContext context){
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(username: _usernameController.text, password: _passwordController.text)
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginFailure){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("${state.error}"),
            )
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){
          return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 100,),
            Text("Welcome", style: bigLightBlueTitle,),
            Container(height: 100,),
            Container(
              height: 200,
              
              child: Form(
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        controller: _usernameController,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: darkGreyColor,
                        style: TextStyle(fontSize: 22.0, color: darkGreyColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Username',
                          contentPadding:
                            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),

                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          )
                        ),
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        autocorrect: false,
                        obscureText: true,
                        controller: _passwordController,
                        autofocus: false,
                        cursorColor: darkGreyColor,
                        style: TextStyle(fontSize: 22.0, color: darkGreyColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          contentPadding:
                            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),

                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          )
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text("Sign in", style: redTodoTitle,),
                      onPressed: () {
                        state is! LoginLoading ? _onLoginButtonPressed() : null;
                      },
                    )
                  ],
                ),
              ),
            ),
            /*
            Container(
              child: Column(
                children: <Widget>[
                  Text("Don't you have an account yet?", style: redText, textAlign: TextAlign.center,),
                  FlatButton(
                    child: Text("create one", style: redBoldText, textAlign: TextAlign.center,),
                    onPressed: () {
                      
                    },
                  )
                ],
              ),
            )*/
            
          ],
        ),
      ),
    );
        },
      ),
    );


  }
}