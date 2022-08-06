import 'package:agence/home/cubitHome/cupit_home.dart';
import 'package:agence/login/cupitlogin/cupitl.dart';
import 'package:agence/login/cupitlogin/statesh.dart';
import 'package:agence/login/other/cachhelper.dart';
import 'package:agence/shared/components/constante.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Register/register.dart';
import '../home/home.dart';
import '../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultForm(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: Text(
                            'Email',
                            style: TextStyle(
                                color: CupitHome.get(context).dartSwitch
                                    ? Colors.white
                                    : Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Email Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: Icon(
                            Icons.email,
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.white
                                : Colors.grey,
                          ),
                          textInputAction: TextInputAction.next),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultForm(
                        textInputAction: TextInputAction.done,
                        controller: passController,
                        type: TextInputType.visiblePassword,
                        onFieldSubmitted: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).login(
                                pass: passController.text,
                                email: emailController.text);
                          }
                        },
                        obscureText: LoginCubit.get(context).ishidden,
                        valid: (value) {
                          if (value.isEmpty) {
                            return 'Password Must Be Not Empty';
                          }
                        },
                        lable: Text(
                          'Password',
                          style: TextStyle(
                              color: CupitHome.get(context).dartSwitch
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.password,
                            color: CupitHome.get(context).dartSwitch
                                ? Colors.white
                                : Colors.grey),
                        sufixIcon: IconButton(
                          onPressed: () {
                            LoginCubit.get(context).showpass();
                          },
                          icon: LoginCubit.get(context).iconhidden,
                          color: CupitHome.get(context).dartSwitch
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('forget password ?'),
                          const Spacer(),
                          ConditionalBuilder(
                            builder: (BuildContext context) {
                              return FloatingActionButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).login(
                                        pass: passController.text,
                                        email: emailController.text);
                                  }
                                },
                                child: const Icon(Icons.arrow_forward_ios),
                              );
                            },
                            condition: state is! ConditionalLodinState,
                            fallback: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )
                        ],
                      ),
                      Center(
                        child: TextButton(
                          child: const Text('Register Now '),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is GoodLoginState) {
          if (state.mod.status!) {
            Fluttertoast.showToast(
                msg: state.mod.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            CachHelper.putcache(key: 'token', value: state.mod.data?.token)
                .then((value) {
              TOKEN = state.mod.data!.token!;

              CupitHome.get(context).getHomeData();
              CupitHome.get(context).getFAvorite();
              CupitHome.get(context).userDetail();
              // CupitHome.get(context).profilemodel =
              //     LoginCubit.get(context).loginonfomodel;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false).then((value) {});
            });
          } else {
            Fluttertoast.showToast(
                msg: state.mod.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
    );
  }
}
