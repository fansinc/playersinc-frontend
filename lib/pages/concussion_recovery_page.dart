import 'package:flutter/material.dart';
import 'package:playersinc/config/app_strings.dart';
import 'package:playersinc/models/concussion_model.dart';
import 'package:playersinc/providers/concussion_provider.dart';
import 'package:provider/provider.dart';
import '/config/app_config.dart';

import '/widgets/concussion_recovery_widget.dart';
import 'email_auth_page.dart';

class ConcussionRecoveryPage extends StatefulWidget {
  static const routeName = '/concussionRecoveryPage';
  const ConcussionRecoveryPage({Key? key}) : super(key: key);

  @override
  State<ConcussionRecoveryPage> createState() => _ConcussionRecoveryPageState();
}

class _ConcussionRecoveryPageState extends State<ConcussionRecoveryPage> {
  bool isInit = true;
  bool isLoading = false;

  List<ConcussionModel> concussionList = [];

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ConcussionProvider>(context, listen: false)
          .fetchSetConcussion()
          .then((value) {
        concussionList = value;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
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
                        Navigator.of(context)
                            .pop(); // Navigate to previous screen
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
  }

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
      backgroundColor: const Color(AppConfig.concussionRecoveryPageBGColor),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : concussionList.isNotEmpty
              ? ConcussionRecoveryPageWidget(
                  concussionDate: concussionList[0].concussionDate)
              : Image.asset(
                  AppConfig.noDataImage,
                ),
    ));
  }
}
