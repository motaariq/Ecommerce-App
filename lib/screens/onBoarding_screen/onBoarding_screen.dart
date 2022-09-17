import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/components/conistants.dart';
import 'package:ecommerce/components/controllers.dart';
import 'package:ecommerce/screens/login_screen/loginScreen.dart';
import 'package:ecommerce/shared/Cache/cacheHelper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//boarding info class
class boardingModel {
  final String image;
  final String title;
  final String body;

  boardingModel({required this.image, required this.title, required this.body});
}



// ignore: must_be_immutable
class onBoardingScreen extends StatefulWidget {
  @override
  _onBoardingScreenState createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<boardingModel> boarding = [
    boardingModel(
        image: 'assets/images/onboarding.jpg',
        title: 'Welcome',
        body: 'You will find all the products you need here.'),
    boardingModel(
        image: 'assets/images/onboarding2.jpg',
        title: 'Easy',
        body: 'We are the simplest way to find your things and get it.'),
    boardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'Support',
        body: 'You can contact us to know your order updates.'),
  ];

  void submit() {
    cacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        navigatePush(context, loginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                'Skip',
                style: TextStyle(fontFamily: 'jannah'),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('is last');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    onBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: SwapEffect(
                      type: SwapType.yRotation, activeDotColor: Colors.blue),
                ),
                Spacer(),
                Container(
                    height: 43,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextButton(
                      onPressed: () {
                        if (isLast == false) {
                          boardingController.nextPage(
                              duration: Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        } else {
                          submit();
                        }
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontFamily: 'jannah',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
