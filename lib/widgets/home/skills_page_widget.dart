import 'package:flutter/material.dart';
import 'package:playersinc/providers/profile_provider.dart';
import 'package:playersinc/providers/skills_provider.dart';
import 'package:provider/provider.dart';
import '/config/app_config.dart';
import '/config/app_strings.dart';

class SkillsPageWidget extends StatefulWidget {
  const SkillsPageWidget({Key? key}) : super(key: key);

  @override
  State<SkillsPageWidget> createState() => _SkillsPageWidgetState();
}

class _SkillsPageWidgetState extends State<SkillsPageWidget> {
  bool isInit = true;
  bool isLoading = false;

  int sitUps = 0;
  int pressUps = 0;
  int burpees = 0;
  int workEthic = 0;
  int teamLeadership = 0;
  int creativity = 0;
  int problemSolving = 0;
  int passesCompleted = 0;
  int offloads = 0;
  int lineBreak = 0;
  int kick = 0;

  void validateCreate() async {
    // if (_formKey.currentState.validate()) {
    /*   var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) { */
    try {
      // _formKey.currentState!.save();

      final playerId = Provider.of<ProfileProvider>(context, listen: false)
          .profileModel
          .userId;
      await Provider.of<SkillsProvider>(context, listen: false).createSkills(
        playerId,
        sitUps,
        pressUps,
        burpees,
        workEthic,
        teamLeadership,
        creativity,
        problemSolving,
        passesCompleted,
        offloads,
        lineBreak,
        kick,
      );
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.skillsAddSuccess),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // dismiss the alert dialog
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
            String errorMsg;
            if (error
                .toString()
                .contains("Field 'playDate' has not been initialized.")) {
              errorMsg = 'Please select the playing date';
            } else {
              errorMsg = error.toString();
            }
            return AlertDialog(
              title: const Text(AppStrings.error),
              content: Text(errorMsg),
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
    //final deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.fromLTRB(40, 30, 40, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(AppConfig.skillsPageSkillTitleBGColor),
            width: double.infinity,
            child: const Text(
              AppStrings.physicalSkills,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.sitUps,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (sitUps > 0) {
                          sitUps = sitUps - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      sitUps.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sitUps = sitUps + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.pressUps,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (pressUps > 0) {
                          pressUps = pressUps - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      pressUps.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pressUps = pressUps + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.burpees,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (burpees > 0) {
                          burpees = burpees - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      burpees.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        burpees = burpees + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: const Color(AppConfig.skillsPageSkillTitleBGColor),
            width: double.infinity,
            child: const Text(
              AppStrings.brainSkills,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.workEthic,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (workEthic > 0) {
                          workEthic = workEthic - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      workEthic.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        workEthic = workEthic + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.teamLeadership,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (teamLeadership > 0) {
                          teamLeadership = teamLeadership - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      teamLeadership.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        teamLeadership = teamLeadership + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.creativity,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (creativity > 0) {
                          creativity = creativity - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      creativity.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        creativity = creativity + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.problemSolving,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (problemSolving > 0) {
                          problemSolving = problemSolving - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      problemSolving.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        problemSolving = problemSolving + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: const Color(AppConfig.skillsPageSkillTitleBGColor),
            width: double.infinity,
            child: const Text(
              AppStrings.rugbySkills,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.passesCompleted,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (passesCompleted > 0) {
                          passesCompleted = passesCompleted - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      passesCompleted.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        passesCompleted = passesCompleted + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.offloads,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (offloads > 0) {
                          offloads = offloads - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      offloads.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        offloads = offloads + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.lineBreak,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (lineBreak > 0) {
                          lineBreak = lineBreak - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      lineBreak.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        lineBreak = lineBreak + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.kick,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (kick > 0) {
                          kick = kick - 1;
                        }
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      kick.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        kick = kick + 1;
                      });
                    },
                    child: Container(
                        color: const Color(AppConfig.skillsPageButtonColor),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  primary: const Color(AppConfig.skillsPageSkillTitleBGColor),
                ),
                onPressed: validateCreate,
                //() {},
                child: const Text(
                  AppStrings.submit,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    ));
  }
}
