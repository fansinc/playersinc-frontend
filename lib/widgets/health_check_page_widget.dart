import '/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '/pages/concussion_page.dart';

import '/pages/concussion_recovery_page.dart';

import '/pages/log_injury_page.dart';

import '/config/app_strings.dart';
import '/models/experiences_model.dart';

import '/config/app_config.dart';
import 'package:flutter/material.dart';

import '/widgets/logo_profile_widget.dart';

class HealthCheckPageWidget extends StatefulWidget {
  final List<ExperiencesModel> experiencesList;

  const HealthCheckPageWidget(this.experiencesList, {Key? key})
      : super(key: key);

  @override
  _HealthCheckPageWidgetState createState() => _HealthCheckPageWidgetState();
}

class _HealthCheckPageWidgetState extends State<HealthCheckPageWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;
    final playerProfile =
        Provider.of<ProfileProvider>(context).fetchUserProfile();

    final launchCallUrl = Uri.parse("tel://${playerProfile.contactMobileNo}");

    return SingleChildScrollView(
      child: Container(
        color: const Color(AppConfig.healthCheckPageColor),
        width: double.infinity,
        //Colors.black,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoProfileWidget(
                Color(AppConfig.healthCheckPageColor), Colors.white),
            const SizedBox(
              height: 30,
            ),
            Container(
              //color: const Color(AppConfig.healthCheckPageColor),
              //padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              alignment: Alignment.center,
              child: const Text(
                AppStrings.callButton,
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              //color: const Color(AppConfig.healthCheckPageColor),
              //padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              alignment: Alignment.center,
              child: Text(
                playerProfile.contactName,
                //textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () => launchUrl(launchCallUrl),

                ///launch("tel://${playerProfile.mobileNo}"),
                child: CircleAvatar(
                  radius: 120,
                  backgroundColor:
                      const Color(AppConfig.healthCheckPageICEColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        AppStrings.ice,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 50,
                      ),
                    ],
                  ),
                )

                /*  Image.asset(
                AppConfig.iceImage,
                height: 250,
              ), */
                ),
            const SizedBox(
              height: 20,
            ),
            Container(
              //color: const Color(AppConfig.healthCheckPageColor),
              //padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              alignment: Alignment.center,
              child: const Text(
                AppStrings.notEmergency,
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(ConcussionPage.routeName),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(AppConfig.healthCheckPageButtonColor),
                ),
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                //color: const Color(AppConfig.healthCheckPageColor),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                alignment: Alignment.center,
                child: const Text(
                  AppStrings.concussion,
                  //textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      contentPadding: const EdgeInsets.all(0),
                      /*  backgroundColor:
                          const Color(AppConfig.concussionAlertDialogColor), */
                      content: SizedBox(
                        height: 200,
                        //width: 150,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                color: const Color(
                                    AppConfig.concussionAlertDialogColor),
                                width: double.infinity,
                                child: const Text(AppStrings.stillSymptoms,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
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
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    content: SizedBox(
                                                        height: 200,
                                                        width: 150,
                                                        child: Column(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(10),
                                                                  color: const Color(
                                                                      AppConfig
                                                                          .concussionAlertDialogColor),
                                                                  width: double
                                                                      .infinity,
                                                                  child: const Text(
                                                                      AppStrings
                                                                          .youMustRest,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        40,
                                                                        20,
                                                                        40,
                                                                        10),
                                                                child: RichText(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text: const TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              AppStrings.keepResting,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              AppStrings.concussionRecoveryBetter,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Color(
                                                                                AppConfig.concussionAlertDialogColor,
                                                                              )
                                                                              //Colors.black,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              AppStrings.beforeStartingGrad,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        primary:
                                                                            const Color(AppConfig.concussionPageTextBGColor)),
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child: const Text(
                                                                    AppStrings
                                                                        .ok),
                                                              ),
                                                            ])));
                                              });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            AppStrings.yes,
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
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    content: SizedBox(
                                                        height: 200,
                                                        width: 150,
                                                        child: Column(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0)),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(10),
                                                                  color: const Color(
                                                                      AppConfig
                                                                          .concussionAlertDialogColor),
                                                                  width: double
                                                                      .infinity,
                                                                  child: const Text(
                                                                      AppStrings
                                                                          .letsRecover,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        40,
                                                                        20,
                                                                        40,
                                                                        20),
                                                                child: RichText(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text: const TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              AppStrings.youCanStart,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              AppStrings.graduatedReturn,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Color(
                                                                                AppConfig.concussionAlertDialogColor,
                                                                              )
                                                                              //Colors.black,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              AppStrings.after23Days,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                behavior:
                                                                    HitTestBehavior
                                                                        .opaque,
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushNamed(
                                                                          ConcussionRecoveryPage
                                                                              .routeName);
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          20,
                                                                          0),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .navigate_next,
                                                                    color:
                                                                        Color(
                                                                      AppConfig
                                                                          .concussionAlertDialogColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ])));
                                              });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            AppStrings.no,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          height: 20,
                                          width: 60,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(AppConfig.healthCheckPageButtonColor),
                ),
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                //color: const Color(AppConfig.healthCheckPageColor),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                alignment: Alignment.center,
                child: const Text(
                  AppStrings.concussionRecovery,
                  //textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  Navigator.of(context).pushNamed(LogInjuryPage.routeName),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(AppConfig.healthCheckPageButtonColor),
                ),
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                //color: const Color(AppConfig.healthCheckPageColor),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                alignment: Alignment.center,
                child: const Text(
                  AppStrings.logInjury,
                  //textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
