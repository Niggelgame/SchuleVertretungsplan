import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


abstract class ApiTokenState extends Equatable {
  const ApiTokenState();

  @override 
  List<Object> get props => [];
}

class ApiTokenLoaded extends ApiTokenState {
  final String apiToken;
  const ApiTokenLoaded({@required this.apiToken});

  @override 
  List<Object> get props => [apiToken];

  @override 
  String toString() => "ApiTokenLoaded: { apiToken: $apiToken }";
}

class ApiTokenUninitialized extends ApiTokenState {}

class ApiTokenLoading extends ApiTokenState {}

class ApiTokenFailure extends ApiTokenState {
  final String error; 
  const ApiTokenFailure({@required this.error});

  @override 
  List<Object> get props => [error];

  @override 
  String toString() => 'ApiToken { error : $error }';
}