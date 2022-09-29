//import '/pages/email_auth_page.dart';
import 'package:flutter/material.dart';
import '/config/app_config.dart';
import '/widgets/home/skills_page_widget.dart';

import '/config/app_strings.dart';

class SkillsPage extends StatefulWidget {
  static const routeName = '/skillsPage';

  const SkillsPage({Key? key}) : super(key: key);
  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  bool isInit = true;
  bool isLoading = false;
  /* late List<MyTopPlayModel> myTopPlayList;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      myTopPlayList = [];
      Provider.of<MyTopPlayProvider>(context, listen: false)
          .fetchSetTopPlay()
          .then((value) {
        myTopPlayList = value;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        //print(error);
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
                        if (error.toString() == AppStrings.tokenExpiryMessage) {
                          Navigator.of(context)
                              .pushReplacementNamed(EmailAuthPage.routeName);
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
  } */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text(
              AppStrings.skillsPageTitle,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(
              //color: Color(AppColors.blueColor),
              color: Colors.white, //change your color here
            ),
          ),
          backgroundColor: const Color(AppConfig.skillsPageBGColor),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SkillsPageWidget()),
    );
  }
}
