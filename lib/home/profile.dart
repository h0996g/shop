import 'package:agence/home/cubitHome/cupit_home.dart';
import 'package:agence/home/cubitHome/homeStates.dart';
import 'package:agence/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  Map<String, dynamic> update = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, ShopeHomeStates>(
      builder: (BuildContext context, state) {
        var model = CupitHome.get(context).profilemodel;
        emailController.text = model!.data!.email!;
        nameController.text = model.data!.name!;
        phoneController.text = model.data!.phone!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(children: [
                if (state is LodinUpdateProfileState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Email Must Not Be Empty';
                      }
                    },
                    lable: const Text('Email'),
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.email)),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controller: nameController,
                    type: TextInputType.text,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Name Must Not Be Empty';
                      }
                    },
                    lable: const Text('Name'),
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.person)),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controller: phoneController,
                    type: TextInputType.phone,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Phone Must Not Be Empty';
                      }
                    },
                    lable: const Text('Phoen'),
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.phone)),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: const BoxDecoration(color: Colors.black),
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            update = {
                              'email': emailController.text,
                              'name': nameController.text,
                              'phone': phoneController.text
                            };
                            CupitHome.get(context).updateProfile(update);
                          }
                        },
                        child: const Text(
                          'Edite Profile',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ))),
              ]),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is GoodUpdateProfileState) {
          CupitHome.get(context).userDetail();

          Fluttertoast.showToast(
              msg: 'Succes Update',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is BadUpdateProfileState) {
          Fluttertoast.showToast(
              msg: 'Some Error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }
}
