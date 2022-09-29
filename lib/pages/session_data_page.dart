//import '/pages/email_auth_page.dart';
import 'package:flutter/material.dart';
import '/models/log_time_model.dart';

import '/config/app_config.dart';
import '/config/app_strings.dart';

class SessionDataPage extends StatefulWidget {
  static const routeName = '/sessionDataPage';

  const SessionDataPage({Key? key}) : super(key: key);
  @override
  State<SessionDataPage> createState() => _SessionDataPageState();
}

class _SessionDataPageState extends State<SessionDataPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final List<LogTimeModel> sessionData = args['sessionData'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            AppStrings.sessionDataPageTitle,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            //color: Color(AppColors.blueColor),
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: const Color(AppConfig.tabMySeasonSessionDataColor),
        body: sessionData.isNotEmpty
            ? SingleChildScrollView(
                child: ListView.builder(
                    itemCount: sessionData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        //padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 0),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: AppStrings.sessionDate,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: sessionData[index]
                                                  .playingDate,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color:
                                                    /* Color(
                                                    AppConfig
                                                        .concussionAlertDialogColor,
                                                  ) */
                                                    Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        /*  Text(
                                              '${AppStrings.injuryDetails} : ${injuryData[index].diagnosis}'), */
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 0),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text:
                                                  '${AppStrings.trainingTime}: ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: sessionData[index]
                                                  .trainingTime,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color:
                                                    /* Color(
                                                    AppConfig
                                                        .concussionAlertDialogColor,
                                                  ) */
                                                    Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        /*  Text(
                                            '${AppStrings.injuryDate} : ${injuryData[index].injuredDate}'), */
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 0),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: '${AppStrings.gameTime}: ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: sessionData[index].gameTime,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color:
                                                    /* Color(
                                                    AppConfig
                                                        .concussionAlertDialogColor,
                                                  ) */
                                                    Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        /*  Text(
                                            '${AppStrings.injuryDate} : ${injuryData[index].injuredDate}'), */
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 0),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: '${AppStrings.totalTime}: ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  sessionData[index].totalTime,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color:
                                                    /* Color(
                                                    AppConfig
                                                        .concussionAlertDialogColor,
                                                  ) */
                                                    Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        /*  Text(
                                            '${AppStrings.injuryDate} : ${injuryData[index].injuredDate}'), */
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text:
                                                  '${AppStrings.trainingLevel}: ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  sessionData[index].levelName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color:
                                                    /* Color(
                                                    AppConfig
                                                        .concussionAlertDialogColor,
                                                  ) */
                                                    Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        /*  Text(
                                            '${AppStrings.injuryDate} : ${injuryData[index].injuredDate}'), */
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 15, 0),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: const Color(
                                        AppConfig.tabMySeasonSessionDataColor),
                                    child: Image.asset(
                                      AppConfig.rugbyBallImage,
                                      //height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      );
                    }),
              )

            //)

            : Container(
                alignment: Alignment.center,
                child: Image.asset(AppConfig.noDataImage),
              ),
      ),
    );
  }
}
