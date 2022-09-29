// ignore_for_file: prefer_typing_uninitialized_variables

import '/pages/notificiation_page.dart';

import '/pages/profile_page.dart';

//import '/config/app_config.dart';
import 'package:flutter/material.dart';

class LogoProfileWidget extends StatelessWidget {
  final bgColor, iconColor;
  const LogoProfileWidget(this.bgColor, this.iconColor, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      // const Color(AppConfig.blueColor),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child:
          /* Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppConfig.logoImage,
            height: 50,
          ), */
          Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[400],
            child: Center(
              child: IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(NotificationPage.routeName),
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: iconColor,
                    //Color(AppConfig.blueColor),
                    //Colors.grey[400],
                    size: 20,
                  )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[400],
            child: Center(
              child: IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(ProfilePage.routeName),
                  icon: Icon(
                    Icons.person,
                    color: iconColor,
                    //Color(AppConfig.blueColor),
                    //Colors.grey[400],
                    size: 20,
                  )),
            ),
          ),
        ],
      ),
      //],
      //),
    );
  }
}
