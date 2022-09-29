import 'package:flutter/material.dart';
import '/pages/challenge_submit_page.dart';
import '/config/app_config.dart';
import '/config/app_strings.dart';
import '/models/challenges_model.dart';
import '/pages/email_auth_page.dart';
import '/providers/challenges_provider.dart';
import 'package:provider/provider.dart';

class ChallengesListWidget extends StatefulWidget {
  const ChallengesListWidget({Key? key}) : super(key: key);

  @override
  State<ChallengesListWidget> createState() => _ChallengesListWidgetState();
}

class _ChallengesListWidgetState extends State<ChallengesListWidget> {
  // List<String> levelList = ['L1', 'L2', 'L3', 'L4', 'L5', 'L6'];
  //List<String> bossList = ['Boss Challenge', '', '', '', '', ''];

  bool isInit = true;
  bool isLoading = false;

  List<Challenges> challengesList = [];
  List<Challenges> platinumChallengesList = [];

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ChallengesProvider>(context)
          .fetchSetChallenges()
          .then((value) {
        challengesList = value['regularChallengesList'];
        platinumChallengesList = value['platinumChallengesList'];
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //height: 250,
                margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: RichText(
                  // textAlign: TextAlign.center,
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Disclaimer: Challenges marked in this ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'color ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(
                          AppConfig.bossChallengeColor,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'are paid challenges',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ),
                /*  const Text(
                  'Challenges marked in this color are paid challenges',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ), */
              ),

              Container(
                //height: 250,
                margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: challengesList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            // height: 40,
                            child: Text(
                              challengesList[index].name,
                              //textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          challengesList[index].challenges.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    AppStrings.noChallenges,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  // alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  height: 40,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: challengesList[index]
                                          .challenges
                                          .length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, indexVal) {
                                        return GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(
                                                  ChallengeSubmitPage.routeName,
                                                  arguments: {
                                                "challengeLevelName":
                                                    challengesList[index]
                                                        .challenges[indexVal]
                                                        .name,
                                                "challengeId":
                                                    challengesList[index]
                                                        .challenges[indexVal]
                                                        .id,
                                                "description":
                                                    challengesList[index]
                                                        .challenges[indexVal]
                                                        .description,
                                                "brainSkills":
                                                    challengesList[index]
                                                        .challenges[indexVal]
                                                        .brainSkills,
                                                "physicalSkills":
                                                    challengesList[index]
                                                        .challenges[indexVal]
                                                        .physicalSkills,
                                                "rugbySkills":
                                                    challengesList[index]
                                                        .challenges[indexVal]
                                                        .rugbySkills
                                              }),
                                          child: Container(
                                            /* margin:
                                          const EdgeInsets.fromLTRB(2, 0, 2, 0), */
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundColor: double.parse(
                                                          challengesList[index]
                                                              .challenges[
                                                                  indexVal]
                                                              .price) >
                                                      0
                                                  ? const Color(AppConfig
                                                      .bossChallengeColor)
                                                  : Colors.white,
                                              child: CircleAvatar(
                                                radius: challengesList[index]
                                                        .challenges[indexVal]
                                                        .isCompleted
                                                    ? 9
                                                    : 10,
                                                backgroundColor: challengesList[
                                                            index]
                                                        .challenges[indexVal]
                                                        .isCompleted
                                                    ? Colors.green
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                        ],
                      );
                    }),
              ),
              // check if the challenge list is having platinum plan details
              if (platinumChallengesList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text(
                        platinumChallengesList[0].name,
                        //'Platinum Level',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    platinumChallengesList[0].challenges.isEmpty
                        ? Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              AppStrings.noChallenges,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            // alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(5, 0, 0, 10),
                            height: 40,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    platinumChallengesList[0].challenges.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, indexVal) {
                                  return GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(
                                            ChallengeSubmitPage.routeName,
                                            arguments: {
                                          "challengeLevelName":
                                              platinumChallengesList[0]
                                                  .challenges[indexVal]
                                                  .name,
                                          "challengeId":
                                              platinumChallengesList[0]
                                                  .challenges[indexVal]
                                                  .id,
                                          "description":
                                              platinumChallengesList[0]
                                                  .challenges[indexVal]
                                                  .description,
                                          "brainSkills":
                                              platinumChallengesList[0]
                                                  .challenges[indexVal]
                                                  .brainSkills,
                                          "physicalSkills":
                                              platinumChallengesList[0]
                                                  .challenges[indexVal]
                                                  .physicalSkills,
                                          "rugbySkills":
                                              platinumChallengesList[0]
                                                  .challenges[indexVal]
                                                  .rugbySkills
                                        }),
                                    child: Container(
                                      /* margin:
                                          const EdgeInsets.fromLTRB(2, 0, 2, 0), */
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      child: platinumChallengesList[0]
                                              .challenges[indexVal]
                                              .isCompleted
                                          ? Icon(
                                              Icons.star_border_outlined,
                                              size: 35,
                                              color: Colors.green[200],
                                            )
                                          : const Icon(Icons.star,
                                              size: 35,
                                              color: Color(AppConfig
                                                  .platinumChallengeStarColor)),
                                    ),
                                    /* Container(
                                          /* margin:
                                              const EdgeInsets.fromLTRB(2, 0, 2, 0), */
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          child: const CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 13,
                                              backgroundColor: Colors.green,
                                            ),
                                          ),
                                        ), */
                                  );
                                }),
                          ),
                  ],
                )
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(
                    Icons.star,
                    size: 40,
                    color: Color(AppConfig.platinumChallengeStarColor),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: Color(AppConfig.platinumChallengeStarColor),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: Color(AppConfig.platinumChallengeStarColor),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: Color(AppConfig.platinumChallengeStarColor),
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: Color(AppConfig.platinumChallengeStarColor),
                  ),
                ],
              ), */
            ],
          );
  }
}
