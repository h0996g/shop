import 'package:agence/login/login.dart';
import 'package:agence/login/other/cachhelper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingModel {
  final String img;
  final String title;
  final String body;

  OnbordingModel(this.img, this.title, this.body);
}

class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  Icon nextIcon = const Icon(Icons.arrow_forward_ios);
  void gotologin() {
    CachHelper.putcache(key: 'onbording', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });
  }

  bool islast = false;
  var onbordingController = PageController();
  List<OnbordingModel> models = [
    OnbordingModel('assets/images/on2.png', 'Title 1', 'Body 1'),
    OnbordingModel('assets/images/on2.png', 'Title 2', 'Body 2'),
    OnbordingModel('assets/images/on2.png', 'Title 3', 'Body 3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  gotologin();
                },
                child: const Text(
                  'SKIP',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == models.length - 1) {
                      islast = true;

                      setState(() {
                        nextIcon = const Icon(Icons.done);
                      });
                    } else {
                      islast = false;

                      setState(() {
                        nextIcon = const Icon(Icons.arrow_forward_ios);
                      });
                    }
                  },
                  controller: onbordingController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => itemView(models[index]),
                  itemCount: 3,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: onbordingController, // PageController
                      count: models.length,
                      effect: const ExpandingDotsEffect(
                          dotWidth: 20,
                          dotHeight: 15,
                          dotColor: Colors.black26,
                          activeDotColor:
                              Colors.deepOrange), // your preferred effect
                      onDotClicked: (index) {}),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      onbordingController.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.fastOutSlowIn);
                      if (islast == true) {
                        gotologin();
                      }
                    },
                    child: nextIcon,
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }

  Widget itemView(OnbordingModel k) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${k.img}'),
          )),
          const SizedBox(height: 20),
          Text(
            '${k.title}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            '${k.body}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 50),
        ],
      );
}
