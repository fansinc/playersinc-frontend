// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/pages/skills_page.dart';
import '/providers/profile_provider.dart';
import '/pages/my_top_play_page.dart';
import '/pages/session_data_page.dart';
import '/models/injury_model.dart';
import '/pages/injury_data_page.dart';
import '/providers/injury_provider.dart';
import '/models/log_time_model.dart';
import '/pages/email_auth_page.dart';

import '/providers/log_time_provider.dart';
import 'package:provider/provider.dart';
import '/config/app_config.dart';
import '/config/app_strings.dart';

class HomeMySeasonWidget extends StatefulWidget {
  final schoolName, supportTeam, superStrength;
  const HomeMySeasonWidget(
    this.schoolName,
    this.supportTeam,
    this.superStrength, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeMySeasonWidget> createState() => _HomeMySeasonWidgetState();
}

class _HomeMySeasonWidgetState extends State<HomeMySeasonWidget> {
  int _intensity = 1;
  DateTime selectedDate = DateTime.now();
  late String playDate;
  int trainingTime = 0;
  int gameTime = 0;
  int totalTime = 0;

  bool isInit = true;
  bool isLoading = false;

  late List<LogTimeModel> sessionData;
  late List<InjuryModel> injuryData;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<LogTimeProvider>(context, listen: false)
          .fetchSetLogTime()
          .then((sessionVal) {
        sessionData = sessionVal;
        Provider.of<InjuryProvider>(context, listen: false)
            .fetchSetPlayerInjury()
            .then((injuryVal) {
          injuryData = injuryVal;
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
                          if (error.toString() ==
                              AppStrings.tokenExpiryMessage) {
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
  }

  void validateCreate() async {
    // if (_formKey.currentState.validate()) {
    /*   var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) { */
    try {
      // _formKey.currentState!.save();
      final playerId = Provider.of<ProfileProvider>(context, listen: false)
          .profileModel
          .userId;
      totalTime = gameTime + trainingTime;
      await Provider.of<LogTimeProvider>(context, listen: false).createLogTime(
        playerId.toString(), //'1',
        playDate,
        trainingTime.toString(),
        gameTime.toString(),
        _intensity,
        totalTime.toString(),
      );
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.logPlayTimeSuccess),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // dismiss the alert dialog
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
            String errorMsg;
            if (error
                .toString()
                .contains("Field 'playDate' has not been initialized.")) {
              errorMsg = 'Please select the playing date';
            } else {
              errorMsg = error.toString();
            }
            return AlertDialog(
              title: const Text(AppStrings.error),
              content: Text(errorMsg),
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
    final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;
    return
        // height: deviceHeight * .5,
        //color: const Color(AppConfig.blueColor),

        SingleChildScrollView(
      child: isLoading
          ? const CircularProgressIndicator(
              //color: Colors.white,
              )
          : Column(
              children: [
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          contentPadding: const EdgeInsets.all(0),
                          backgroundColor:
                              const Color(AppConfig.logGameTimeColor),
                          content: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return SizedBox(
                              height: 450,
                              child: Column(
                                children: [
                                  /* ClipRRect(
                               borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              child: */
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    /* color: const Color(
                                    AppConfig.concussionAlertDialogColor), */
                                    width: double.infinity,
                                    child: const Text(AppStrings.logPlayTime,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        )),
                                  ),
                                  // ),
                                  GestureDetector(
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: selectedDate,
                                              //DateTime.now(),
                                              firstDate: DateTime(1960, 1),
                                              lastDate: DateTime.now());
                                      //DateTime(2101));
                                      if (picked != null &&
                                          picked != selectedDate) {
                                        setState(() {
                                          selectedDate = picked;
                                          playDate = DateFormat('dd/MM/yyyy')
                                              .format(selectedDate);
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(AppConfig
                                              .concussionAlertDialogBtnColor)),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      margin: const EdgeInsets.fromLTRB(
                                          40, 5, 40, 10),
                                      //height: 60,
                                      //width: 150,

                                      child: Text(
                                        DateFormat('dd   |   MMMM   |   yyyy')
                                            .format(selectedDate),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              AppStrings.trainingTime,
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            height: 20,
                                            //width: 60,
                                          ),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color(AppConfig
                                                    .concussionAlertDialogBtnColor)),
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: -23),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        trainingTime =
                                                            int.parse(value);
                                                        totalTime =
                                                            trainingTime +
                                                                gameTime;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const Text(
                                                  AppStrings.mins,
                                                  // ' $trainingTime ${AppStrings.mins}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            //height: 20,
                                            width: 100,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              AppStrings.gameTime,
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            height: 20,
                                            //width: 60,
                                          ),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color(AppConfig
                                                    .concussionAlertDialogBtnColor)),
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: -23),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        gameTime =
                                                            int.parse(value);
                                                        totalTime =
                                                            trainingTime +
                                                                gameTime;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const Text(
                                                  AppStrings.mins,
                                                  // ' $gameTime ${AppStrings.mins}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //height: 20,
                                            width: 100,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      AppStrings.recordIntensityLevel,
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    height: 20,
                                    //width: 60,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              AppStrings.trainingLow,
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            // height: 20,
                                            //width: 60,
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 20,
                                            child: GestureDetector(
                                                child: CircleAvatar(
                                                  //radius: 20,
                                                  backgroundColor: Colors.grey,
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        _intensity == 1 //low
                                                            ? Colors.white
                                                            : Colors.grey,
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _intensity = 1;
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              AppStrings.trainingMedium,
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            // height: 20,
                                            //width: 60,
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 20,
                                            child: GestureDetector(
                                                child: CircleAvatar(
                                                  //radius: 20,
                                                  backgroundColor: Colors.grey,
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        _intensity ==
                                                                2 // medium
                                                            ? Colors.white
                                                            : Colors.grey,
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _intensity = 2;
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              AppStrings.trainingHigh,
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.red,
                                              ),
                                            ),
                                            //height: 20,
                                            //width: 60,
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 20,
                                            child: GestureDetector(
                                                child: CircleAvatar(
                                                  //radius: 20,
                                                  backgroundColor: Colors.grey,
                                                  child: CircleAvatar(
                                                    radius: 6,
                                                    backgroundColor:
                                                        _intensity == 3 //high
                                                            ? Colors.white
                                                            : Colors.grey,
                                                  ),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _intensity = 3;
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    /* color: const Color(
                                    AppConfig.concussionAlertDialogColor), */
                                    width: double.infinity,
                                    child:
                                        const Text(AppStrings.totalPlayingTime,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            )),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(AppConfig
                                            .concussionAlertDialogBtnColor)),
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Text(
                                      ' $totalTime ${AppStrings.mins}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    //height: 20,
                                    width: 100,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    /* color: const Color(
                                    AppConfig.concussionAlertDialogColor), */
                                    width: double.infinity,
                                    child: const Text(AppStrings.maxDailyTime,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(AppConfig
                                                .concussionAlertDialogColor),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                          ),
                                          onPressed: () => validateCreate(),
                                          /*  {
                                      Navigator.of(context).pop();
                                    } */
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              AppStrings.save,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            height: 20,
                                            width: 60,
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(AppConfig
                                                .concussionAlertDialogBtnColor),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              AppStrings.cancel,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            height: 20,
                                            width: 60,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      }),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(AppConfig.logGameTimeColor),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      AppStrings.logMyGame,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: deviceWidth * .40,
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            color: const Color(AppConfig.logLastPlayedColor),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppStrings.lastPlayed,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              sessionData.isNotEmpty
                                  ? sessionData[0].playingDate
                                  : '',
                              //AppStrings.clickToOpen,
                              //'Monday 25 April 2022',
                              style: const TextStyle(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        width: deviceWidth * .40,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            color: const Color(AppConfig.logSeasonJournalColor),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              AppStrings.seasonJournal,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              AppStrings.clickToOpen,
                              style: TextStyle(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(InjuryDataPage.routeName, arguments: {
                        "injuryData": injuryData,
                      }),
                      child: Container(
                        //alignment: Alignment.centerLeft,
                        height: 100,
                        //margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            color: const Color(
                                AppConfig.tabMySeasonInjuryDataColor),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              AppStrings.injuryData,
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              AppStrings.clickToOpen,
                              style: TextStyle(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(SessionDataPage.routeName, arguments: {
                        "sessionData": sessionData,
                      }),
                      child: Container(
                        //alignment: Alignment.centerLeft,
                        height: 100,
                        // margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            color: const Color(
                                AppConfig.tabMySeasonSessionDataColor),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              AppStrings.sessionData,
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              AppStrings.clickToOpen,
                              style: TextStyle(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(MyTopPlayPage.routeName),
                      child: Container(
                        //alignment: Alignment.centerLeft,
                        height: 100,
                        // margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            /* const Color(
                                AppConfig.tabMySeasonSessionDataColor), */
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              AppStrings.top10,
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Icon(Icons.play_circle)
                            /* Text(
                              AppStrings.clickToOpen,
                              style: TextStyle(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ), */
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    SkillsPage.routeName,
                    /*   arguments: {
                    "injuryData": injuryData,
                  } */
                  ),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(AppConfig.logGameTimeColor),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      AppStrings.skills,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                /* Container(
                  height: 70,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  //width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(
                                AppConfig.tabMySeasonInjuryDataColor),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        alignment: Alignment.centerLeft,
                        width: 90,
                        child: const Text(
                          AppStrings.injuryData,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: injuryData.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  //alignment: Alignment.centerLeft,
                                  width: 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        injuryData[index].injuredPlace,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        injuryData[index].injuredDate,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          /*  decoration: TextDecoration.underline,
                                    decorationColor: Colors.orange, */
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  //width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(
                                AppConfig.tabMySeasonSessionDataColor),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        alignment: Alignment.center,
                        width: 90,
                        child: const Text(
                          AppStrings.sessionData,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: sessionData.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  alignment: Alignment.bottomLeft,
                                  width: 90,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${sessionData[index].totalTime} ${AppStrings.mins}',
                                        //'03/02/22',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          /*  decoration: TextDecoration.underline,
                                        decorationColor: Colors.orange, */
                                        ),
                                      ),
                                      Text(
                                        sessionData[index].playingDate,
                                        //'03/02/22',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          /*  decoration: TextDecoration.underline,
                                        decorationColor: Colors.orange, */
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                    ],
                  ),
                ), */
              ],
            ),
    );
  }
}
