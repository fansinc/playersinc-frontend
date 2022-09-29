import 'dart:convert';

import '/models/log_time_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class LogTimeProvider with ChangeNotifier {
  late String _tokenVal;

  List<LogTimeModel> logTimeList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<LogTimeModel>> fetchSetLogTime() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.logTimeUrl}';

      final clubMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (clubMapResponse.statusCode < 400) {
        final clubData =
            json.decode(clubMapResponse.body) as Map<String, dynamic>;
        clubData.forEach((key, value) {
          if (key == 'data') {
            logTimeList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              logTimeList.add(
                LogTimeModel(
                  id: value[i]['id'],
                  playerId: value[i]['player_id'],
                  playerName: value[i]['player_name'],
                  playingDate: value[i]['playing_date'],
                  trainingTime: value[i]['training_time'],
                  gameTime: value[i]['game_time'],
                  levelId: value[i]['level_id'],
                  levelName: value[i]['level_name'],
                  totalTime: value[i]['total_time'],
                  statusId: value[i]['status_id'],
                  statusName: value[i]['status_name'],
                  createdAt: value[i]['created_at'],
                  updatedAt: value[i]['updated_at'],
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return logTimeList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(clubMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  List<LogTimeModel> fetchLogTime() {
    return [...logTimeList];
  }

  Future<void> createLogTime(
    String playerId,
    String playingDate,
    String trainingTime,
    String gameTime,
    int levelId,
    String totalTime,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.logTimeUrl}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "playing_date": playingDate,
        "training_time": trainingTime,
        "game_time": gameTime,
        "level_id": levelId,
        "total_time": totalTime
      });

      final logTimeMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (logTimeMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(logTimeMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
