import 'package:agence/home/cubitHome/cupit_home.dart';
import 'package:agence/home/cubitHome/homeStates.dart';
import 'package:agence/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  var email = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CupitHome, ShopeHomeStates>(
      builder: (BuildContext context, state) {
        var model = CupitHome.get(context).profilemodel;
        email.text = model!.data!.email!;
        name.text = model.data!.name!;
        phone.text = model.data!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              defaultForm(
                  controller: email,
                  type: TextInputType.emailAddress,
                  valid: () {},
                  lable: const Text('Email'),
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.email)),
              const SizedBox(
                height: 20,
              ),
              defaultForm(
                  controller: name,
                  type: TextInputType.text,
                  valid: () {},
                  lable: const Text('Name'),
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.person)),
              const SizedBox(
                height: 20,
              ),
              defaultForm(
                  controller: phone,
                  type: TextInputType.phone,
                  valid: () {},
                  lable: const Text('Phoen'),
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.phone)),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
