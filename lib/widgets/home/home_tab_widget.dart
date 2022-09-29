import 'package:flutter/material.dart';
import '/models/profile_model.dart';

import '/providers/profile_provider.dart';
import '/widgets/home/home_stats_widget.dart';
import 'package:provider/provider.dart';

import '/widgets/home/home_info_widget.dart';
import '/config/app_strings.dart';
import '/config/app_config.dart';
import 'home_my_season_widget.dart';

class HomeTabWidget extends StatefulWidget {
  const HomeTabWidget({Key? key}) : super(key: key);

  @override
  _HomeTabWidgetState createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> {
  var isInit = true;
  var isLoading = false;
  bool _info = true;
  bool _stats = false;
  bool _history = false;

  String superStrength = 'Not Submitted';
  String supportTeam = 'Not Submitted';
  String schoolName = 'Not Submitted';

  /* @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ProfileProvider>(context).fetchSetUserProfile().then((value) {
        superStrength = value.superStrength;
        supportTeam = value.supportTeam;
        schoolName = value.schoolName;
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
  } */

  void _switchInfo() {
    setState(() {
      _info = true;
      _stats = false;
      _history = false;
    });
  }

  void _switchStats() {
    setState(() {
      _info = false;
      _stats = true;
      _history = false;
    });
  }

  void _switchHistory() {
    setState(() {
      _info = false;
      _stats = false;
      _history = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    ProfileModel profileData =
        Provider.of<ProfileProvider>(context, listen: false).fetchUserProfile();

    superStrength = profileData.superStrength;
    supportTeam = profileData.supportTeam;
    schoolName = profileData.schoolName;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(
                AppConfig.blueColor,
              ),
            ),
          )
        : Container(
            color: _info
                ? const Color(AppConfig.blueColor)
                : _stats
                    ? const Color(
                        AppConfig.buttonBlueColor,
                      )
                    : const Color(AppConfig.tabMySeasonColor),
            height: deviceHeight * .55,
            //width: deviceWidth,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: _switchInfo,
                        style: OutlinedButton.styleFrom(
                          // primary: const Color(AppConfig.blueColor),
                          side: const BorderSide(
                            color:
                                /*  _info
                                ? Colors.white
                                // const Color(AppConfig.blueColor): */
                                Colors.transparent,
                          ),
                        ),
                        child: Text(
                          AppStrings.info,
                          style: TextStyle(
                              color: _info
                                  ? Colors.white
                                  //const Color(AppConfig.blueColor)
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: _switchStats,
                        style: OutlinedButton.styleFrom(
                          side:
                              /* _stats
                              ? const BorderSide(color: Colors.white)
                              : */
                              //Color(AppConfig.lightGrey)):
                              const BorderSide(color: Colors.transparent),
                        ),
                        child: Text(
                          AppStrings.stats,
                          style: TextStyle(
                              color: _stats
                                  ? Colors.white
                                  //const Color(AppConfig.blueColor)
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: _switchHistory,
                        style: OutlinedButton.styleFrom(
                          side:
                              /*  _history
                              ? const BorderSide(color: Colors.white) : */
                              const BorderSide(color: Colors.transparent),
                        ),
                        child: Text(
                          AppStrings.mySeason,
                          style: TextStyle(
                              color: _history
                                  ? Colors.white
                                  //const Color(AppConfig.blueColor)
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_info)
                  HomeInfoWidget(schoolName, supportTeam, superStrength),
                if (_stats) const HomeStatsWidget(),
                if (_history)
                  HomeMySeasonWidget(schoolName, supportTeam, superStrength),

                // EAEcoRewardsBookingWidget(_approved, _processing, _expired),
              ],
            ),
          );
  }
}
