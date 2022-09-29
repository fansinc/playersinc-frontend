import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import '/models/my_top_play_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class MyTopPlayProvider with ChangeNotifier {
  late String _tokenVal;

  List<MyTopPlayModel> topPlayList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<MyTopPlayModel>> fetchSetTopPlay() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.topPlayUrl}';

      final topPlayMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (topPlayMapResponse.statusCode < 400) {
        final topPlayData =
            json.decode(topPlayMapResponse.body) as Map<String, dynamic>;
        topPlayData.forEach((key, value) {
          if (key == 'data') {
            topPlayList = [];
            //Map<String, dynamic> newsMap;

            for (int i = 0; i < value.length; i++) {
              final videoLinksListData = value[i]['Assets']['data'];
              List<String> videoLinksList = [];
              for (int j = 0; j < videoLinksListData.length; j++) {
                videoLinksList.add(videoLinksListData[j]['linksvideo']['full']);
              }
              topPlayList.add(
                MyTopPlayModel(
                  id: value[i]['id'],
                  playerId: value[i]['player_id'],
                  playerName: value[i]['player_name'],
                  title: value[i]['title'],
                  description: value[i]['description'],
                  statusId: value[i]['status_id'],
                  statusName: value[i]['status_name'],
                  createdBy: value[i]['created_by'],
                  updatedBy: value[i]['updated_by'],
                  createdAt: value[i]['created_at'],
                  updatedAt: value[i]['updated_at'],
                  videoLinks: videoLinksList,
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return topPlayList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(topPlayMapResponse.body)['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  List<MyTopPlayModel> fetchTopPlay() {
    return [...topPlayList];
  }

  Future<void> createTopPlay(
    int playerId,
    String title,
    String description,
    var fileObj,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;

      final headers = {
        //'Accept': 'application/vnd.api.v1+json',
        'Content-Type': 'application/json',
        //'image/jpeg',
        'Authorization': 'Bearer $_tokenVal'
      };

      const assetUrl = '${AppConfig.baseUrl}${AppConfig.topPlayUrl}';

      //---Create http package multipart request object
      final request = MultipartRequest(
        "POST",
        Uri.parse(assetUrl),
      );
      //-----add header
      request.headers.addAll(headers);

      //-----add selected file with request
      final file = fileObj.files.single;
      request.files.add(
        MultipartFile(
          'file[]', //parameter name on server side
          file.readStream,
          file.size,
          filename: file.name,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      request.fields['player_id'] = playerId.toString();
      request.fields['title'] = title;
      request.fields['description'] = description;

      //-------Send request
      var resp = await request.send();

      if (resp.statusCode < 400) {
        //------Read response
        /*   final profileImageResponse = await resp.stream.bytesToString(); */

        /*    final profileImageResponse = json
            .decode(await resp.stream.bytesToString()) as Map<String, dynamic>;
        //await resp.stream.bytesToString();

        final uuid = profileImageResponse['data']['id'];

        const url = '${AppConfig.baseUrl}${AppConfig.logTimeUrl}'; */

        /*  final inputBodyVal = json.encode({
          "player_id": playerId,
          "playing_date": playingDate,
          "training_time": trainingTime,
          "game_time": gameTime,
          "level_id": levelId,
          "total_time": totalTime
        }); */

        /*  final logTimeMapResponse = await post(Uri.parse(url),
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
        }*/
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
