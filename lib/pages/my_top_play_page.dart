//import '/pages/email_auth_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '/widgets/video_player_widget.dart';
import '/models/my_top_play_model.dart';
import '/providers/my_top_play_provider.dart';
import 'package:provider/provider.dart';

import '/config/app_config.dart';
import '/config/app_strings.dart';
import 'email_auth_page.dart';

class MyTopPlayPage extends StatefulWidget {
  static const routeName = '/myTopPlayPage';

  const MyTopPlayPage({Key? key}) : super(key: key);
  @override
  State<MyTopPlayPage> createState() => _MyTopPlayPageState();
}

class _MyTopPlayPageState extends State<MyTopPlayPage> {
  bool isInit = true;
  bool isLoading = false;
  late List<MyTopPlayModel> myTopPlayList;
  late String title;
  late String description;
  late int playerId;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      myTopPlayList = [];
      Provider.of<MyTopPlayProvider>(context, listen: false)
          .fetchSetTopPlay()
          .then((value) {
        myTopPlayList = value;
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
  }

  void filePickSubmit(var picked) {
    //print(picked.files.first.name);
    setState(() {
      isLoading = true;
    });
    Provider.of<MyTopPlayProvider>(context, listen: false)
        .createTopPlay(
      2, //playerId,
      'test title', //title,
      'test description', //description,
      picked,
    )
        .then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            AppStrings.myTopPageTitle,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            //color: Color(AppColors.blueColor),
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: const Color(AppConfig.skillsPageBGColor),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                //height: 150,
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                //padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                /*  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(AppConfig.mySkillsAddEditBGColor),
                        ), */
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color(AppConfig.mySkillsAddEditBGColor),
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var picked = await FilePicker.platform.pickFiles(
                                withReadStream: true,
                                type: FileType.video,
                              );
                              if (picked != null) {
                                //print(picked.files.first.name);
                                filePickSubmit(picked);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppConfig.addMediaImage,
                                  height: 60,
                                ),
                                const Text(
                                  AppStrings.uploadSkills,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppConfig.pencilImage,
                                height: 60,
                              ),
                              const Text(
                                AppStrings.editTopPlays,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    myTopPlayList.isNotEmpty
                        ? SingleChildScrollView(
                            child: ListView.builder(
                                itemCount: myTopPlayList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 5, 20, 10),
                                      //padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          /* VideoPlayerWidget(
                                            myTopPlayList[index].videoLinks[0]), */
                                          /* Expanded(
                                          child:  */
                                          Card(
                                              elevation: 8,
                                              color: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const VideoPlayerWidget(
                                                  '', 150.0, 200.0
                                                  /* myTopPlayList[index]
                                                    .videoLinks[0], */
                                                  )),
                                          //),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Text(
                                                myTopPlayList[index].title,
                                                //textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                                }),
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                            //alignment: Alignment.center,
                            child: Column(
                              children: [
                                const Text(
                                  AppStrings.noData,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Image.asset(
                                  AppConfig.noDataImage,
                                  height: 200,
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
