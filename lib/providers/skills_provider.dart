import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/config/app_config.dart';

class SkillsProvider with ChangeNotifier {
  late String _tokenVal;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<void> createSkills(
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
    // List<int> symptoms,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.skillUrl}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "sit_ups": sitUps,
        "press_ups": pressUps,
        "burpees": burpees,
        "work_ethic": workEthic,
        "team_leadership": teamLeadership,
        "creativity": creativity,
        "problem_solving": problemSolving,
        "passes_completed": passesCompleted,
        "offloads": offloads,
        "line_break": lineBreak,
        "kick": kick,
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
