import 'package:flutter/material.dart';

import '/widgets/challenges/challenges_list_widget.dart';
import '/config/app_strings.dart';
import '/config/app_config.dart';
import '/widgets/logo_profile_widget.dart';

import '/widgets/bottom_navbar_widget.dart';

class ChallengesPage extends StatefulWidget {
  static const routeName = '/challengesPage';

  const ChallengesPage({Key? key}) : super(key: key);

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        child: Scaffold(
          //appBar: AppBar(),
          body: SingleChildScrollView(
              child: SizedBox(
                  // color: const Color(AppConfig.healthCheckPageColor),
                  width: double.infinity,
                  //Colors.black,
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LogoProfileWidget(
                            Colors.transparent,
                            //AppConfig.healthCheckPageColor

                            Colors.white),
                        /*  const SizedBox(
                          height: 30,
                        ), */
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                          //height: 650,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(AppConfig.challengeGradientStartColor),
                                Color(AppConfig.challengeGradientEndColor),
                              ],
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            // height: 550,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(AppConfig.challengeGradientStartColor),
                                  Color(AppConfig.challengeGradientEndColor),
                                ],
                              ),
                            ),
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppStrings.myChallenges,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(child: ChallengesListWidget()),
                              ],
                            ),
                          ),
                        ),
                      ]))),
          //backgroundColor: Colors.black,
          bottomNavigationBar: const BottomNavBarWidget(2),
        ));
  }
}
