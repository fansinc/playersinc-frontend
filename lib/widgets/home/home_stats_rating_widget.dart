import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:playersinc/config/app_strings.dart';
import '/config/app_config.dart';

class HomeStatsRatingWidget extends StatefulWidget {
  const HomeStatsRatingWidget({Key? key}) : super(key: key);

  @override
  State<HomeStatsRatingWidget> createState() => _HomeStatsRatingWidgetState();
}

class _HomeStatsRatingWidgetState extends State<HomeStatsRatingWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: deviceWidth * .25,
          lineWidth: 10.0,
          percent: 0.76,
          //listDocuments!.documentUploadPct! / 100,
          linearGradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            /*  stops: [
                    0.1,
                    0.4,
                    0.6,
                    0.9,
                  ], */
            colors: [
              Color(AppConfig.circularIndicatorGradientStartColor),
              Color(AppConfig.circularIndicatorGradientMidColor),
              Color(AppConfig.circularIndicatorGradientEndColor),
            ],
          ),
          center: Container(
            padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '76% \n Rating',
                  textAlign: TextAlign.center,
                  // '${listDocuments!.documentUploadPct!}%',
                  style: TextStyle(
                    color: Colors.white,
                    //Color(AppConfig.blueColor),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  AppStrings.brainSkills,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CircularPercentIndicator(
                  radius: deviceWidth * .15,
                  lineWidth: 5.0,
                  percent: 0.55,
                  //listDocuments!.documentUploadPct! / 100,
                  linearGradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    /*  stops: [
                        0.1,
                        0.4,
                        0.6,
                        0.9,
                      ], */
                    colors: [
                      Color(AppConfig.circularIndicatorGradientStartColor),
                      Color(AppConfig.circularIndicatorGradientMidColor),
                      Color(AppConfig.circularIndicatorGradientEndColor),
                    ],
                  ),
                  center: Container(
                    padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '55%',
                          textAlign: TextAlign.center,
                          // '${listDocuments!.documentUploadPct!}%',
                          style: TextStyle(
                            color: Colors.white,
                            //Color(AppConfig.blueColor),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  AppStrings.rugbySkills,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CircularPercentIndicator(
                  radius: deviceWidth * .15,
                  lineWidth: 5.0,
                  percent: 0.70,
                  //listDocuments!.documentUploadPct! / 100,
                  linearGradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    /*  stops: [
                        0.1,
                        0.4,
                        0.6,
                        0.9,
                      ], */
                    colors: [
                      Color(AppConfig.circularIndicatorGradientStartColor),
                      Color(AppConfig.circularIndicatorGradientMidColor),
                      Color(AppConfig.circularIndicatorGradientEndColor),
                    ],
                  ),
                  center: Container(
                    padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '70%',
                          textAlign: TextAlign.center,
                          // '${listDocuments!.documentUploadPct!}%',
                          style: TextStyle(
                            color: Colors.white,
                            //Color(AppConfig.blueColor),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  AppStrings.physicalSkills,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CircularPercentIndicator(
                  radius: deviceWidth * .15,
                  lineWidth: 5.0,
                  percent: 0.90,
                  //reverse: true,
                  //listDocuments!.documentUploadPct! / 100,
                  linearGradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    /*  stops: [
                        0.1,
                        0.4,
                        0.6,
                        0.9,
                      ], */
                    colors: [
                      Color(AppConfig.circularIndicatorGradientStartColor),
                      Color(AppConfig.circularIndicatorGradientMidColor),
                      Color(AppConfig.circularIndicatorGradientEndColor),
                    ],
                  ),
                  center: Container(
                    padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '90%',
                          textAlign: TextAlign.center,
                          // '${listDocuments!.documentUploadPct!}%',
                          style: TextStyle(
                            color: Colors.white,
                            //Color(AppConfig.blueColor),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //progressColor: const Color(AppConfig.circularIndicatorColor),
                  /*   listDocuments!.documentUploadPct! / 100 == 100
                                          ? Colors.green
                                          : Colors.red, */
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
