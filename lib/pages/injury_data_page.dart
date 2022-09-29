//import '/pages/email_auth_page.dart';
import 'package:flutter/material.dart';
import '/models/injury_model.dart';

import '/config/app_config.dart';
import '/config/app_strings.dart';

class InjuryDataPage extends StatefulWidget {
  static const routeName = '/injuryDataPage';

  const InjuryDataPage({Key? key}) : super(key: key);
  @override
  State<InjuryDataPage> createState() => _InjuryDataPageState();
}

class _InjuryDataPageState extends State<InjuryDataPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<InjuryModel> injuryData = args['injuryData'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            AppStrings.injuryDataPageTitle,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            //color: Color(AppColors.blueColor),
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: const Color(AppConfig.tabMySeasonInjuryDataColor),
        body: injuryData.isNotEmpty
            ? SingleChildScrollView(
                child: ListView.builder(
                    itemCount: injuryData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        //padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
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
                                              text: AppStrings.injuryDetails,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: injuryData[index].injury,
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
                                            20, 10, 20, 10),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: AppStrings.injuryDate,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  injuryData[index].injuredDate,
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
                                      const EdgeInsets.fromLTRB(0, 5, 15, 5),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: const Color(
                                        AppConfig.tabMySeasonInjuryDataColor),
                                    child: Image.asset(
                                      AppConfig.plasterIconImage,
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
