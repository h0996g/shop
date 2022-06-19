import 'package:agence/modeles/Loginmodeles.dart';

abstract class LoginStates {}

class InitialState extends LoginStates {}

class ConditionalLodinState extends LoginStates {}

class GoodLoginState extends LoginStates {
  final LoginModel mod;

  GoodLoginState(this.mod);
}

class BadLoginState extends LoginStates {
  final error;

  BadLoginState(this.error);
}

class HiddenPasswordState extends LoginStates {}

class PutcacheonbordingStates extends LoginStates {}

class SharedSkipState extends LoginStates {}
