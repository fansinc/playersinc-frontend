import 'package:flutter/material.dart';
import '/config/app_config.dart';

import '/widgets/concussion_widget.dart';

class ConcussionPage extends StatelessWidget {
  static const routeName = '/concussionPage';
  const ConcussionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        /*  centerTitle: true,
        title: const Text(
          AppStrings.profilePage,
          style: TextStyle(color: Colors.white),
        ), */
        backgroundColor: Colors.transparent,
        // const Color(AppConfig.concussionPageColor1),
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          //color: Color(AppColors.blueColor),
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(AppConfig.concussionLogPageTopColor),
      body: const ConcussionPageWidget(),
    ));
  }
}
