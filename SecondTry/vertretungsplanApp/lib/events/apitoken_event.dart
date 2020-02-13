import 'package:equatable/equatable.dart';



abstract class ApiTokenEvent extends Equatable {
  const ApiTokenEvent();
  @override 
  List<Object> get props => [];
}


class PageOpenedEvent extends ApiTokenEvent{}