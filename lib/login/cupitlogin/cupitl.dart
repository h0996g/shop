import 'package:agence/diohelper/dio_helper.dart';
import 'package:agence/login/cupitlogin/statesh.dart';
import 'package:agence/modeles/Loginmodeles.dart';
import 'package:agence/shared/components/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  Icon iconhidden = Icon(Icons.visibility);
  late LoginModel json;

  void login({required String pass, required String email}) {
    emit(ConditionalLodinState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': pass})
        .then((value) {
      // print(value.data);
      json = LoginModel.fromjson(value.data);
      print(json.status);
      print(json.data?.token);
      print(json.data?.email);
      emit(GoodLoginState(json));
    }).catchError((error) {
      print(error.toString());
      emit(BadLoginState(error));
    });
  }

  bool ishidden = true;
  void showpass() {
    if (ishidden) {
      iconhidden = Icon(Icons.visibility_off);
      ishidden = !ishidden;
    } else {
      iconhidden = Icon(Icons.visibility);
      ishidden = !ishidden;
    }
    emit(HiddenPasswordState());
  }
}
