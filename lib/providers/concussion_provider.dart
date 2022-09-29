import 'dart:convert';

import '/models/concussion_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class ConcussionProvider with ChangeNotifier {
  late String _tokenVal;

  List<ConcussionModel> concussionList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<ConcussionModel>> fetchSetConcussion() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.concussionUrl}';

      final concussionMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (concussionMapResponse.statusCode < 400) {
        final concussionData =
            json.decode(concussionMapResponse.body) as Map<String, dynamic>;
        concussionData.forEach((key, value) {
          if (key == 'data') {
            concussionList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              concussionList.add(
                ConcussionModel(
                  id: value[i]['id'],
                  playerId: value[i]['player_id'],
                  playerName: value[i]['player_name'],
                  concussionDate: value[i]['concussion_date'],
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
        return concussionList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(concussionMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  List<ConcussionModel> fetchConcussion() {
    return [...concussionList];
  }

  Future<void> createConcussion(
    String playerId,
    String concussionDate,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.concussionUrl}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "concussion_date": concussionDate,
      });

      final concussionMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (concussionMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(concussionMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
