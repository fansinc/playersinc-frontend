import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/providers/concussion_recovery_info_provider.dart';
import 'package:provider/provider.dart';
import '/config/app_strings.dart';
import '/config/app_config.dart';

class ConcussionRecoveryPageWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final concussionDate;
  const ConcussionRecoveryPageWidget({this.concussionDate, Key? key})
      : super(key: key);

  @override
  State<ConcussionRecoveryPageWidget> createState() =>
      _ConcussionRecoveryPageWidgetState();
}

class _ConcussionRecoveryPageWidgetState
    extends State<ConcussionRecoveryPageWidget> {
  @override
  Widget build(BuildContext context) {
    final concRecProv =
        Provider.of<ConcussionRecoveryInfoProvider>(context, listen: false)
            .fetchConcussionRecoveryInfoList;
    final date = widget.concussionDate;
    DateTime dobFormated = DateFormat('dd/MM/yyyy').parse(date);
    int diffDays = DateTime.now().difference(dobFormated).inDays;
    final concData = concRecProv[diffDays - 1];

    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Day ${concData.day}',
            //'Listen to advice from Alex Waller',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 120,
            backgroundColor: const Color(AppConfig.concussionPageCircleColor),
            child: CircleAvatar(
              child: ClipRRect(
                child: Container(
                  // width: 210,
                  //height: 210,
                  decoration: const BoxDecoration(
                    color: Color(AppConfig.concussionRecoveryPageCircleBGColor),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AppConfig.samImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                /*  Image.asset(
                  AppConfig.aw1Image,
                  height: 150,
                  width: 150,
                ), */
                borderRadius: BorderRadius.circular(300),
              ),
              radius: 110,
              backgroundColor:
                  const Color(AppConfig.concussionPageCircleColor2),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${AppStrings.listenToAdvice} ${concData.adviserName}',
            //'Listen to advice from Alex Waller',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const CircleAvatar(
            radius: 15,
            backgroundColor: Color(AppConfig.concussionPageCircleColor),
            child: Icon(
              Icons.volume_up_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: concData.advice.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(AppConfig.concussionPageTextBGColor),
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    concRecProv[diffDays - 1].advice[index],
                    //'No Exercise',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
          GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    contentPadding: const EdgeInsets.all(0),
                    /*  backgroundColor:
                          const Color(AppConfig.concussionAlertDialogColor), */
                    content: SizedBox(
                      height: 320,
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
                              child: const Text(AppStrings.feelingSymptoms,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: AppStrings.incaseFeelingUnwell,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.youWillBeRedirected,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                        AppConfig.concussionAlertDialogColor,
                                      )
                                      //Colors.black,
                                      ),
                                ),
                                TextSpan(
                                  text: AppStrings.notificationEmail,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.silverstone,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                        AppConfig.concussionAlertDialogColor,
                                      )
                                      //Colors.black,
                                      ),
                                ),
                                TextSpan(
                                  text: AppStrings.concussionAnd,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.paulbainesMail,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                        AppConfig.concussionAlertDialogColor,
                                      )
                                      //Colors.black,
                                      ),
                                ),
                                TextSpan(
                                  text: AppStrings.concussionAnd,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.clubMail,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(
                                        AppConfig.concussionAlertDialogColor,
                                      )
                                      //Colors.black,
                                      ),
                                ),
                              ]),
                            ),
                          ),
                          /* Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: const Text(
                              AppStrings.incaseFeelingUnwell,
                            ),
                          ), */
                          Container(
                            color: Colors.white,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(
                                      AppConfig.concussionAlertDialogColor),
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
                                    AppStrings.ok,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  height: 20,
                                  width: 60,
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              //  alignment: Alignment.center,
              width: 180,
              height: 70,
              child: const Text(
                AppStrings.imFeelingSymptoms,
                //'I\'m feeling symptoms',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(AppConfig.concussionPageCircleColor),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            alignment: Alignment.topRight,
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  AppStrings.concCheckBack,
                  //'Check back in',
                  style: TextStyle(
                    color: Color(AppConfig.concussionPageCheckBackColor),
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${concData.checkBackDay.toString()} ${AppStrings.days}',
                  // '2 Days',
                  style: const TextStyle(
                    color: Color(AppConfig.concussionPageCheckBackColor),
                    fontSize: 26,
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
