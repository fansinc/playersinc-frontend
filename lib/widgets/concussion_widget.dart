import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playersinc/providers/profile_provider.dart';
import '/providers/concussion_provider.dart';
import 'package:provider/provider.dart';
import '/config/app_strings.dart';
import '/config/app_config.dart';

class ConcussionPageWidget extends StatefulWidget {
  const ConcussionPageWidget({Key? key}) : super(key: key);

  @override
  State<ConcussionPageWidget> createState() => _ConcussionPageWidgetState();
}

class _ConcussionPageWidgetState extends State<ConcussionPageWidget> {
  DateTime selectedDate = DateTime.now();
  late String concussionDate;
  bool isLoading = false;

  late String playerId;

  void validateCreate() async {
    // if (_formKey.currentState.validate()) {
    /*   var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) { */
    try {
      // _formKey.currentState!.save();

      await Provider.of<ConcussionProvider>(context, listen: false)
          .createConcussion(playerId, concussionDate);
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.concussionLogSuccess),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text(AppStrings.close))
              ],
            );
          });
    } catch (error) {
      //print(error);
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.error),
              content: Text(error.toString()),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      /*  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          AuthPage.routeName); */
                    },
                    icon: const Icon(Icons.close),
                    label: const Text(AppStrings.close))
              ],
            );
          });
      setState(() {
        isLoading = false;
      });
      //}
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final profileData =
        Provider.of<ProfileProvider>(context).fetchUserProfile();
    playerId = profileData.userId.toString();
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.topLeft,
                child: Image.asset(AppConfig.concussionHeadImage,
                    height: deviceHeight * .2
                    //150,
                    ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: const Color(AppConfig.concussionLogPageTopColor),
                  child: const Text(
                    AppStrings.logConcussion,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white,
              //const Color(AppConfig.concussionPageTextBGColor),
            ),
            /*     margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5), */
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            alignment: Alignment.center,
            width: double.infinity,
            height: deviceHeight * .7,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  AppStrings.logConcussionDate,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              //DateTime.now(),
                              firstDate: DateTime(1960, 1),
                              lastDate: DateTime.now());
                          //DateTime(2101));
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                              concussionDate =
                                  DateFormat('dd/MM/yyyy').format(selectedDate);
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          height: 40,
                          //width: double.infinity,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color(AppConfig.grey),
                              /*  border: Border.all(
                                        // color: Colors.red,
                                        ), */
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Text(
                            DateFormat('dd-MMM-yyyy').format(selectedDate),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(
                                AppConfig.concussionLogPageTickColor)),
                        onPressed: () => validateCreate(),
                        child: const Text(
                          AppStrings.submit,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //height: 200,
                  //width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: const Color(
                          AppConfig.concussionLogPageHealthGradColor),
                      /*  border: Border.all(
                                  // color: Colors.red,
                                  ), */
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        AppStrings.healthAdvice,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppStrings.concussionRest,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        AppStrings.takeBreak,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        AppStrings.feelingBetter,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  // height: 200,
                  //width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: const Color(
                          AppConfig.concussionLogPageHealthGradColor),
                      /*  border: Border.all(
                                  // color: Colors.red,
                                  ), */
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        AppStrings.graduatedConcussionReturn,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppStrings.concussionMakeLog,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        AppStrings.feelingBetter,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        AppStrings.concussion23Days,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  // validateCreate(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(AppConfig.concussionLogPageTickColor),
                      //Colors.white,
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    //  alignment: Alignment.center,
                    width: 150,
                    // height: 70,
                    child: const Text(
                      AppStrings.ok,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
