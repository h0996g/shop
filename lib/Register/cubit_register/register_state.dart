part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ConditionalLodinState extends RegisterState {}

class HiddenRegisterPasswordState extends RegisterState {}

class GoodRegisterState extends RegisterState {
  final LoginModel mod;

  GoodRegisterState(this.mod);
}

class BadRegisterState extends RegisterState {
  final error;

  BadRegisterState(this.error);
}
