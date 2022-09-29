import '/config/app_strings.dart';

import '/config/app_config.dart';
//import '/models/experiences_model.dart';
import 'package:flutter/material.dart';

import '/widgets/bottom_navbar_widget.dart';

//import 'email_auth_page.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = '/notificationPage';

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isInit = true;
  bool isLoading = false;

  /*  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ExperiencesProvider>(context)
          .fetchSetExperiences()
          .then((value) {
        experiencesList = value;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pop(); // Navigate to previous screen
                        if (error.toString() == AppStrings.tokenExpiryMessage) {
                          Navigator.of(context)
                              .pushReplacementNamed(EmailAuthPage.routeName);
                        }
                      },
                      icon: Icon(Icons.close),
                      label: Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
    isInit = false;
  } */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            //automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text(
              AppStrings.notifications,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(
              //color: Color(AppColors.blueColor),
              color: Colors.white, //change your color here
            ),
          ),
          body: isLoading
              ? Container(
                  color: const Color(AppConfig.blackColor),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
          backgroundColor: const Color(AppConfig.notificationPageColor),
          bottomNavigationBar: const BottomNavBarWidget(3),
        ));
  }
}
