import 'dart:convert';

import '/models/missions_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class MissionsProvider with ChangeNotifier {
  late String _tokenVal;

  late List<Missions> missionsList;

  late Map<String, dynamic> challengeMap;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<Missions>> fetchSetMissions() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.getMissionsByLevel}';

      final missionsMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (missionsMapResponse.statusCode < 400) {
        final missionData =
            json.decode(missionsMapResponse.body) as Map<String, dynamic>;
        missionsList = [];
        missionData.forEach((key, value) {
          if (key == 'data') {
            var missionsRespListData = value[0]['Paid'];

            for (int i = 0; i < missionsRespListData.length; i++) {
              var missionsDataInputList = missionsRespListData[i]['missions'];
              List<MissionsData> missionsDataList = [];
              for (int j = 0; j < missionsDataInputList.length; j++) {
                missionsDataList.add(MissionsData(
                  id: missionsDataInputList[j]['id'],
                  name: missionsDataInputList[j]['name'],
                  description: missionsDataInputList[j]['description'],

                  missionLevelId: missionsDataInputList[j]['mission_level_id'],

                  ageGroupId: missionsDataInputList[j]['age_group_id'],

                  price: missionsDataInputList[j]['price'].toString(),
                  statusId: missionsDataInputList[j]['status_id'],

                  createdBy: missionsDataInputList[j]['created_by'],
                  updatedBy: missionsDataInputList[j]['updated_by'],
                  createdAt: missionsDataInputList[j]['created_at'],
                  updatedAt: missionsDataInputList[j]['updated_at'],
                  isCompleted: missionsDataInputList[j]['is_completed'],
                  //isEligible:  missionsDataInputList[j]['isEligible'],
                ));
              }
              missionsList.add(
                Missions(
                  id: missionsRespListData[i]['id'],
                  name: missionsRespListData[i]['name'],
                  missions: missionsDataList,
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return missionsList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(missionsMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  List<Missions> fetchMissions() {
    return [...missionsList];
  }

  Future<void> submitPlayerMission(
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
