import 'dart:convert';

import '/models/symptoms_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class SymptomsProvider with ChangeNotifier {
  late String _tokenVal;

  List<SymptomsModel> symptomModelList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<SymptomsModel>> fetchSetSymptoms() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.confSymptomUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final confSymptomMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (confSymptomMapResponse.statusCode < 400) {
        final confSymptomData =
            json.decode(confSymptomMapResponse.body) as Map<String, dynamic>;
        confSymptomData.forEach((key, value) {
          if (key == 'data') {
            symptomModelList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              symptomModelList.add(
                SymptomsModel(
                  symptomId: value[i]['id'],
                  symptomName: value[i]['name'],
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return symptomModelList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(confSymptomMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  List<SymptomsModel> fetchSymptoms() {
    return [...symptomModelList];
  }
}
