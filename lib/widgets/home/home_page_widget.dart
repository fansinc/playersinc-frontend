import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '/models/profile_model.dart';
import '/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '/widgets/home/home_tab_widget.dart';

import '/config/app_config.dart';

import 'package:flutter/material.dart';

import '../logo_profile_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    ProfileModel profileData =
        Provider.of<ProfileProvider>(context, listen: false).fetchUserProfile();
    // final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;
    final dob = profileData.dob;
    DateTime dobFormated = DateFormat('dd/MM/yyyy').parse(dob);
    int ageDays = DateTime.now().difference(dobFormated).inDays;
    int years = ageDays ~/ 365;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /* const LogoProfileWidget(
              Colors.white,
              Color(
                AppConfig.blueColor,
              )), */
          /*Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            alignment: Alignment.topLeft,
            child: const Text(
              'Latest News',
              //textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ), */
          Stack(
            children: [
              profileData.profileImage!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: profileData.profileImage!,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        AppConfig.defaultImage,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppConfig.defaultImage,

                        // width: 50,
                      ),
                      // fit: BoxFit.fitHeight,
                    )
                  : Image.asset(
                      AppConfig.defaultImage,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      //AppConfig.rugbyPlayerImage,
                      //height: 250,
                      //fit: BoxFit.fill,
                      //height: 50,
                    ),
              const LogoProfileWidget(
                Colors.transparent,
                Colors.white,
                /* Color(
                  AppConfig.blueColor,
                ), */
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              /*  BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)), */
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileData.fullName,
                          //'Samuel Baines',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Age: $years',
                              //'Age:14',
                              style: const TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Position: ${profileData.playingPositionName}',
                              // 'Position: Flanker',
                              style: const TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    CachedNetworkImage(
                      height: 75,
                      imageUrl: profileData.clubImage,
                    )
                    /* Image.asset(
                      AppConfig.bedfordImage,
                      height: 75,
                    ), */
                  ],
                )
              ],
            ),
          ),
          const HomeTabWidget(),
          //fit: FlexFit.loose,

          /*  const TabBarView(children: [
            HomeInfoWidget(),
            HomeStatsWidget(),
            HomeHistoryWidget()
          ]), */
        ],
      ),
    );
  }
}
