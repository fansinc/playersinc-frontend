import 'package:flutter/material.dart';
import 'package:playersinc/config/app_config.dart';
import '/config/app_strings.dart';

class HomeStatsSkillsWidget extends StatefulWidget {
  const HomeStatsSkillsWidget({Key? key}) : super(key: key);

  @override
  State<HomeStatsSkillsWidget> createState() => _HomeStatsSkillsWidgetState();
}

class _HomeStatsSkillsWidgetState extends State<HomeStatsSkillsWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.fromLTRB(40, 10, 20, 10),
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
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.sitUps,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.pressUps,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.burpees,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
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
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.workEthic,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.teamLeadership,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.creativity,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.problemSolving,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
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
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.passesCompleted,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.offloads,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.lineBreak,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                AppStrings.kick,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
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
                onPressed: () {},
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
