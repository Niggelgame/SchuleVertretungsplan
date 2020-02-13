

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];

  @override 
  String toString() => 'LoginButtonPressed { username: $username, password: $password }';
}

class SignupButtonPressed extends LoginEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String password;

  const SignupButtonPressed({
    @required this.firstname,
    @required this.lastname,
    @required this.email,
    @required this.username,
    @required this.password
  });

  @override
  List<Object> get props => [firstname, lastname, email, username, password];

  @override 
  String toString() => 'SignupButtonPresed { firstname: $firstname, lastname: $lastname, email: $email, username: $username, password: $password';
  
}