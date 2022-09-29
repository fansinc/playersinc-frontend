import 'dart:convert';

import '/models/clubs_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class ClubsProvider with ChangeNotifier {
  late String _tokenVal;

  List<ClubsModel> clubsModelList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<ClubsModel>> fetchSetClubs() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.clubUrl}';

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
            clubsModelList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              clubsModelList.add(
                ClubsModel(
                  clubId: value[i]['id'],
                  clubName: value[i]['name'],
                  ownerId: value[i]['owner_id'],
                  ownerName: value[i]['owner_name'],
                  clubImage: value[i]['Assets']['data'][0]['links']['full'],
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return clubsModelList;
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

  List<ClubsModel> fetchClubs() {
    return [...clubsModelList];
  }
}
