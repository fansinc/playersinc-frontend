import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '/providers/challenges_provider.dart';
import '/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '/widgets/video_player_widget.dart';

import '/config/app_strings.dart';
import '/config/app_config.dart';

class ChallengeSubmitPage extends StatefulWidget {
  static const routeName = '/challengeSubmitPage';

  const ChallengeSubmitPage({Key? key}) : super(key: key);

  @override
  _ChallengeSubmitPageState createState() => _ChallengeSubmitPageState();
}

class _ChallengeSubmitPageState extends State<ChallengeSubmitPage> {
  final url =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  bool isInit = true;
  bool isLoading = false;

  late String challengeId;
  String challengeStatusId = '1';

  void validateCreate() async {
    // if (_formKey.currentState.validate()) {
    /*   var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) { */
    try {
      // _formKey.currentState!.save();
      //symptoms.add(int.parse(selectedSymptom));
      final playerId = Provider.of<ProfileProvider>(context, listen: false)
          .profileModel
          .userId;
      await Provider.of<ChallengesProvider>(context, listen: false)
          .submitPlayerChallenge(
        playerId.toString(), challengeId, challengeStatusId,
        //symptoms
      );
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.challengeSubmitSuccess),
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
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    challengeId = args['challengeId'].toString();

    return SafeArea(
        bottom: true,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            //automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text(
              AppStrings.challengeTitle,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(
              //color: Color(AppColors.blueColor),
              color: Colors.black, //change your color here
            ),
          ),
          body: SingleChildScrollView(
              child: SizedBox(
                  // color: const Color(AppConfig.healthCheckPageColor),
                  width: double.infinity,
                  //Colors.black,
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(30, 40, 30, 40),
                          height: 600,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(
                                    AppConfig.challengeSubmitPageBGStartColor),
                                Color(AppConfig.challengeSubmitPageBGEndColor),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              VideoPlayerWidget(url, 200.0, 300.0),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                args['challengeLevelName'],
                                //'Challenge Level 1 - Stage 1',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                args['description'],
                                //'Challenge description section',
                                style: const TextStyle(
                                  fontSize: 12,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                width: double.infinity,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Skills',
                                          style: TextStyle(
                                            fontSize: 18,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          AppStrings.physicalSkills,
                                          //'Physical Skills',
                                          style: TextStyle(
                                            fontSize: 12,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 5),
                                        child: LinearPercentIndicator(
                                          width: 280,
                                          lineHeight: 14.0,
                                          percent: double.parse(
                                                  args['physicalSkills']) /
                                              100,
                                          // 0.7,
                                          center: Text(
                                            args['physicalSkills'],
                                            //"70.0%",
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          backgroundColor: Colors.grey[300],
                                          progressColor: const Color(AppConfig
                                              .concussionPageCircleColor),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          AppStrings.brainSkills,
                                          // 'Brain Skills',
                                          style: TextStyle(
                                            fontSize: 12,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 5),
                                        child: LinearPercentIndicator(
                                          width: 280,
                                          lineHeight: 14.0,
                                          percent: double.parse(
                                                  args['brainSkills']) /
                                              100,
                                          center: Text(
                                            args['brainSkills'],
                                            // "90.0%",
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          backgroundColor: Colors.grey[300],
                                          progressColor: const Color(AppConfig
                                              .concussionPageCircleColor),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          AppStrings.rugbySkills,
                                          //'Rugby Skills',
                                          style: TextStyle(
                                            fontSize: 12,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 5, 5),
                                        child: LinearPercentIndicator(
                                          width: 280,
                                          lineHeight: 14.0,
                                          percent: double.parse(
                                                  args['rugbySkills']) /
                                              100,
                                          center: Text(
                                            args['rugbySkills'],
                                            //"55.0%",
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          backgroundColor: Colors.grey[300],
                                          progressColor: const Color(AppConfig
                                              .concussionPageCircleColor),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(
                                          AppConfig.concussionPageCircleColor)),
                                  onPressed: validateCreate,
                                  //() {},
                                  child: const Text(
                                    AppStrings.submit,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ]))),
        ));
  }
}
