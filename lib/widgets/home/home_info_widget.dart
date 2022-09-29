// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '/config/app_config.dart';
import '/config/app_strings.dart';

class HomeInfoWidget extends StatefulWidget {
  final schoolName, supportTeam, superStrength;
  const HomeInfoWidget(
    this.schoolName,
    this.supportTeam,
    this.superStrength, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeInfoWidget> createState() => _HomeInfoWidgetState();
}

class _HomeInfoWidgetState extends State<HomeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    return
        // height: deviceHeight * .5,
        //color: const Color(AppConfig.blueColor),

        Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: const Color(AppConfig.tabGreyColor),
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  AppStrings.school,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.schoolName,
                  //AppStrings.school,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: const Color(AppConfig.tabGreyColor),
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  AppStrings.favTeam,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.supportTeam,
                  // AppStrings.favTeam,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: const Color(AppConfig.tabGreyColor),
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                alignment: Alignment.topLeft,
                child: const Text(
                  AppStrings.superStrength,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.superStrength,
                  // AppStrings.superStrength,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
