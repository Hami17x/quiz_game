import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/constants.dart';
import 'package:quiz_game/game/view/home.dart';
import 'package:quiz_game/helper/privacy_policy.dart';
import 'package:quiz_game/onboard_provider.dart';
import 'package:quiz_game/pages/privacy_policy_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  bool isFirstPage = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
              isFirstPage = index == 0;
            });
          },
          children: [
            Container(
              color: Colors.blue,
              child: Center(child: Text("Page1")),
            ),
            Container(
              color: Colors.purple,
              child: Center(child: Text("Page1")),
            ),
            ThirdPageOnBoard()
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              color: Colors.teal,
              child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal.shade600,
                      minimumSize: Size.fromHeight(80)),
                  onPressed: context.watch<OnBoardProvider>().isChecked
                      ? () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool("showHome", true);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      : null,
                  child: Text("GET STARTED")),
            )
          : Container(
              color: Colors.lightGreen,
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: !isFirstPage
                          ? () {
                              controller.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          : null,
                      child: Text("Back")),
                  Center(
                    child:
                        SmoothPageIndicator(controller: controller, count: 3),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: Text("Next")),
                ],
              ),
            ),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: privacyPolicy,
    );
  }
}

class ThirdPageOnBoard extends StatefulWidget {
  const ThirdPageOnBoard({Key? key}) : super(key: key);

  @override
  State<ThirdPageOnBoard> createState() => _ThirdPageOnBoardState();
}

class _ThirdPageOnBoardState extends State<ThirdPageOnBoard> {
  final String appName = " Quiz App";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CheckboxListTile(
                title: Text("I ACCEPT THE TERMS OF CONDITIONS"),
                value: context.watch<OnBoardProvider>().isChecked,
                onChanged: (value) {
                  context.read<OnBoardProvider>().changeChecked();
                }),
          ),
          InkWell(
            onTap: () async {
              final Uri _url = Uri.parse(privacyPolicyUrl);

              if (!await launchUrl(_url)) {
                throw 'Could not launch $_url';
              }

              /*
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
                  */
            },
            child: const Text(
              "Terms Of Conditions",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
