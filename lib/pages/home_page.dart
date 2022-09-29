import '/pages/profile_page.dart';

import '/config/app_strings.dart';
import '/models/profile_model.dart';
import '/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '/config/app_config.dart';
//import '/models/news_model.dart';

import 'package:flutter/material.dart';

import '/widgets/home/home_page_widget.dart';
import '/widgets/bottom_navbar_widget.dart';
import 'email_auth_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;

  late ProfileModel profileData;

  bool profileCreated = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ProfileProvider>(context, listen: false)
          .fetchSetUserProfile()
          .then((value) {
        profileData = value;
        profileCreated = true;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        // print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        /*   Navigator.of(context)
                            .pop(); // Navigate to previous screen */
                        if (error.toString() == AppStrings.tokenExpiryMessage) {
                          Navigator.of(context)
                              .pushReplacementNamed(EmailAuthPage.routeName);
                        }
                        if (error
                            .toString()
                            .contains('Profile is not created Yet')) {
                          profileCreated = false;
                          Navigator.of(context)
                              .pushNamed(ProfilePage.routeName);
                        }
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(AppStrings.close))
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
  }

  @override
  Widget build(BuildContext context) {
    //final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        bottom: true,
        child: Scaffold(
          //appBar: AppBar(),
          body: isLoading
              ? Container(
                  color: const Color(AppConfig.blackColor),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  //height: deviceHeight,
                  child: profileCreated
                      ? const HomePageWidget()
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                AppStrings.profileNotCreated,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                      AppConfig.blueColor,
                                    )),
                              ),
                              Image.asset(AppConfig.noDataImage),
                              SizedBox(
                                  //padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  width: 300,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              const Color(AppConfig.blueColor)),
                                      onPressed: () => Navigator.of(context)
                                              .pushNamed(ProfilePage.routeName,
                                                  arguments: {
                                                "profileCreated": false,
                                              }),
                                      child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(AppStrings.createProfile),
                                      ))),
                            ],
                          ),
                        ),
                ),
          //backgroundColor: Colors.white,
          //const Color(AppConfig.blackColor),
          bottomNavigationBar: const BottomNavBarWidget(0),
        ));
  }
}
