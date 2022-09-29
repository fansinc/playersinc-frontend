import 'dart:convert';

import '/models/challenges_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class ChallengesProvider with ChangeNotifier {
  late String _tokenVal;

  List<Challenges> regularChallengesList = [];
  List<Challenges> platinumChallengesList = [];
  late Map<String, dynamic> challengeMap;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<Map<String, dynamic>> fetchSetChallenges() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.getChallengesByLevelUrl}';

      final challengesMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (challengesMapResponse.statusCode < 400) {
        final challengeData =
            json.decode(challengesMapResponse.body) as Map<String, dynamic>;
        challengeData.forEach((key, value) {
          if (key == 'data') {
            regularChallengesList = [];
            platinumChallengesList = [];
            //Map<String, dynamic> newsMap;
            var regularList = value[0]['Regular'];
            var platinumList = value[0]['Platinum'];

            // Regular Challenges
            for (int i = 0; i < regularList.length; i++) {
              var regularchallengeDataInputList = regularList[i]['challenges'];
              List<ChallengesData> challengeDataList = [];
              for (int j = 0; j < regularchallengeDataInputList.length; j++) {
                challengeDataList.add(ChallengesData(
                  id: regularchallengeDataInputList[j]['id'],
                  name: regularchallengeDataInputList[j]['name'],
                  description: regularchallengeDataInputList[j]['description'],
                  physicalSkills: regularchallengeDataInputList[j]
                          ['physical_skills']
                      .toString(),
                  brainSkills: regularchallengeDataInputList[j]['brain_skills']
                      .toString(),
                  rugbySkills: regularchallengeDataInputList[j]['rugby_skills']
                      .toString(),
                  challengeLevelId: regularchallengeDataInputList[j]
                      ['challenge_level_id'],
                  //challengeLevelName: regularchallengeDataInputList[j] ['challenge_level_name'],
                  stageId: regularchallengeDataInputList[j]['stage_id'],
                  /* stageName: regularchallengeDataInputList[j]['stage_name'],
                  stagePosition: regularchallengeDataInputList[j]
                      ['stage_position'], */
                  ageGroupId: regularchallengeDataInputList[j]['age_group_id'],
                  /*  ageGroupName: regularchallengeDataInputList[j]
                      ['age_group_name'], */
                  price: regularchallengeDataInputList[j]['price'].toString(),
                  statusId: regularchallengeDataInputList[j]['status_id'],
                  //statusName: regularchallengeDataInputList[j]['status_name'],
                  createdBy: regularchallengeDataInputList[j]['created_by'],
                  updatedBy: regularchallengeDataInputList[j]['updated_by'],
                  createdAt: regularchallengeDataInputList[j]['created_at'],
                  updatedAt: regularchallengeDataInputList[j]['updated_at'],
                  isCompleted: regularchallengeDataInputList[j]['is_completed'],
                  //isEligible:  regularchallengeDataInputList[j]['isEligible'],
                ));
              }
              regularChallengesList.add(
                Challenges(
                  id: regularList[i]['id'],
                  name: regularList[i]['name'],
                  type: regularList[i]['type'],
                  position: regularList[i]['position'],
                  challenges: challengeDataList,
                ),
              );
            }

            //Platinum Challenges
            for (int i = 0; i < platinumList.length; i++) {
              var platinumChallengeDataInputList =
                  platinumList[i]['challenges'];
              List<ChallengesData> platinumChallengeDataList = [];
              for (int j = 0; j < platinumChallengeDataInputList.length; j++) {
                platinumChallengeDataList.add(ChallengesData(
                  id: platinumChallengeDataInputList[j]['id'],
                  name: platinumChallengeDataInputList[j]['name'],
                  description: platinumChallengeDataInputList[j]['description'],
                  physicalSkills: platinumChallengeDataInputList[j]
                          ['physical_skills']
                      .toString(),
                  brainSkills: platinumChallengeDataInputList[j]['brain_skills']
                      .toString(),
                  rugbySkills: platinumChallengeDataInputList[j]['rugby_skills']
                      .toString(),
                  challengeLevelId: platinumChallengeDataInputList[j]
                      ['challenge_level_id'],
                  //challengeLevelName: regularchallengeDataInputList[j] ['challenge_level_name'],
                  stageId: platinumChallengeDataInputList[j]['stage_id'],
                  /* stageName: regularchallengeDataInputList[j]['stage_name'],
                  stagePosition: regularchallengeDataInputList[j]
                      ['stage_position'], */
                  ageGroupId: platinumChallengeDataInputList[j]['age_group_id'],
                  /*  ageGroupName: regularchallengeDataInputList[j]
                      ['age_group_name'], */
                  price: platinumChallengeDataInputList[j]['price'].toString(),
                  statusId: platinumChallengeDataInputList[j]['status_id'],
                  //statusName: regularchallengeDataInputList[j]['status_name'],
                  createdBy: platinumChallengeDataInputList[j]['created_by'],
                  updatedBy: platinumChallengeDataInputList[j]['updated_by'],
                  createdAt: platinumChallengeDataInputList[j]['created_at'],
                  updatedAt: platinumChallengeDataInputList[j]['updated_at'],
                  isCompleted: platinumChallengeDataInputList[j]
                      ['is_completed'],
                  //isEligible:  regularchallengeDataInputList[j]['isEligible'],
                ));
              }
              platinumChallengesList.add(
                Challenges(
                  id: platinumList[i]['id'],
                  name: platinumList[i]['name'],
                  type: platinumList[i]['type'],
                  position: platinumList[i]['position'],
                  challenges: platinumChallengeDataList,
                ),
              );
            }

            challengeMap = {
              "regularChallengesList": regularChallengesList,
              "platinumChallengesList": platinumChallengesList,
            };
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return challengeMap;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(challengesMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Map<String, dynamic> fetchChallenges() {
    return challengeMap;
  }

  Future<void> submitPlayerChallenge(
    String playerId,
    String challengeId,
    String challengeStatusId,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.playerChallenge}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "challenge_id": challengeId,
        "challenge_status_id": challengeStatusId,
      });

      final challengeMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (challengeMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(challengeMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
