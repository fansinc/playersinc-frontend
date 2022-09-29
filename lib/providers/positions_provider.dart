import 'dart:convert';

import '/models/player_position_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class PositionsProvider with ChangeNotifier {
  late String _tokenVal;

  List<PlayerPositionModel> playerPositionsModelList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<PlayerPositionModel>> fetchSetPlayerPositions() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.playerPositionUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

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
            playerPositionsModelList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              playerPositionsModelList.add(
                PlayerPositionModel(
                  positionId: value[i]['id'],
                  positionName: value[i]['name'],
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return playerPositionsModelList;
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

  List<PlayerPositionModel> fetchPlayerPositions() {
    return [...playerPositionsModelList];
  }
}
