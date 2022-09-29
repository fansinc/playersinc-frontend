import 'package:flutter/material.dart';
import 'package:playersinc/widgets/logo_profile_widget.dart';
import 'package:playersinc/widgets/missions_widget.dart';
import '/widgets/bottom_navbar_widget.dart';

import '/config/app_strings.dart';

class MissionsPage extends StatefulWidget {
  static const routeName = '/missionsPage';

  const MissionsPage({Key? key}) : super(key: key);

  @override
  _MissionsPageState createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        // appBar: AppBar(),
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
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        // height: 550,
                        /*  decoration: BoxDecoration(
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
                          ),*/
                        child: Column(
                          children: const [
                            Text(
                              AppStrings.missions,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(child: MissionsWidget()),
                          ],
                        ),
                      ),
                    ]))),
        bottomNavigationBar: const BottomNavBarWidget(3),
      ),
    );
  }
}
