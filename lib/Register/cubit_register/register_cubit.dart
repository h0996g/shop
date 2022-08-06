import 'package:agence/shared/components/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../diohelper/dio_helper.dart';
import '../../modeles/Loginmodeles.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  Icon iconhidden = Icon(Icons.visibility);
  LoginModel? registerinfomodel;

  void register({
    required String pass,
    required String email,
    required String name,
    required String phone,
  }) {
    emit(ConditionalLodinState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': pass,
    }).then((value) {
      print('ook');
      // print(value.data);
      registerinfomodel = LoginModel.fromjson(value.data);
      print(registerinfomodel!.status);
      print(registerinfomodel!.data!.token);
      print(registerinfomodel!.data!.email);
      emit(GoodRegisterState(registerinfomodel!));
    }).catchError((error) {
      print(error.toString());
      emit(BadRegisterState(error));
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
    emit(HiddenRegisterPasswordState());
  }
}
