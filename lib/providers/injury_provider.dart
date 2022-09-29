import 'dart:convert';

import '/models/injury_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/config/app_config.dart';

class InjuryProvider with ChangeNotifier {
  late String _tokenVal;

  late List<InjuryModel> injuryModel;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<InjuryModel>> fetchSetPlayerInjury() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.injuryUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final injuryMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (injuryMapResponse.statusCode < 400) {
        final profileData =
            json.decode(injuryMapResponse.body) as Map<String, dynamic>;
        profileData.forEach((key, value) {
          if (key == 'data') {
            injuryModel = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              injuryModel.add(InjuryModel(
                id: value[i]["id"],
                playerId: value[i]["player_id"],
                playerName: value[i]["player_name"],
                injuredDate: value[i]["injured_date"],
                injury: value[i]["injury"],
                howLongDate: value[i]["howlong"],
                statusId: value[i]["status_id"],
                statusName: value[i]["status_name"],
                createdAt: value[i]["created_at"],
                updatedAt: value[i]["updated_at"],
                createdBy: value[i]["created_by"],
                updatedBy: value[i]["updated_by"],
              ));
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return injuryModel;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(injuryMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  List<InjuryModel> fetchPlayerInjury() {
    return [...injuryModel];
  }

  Future<void> createPlayerInjury(
    String playerId,
    String injuredDate,
    String injury,
    String howLongDate,
    // List<int> symptoms,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.injuryUrl}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "injured_date": injuredDate,
        "injury": injury,
        "howlong": howLongDate,
        //"injured_place": injuredPlace,
        //"symptoms": symptoms,
        //[1, 2],
        // "diagnosis": injuredPlace, //not required
      });

      final injuryMapResponse = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (injuryMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(injuryMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  /* Future<void> updateUserProfile(
      String name, String email, String mobile) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.profileUpdateUrl}';

      final inputBodyVal = json.encode({
        "name": name,
        "email": email,
        "mobile": mobile,
      });

      final profileMapResponse = await put(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_tokenVal'
          },
          body: inputBodyVal);

      if (profileMapResponse.statusCode < 400) {
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(profileMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }*/
}
