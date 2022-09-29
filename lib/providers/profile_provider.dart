import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import '/models/profile_model.dart';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/config/app_config.dart';

class ProfileProvider with ChangeNotifier {
  late String _tokenVal;

  late ProfileModel profileModel;

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<ProfileModel> fetchSetUserProfile() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.profileViewUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final profileMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (profileMapResponse.statusCode < 400) {
        final profileData =
            json.decode(profileMapResponse.body) as Map<String, dynamic>;
        profileData.forEach((key, value) {
          if (key == 'data') {
            List imgList = value["Assets"]["data"];
            profileModel = ProfileModel(
              id: value["id"],
              userId: value["user_id"],
              userEmail: value["user_email"],
              fullName: value["full_name"],
              dob: value["dob"],
              clubId: value["club_id"],
              clubName: value["club_name"],
              superStrength: value["super_strength"],
              supportTeam: value["support_team"],
              playingPositionId: value["playing_position_id"],
              playingPositionName: value["playing_position_name"],
              contactName: value["contact_name"],
              contactRelType: value["rel_type"],
              contactMobileNo: value["mobile_no"],
              contactEmail:
                  value["user_email"], // change this once implemented in API
              schoolName: value["school_name"],
              schoolContactName: value["school_contact_name"],
              jobTitle: value["job_title"],
              schoolEmail: value["school_email"],
              schoolPhoneNo: value["school_phone_no"],
              clubSafeGuarderNumber: value["club_safeguarder"],
              clubSafeGuarderEmail: value["club_email"],
              createdAt: value["created_at"],
              updatedAt: value["updated_at"],
              clubImage: value["Clubs"]["data"]["Assets"]["data"][0]["links"]
                  ["full"],
              profileImage:
                  imgList.isNotEmpty ? imgList[0]["links"]["full"] : '',
              //clubs:Clubs.fromJson(value["Clubs"]),
            );
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return profileModel;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(profileMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  ProfileModel fetchUserProfile() {
    return profileModel;
  }

  Future<void> createUserProfile(
    String fullName,
    String dob,
    int clubId,
    int selectedPosition,
    String superStrength,
    String supportTeam,
    String contactName,
    String relationName,
    String mobile,
    String contactEmail,
    String schoolName,
    String schoolContactName,
    String jobTitle,
    String schoolEmail,
    String schoolPhone,
    String clubSafegaurderNumber,
    String clubSafegaurderMail,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.profileCreateUrl}';

      final inputBodyVal = json.encode({
        "full_name": fullName,
        "dob": dob,
        "club_id": clubId,
        "super_strength": superStrength,
        "support_team": supportTeam,
        "playing_position_id": selectedPosition,
        "contact_name": contactName,
        "rel_type": relationName,
        "mobile_no": mobile,
        "school_name": schoolName,
        "school_contact_name": schoolContactName,
        "job_title": jobTitle,
        "school_email": schoolEmail,
        "school_phone_no": schoolPhone,
        "club_safeguarder": clubSafegaurderNumber,
        "club_email": clubSafegaurderMail
      });

      final profileMapResponse = await post(Uri.parse(url),
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
        errorMessage = json.decode(profileMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> updateUserProfile(
    String fullName,
    String dob,
    int clubId,
    int selectedPosition,
    String superStrength,
    String supportTeam,
    String contactName,
    String relationName,
    String mobile,
    String contactEmail,
    String schoolName,
    String schoolContactName,
    String jobTitle,
    String schoolEmail,
    String schoolPhone,
    String clubSafegaurderNumber,
    String clubSafegaurderMail,
  ) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.profileUpdateUrl}';

      final inputBodyVal = json.encode({
        "full_name": fullName,
        "dob": dob,
        "club_id": clubId,
        "super_strength": superStrength,
        "support_team": supportTeam,
        "playing_position_id": selectedPosition,
        "contact_name": contactName,
        "rel_type": relationName,
        "mobile_no": mobile,
        "school_name": schoolName,
        "school_contact_name": schoolContactName,
        "job_title": jobTitle,
        "school_email": schoolEmail,
        "school_phone_no": schoolPhone,
        "club_safeguarder": clubSafegaurderNumber,
        "club_email": clubSafegaurderMail
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
  }

  Future<void> updateUserProfilePic(var fileObj) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;

      final headers = {
        //'Accept': 'application/vnd.api.v1+json',
        'Content-Type': 'image/jpeg',
        //'application/json',
        'Authorization': 'Bearer $_tokenVal'
      };

      const assetUrl = '${AppConfig.baseUrl}${AppConfig.assetsUrl}';

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
          'file', //parameter name on server side
          file.readStream,
          file.size,
          filename: file.name,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      //-------Send request
      var resp = await request.send();

      if (resp.statusCode < 400) {
        //------Read response
        /*   final profileImageResponse = await resp.stream.bytesToString(); */

        final profileImageResponse = json
            .decode(await resp.stream.bytesToString()) as Map<String, dynamic>;
        //await resp.stream.bytesToString();

        final uuid = profileImageResponse['data']['id'];

        const url = '${AppConfig.baseUrl}${AppConfig.profileUpdateUrl}';

        final inputBodyVal = json.encode({
          "uuid": uuid,
        });

        final profileMapResponse = await patch(Uri.parse(url),
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

        //print(profileImageResponse);
        notifyListeners();
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = resp.reasonPhrase;
        //json.decode(profileMapResponse.body)['message'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
