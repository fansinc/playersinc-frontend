import 'package:flutter/material.dart';
import 'package:playersinc/config/app_config.dart';
import 'package:playersinc/providers/profile_provider.dart';
import '/models/missions_model.dart';
import '/providers/missions_provider.dart';
import '/config/app_strings.dart';
import '/pages/email_auth_page.dart';

import 'package:provider/provider.dart';

import 'video_player_widget.dart';

class MissionsWidget extends StatefulWidget {
  const MissionsWidget({Key? key}) : super(key: key);

  @override
  State<MissionsWidget> createState() => _MissionsWidgetState();
}

class _MissionsWidgetState extends State<MissionsWidget> {
  bool isInit = true;
  bool isLoading = false;

  List<Missions> missionsList = [];
  late String missionId;
  String missionStatusId = '1';

  final url =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<MissionsProvider>(context).fetchSetMissions().then((value) {
        missionsList = value;

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
      await Provider.of<MissionsProvider>(context, listen: false)
          .submitPlayerMission(
        playerId.toString(), missionId, missionStatusId,
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
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: ListView.builder(
              itemCount: missionsList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // ignore: prefer_typing_uninitialized_variables
                var borderColor;
                if (missionsList[index].name == 'Bronze') {
                  borderColor = const Color(AppConfig.bronzeColor);
                }
                if (missionsList[index].name == 'Silver') {
                  borderColor = const Color(AppConfig.silverColor);
                }
                if (missionsList[index].name == 'Gold') {
                  borderColor = const Color(AppConfig.goldColor);
                }
                return Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor),
                  // border: Border.all(color: borderColor)),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          alignment: Alignment.topRight,
                          child: const Icon(Icons.lock_outline),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        VideoPlayerWidget(url, 200.0, 300.0),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          missionsList[index].name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          missionsList[index].name,
                          style: const TextStyle(
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(
                                    AppConfig.concussionPageCircleColor)),
                            onPressed: validateCreate,
                            //() {},
                            child: const Text(
                              AppStrings.startMission,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
