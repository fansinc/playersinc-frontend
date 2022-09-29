//import '/pages/email_auth_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playersinc/pages/home_page.dart';
import '/models/profile_model.dart';
import 'package:provider/provider.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '/models/clubs_model.dart';
import '/models/player_position_model.dart';

import '/providers/clubs_provider.dart';
import '/providers/positions_provider.dart';
import '/providers/auth_provider.dart';
import '/providers/profile_provider.dart';

import '/config/app_config.dart';
import '/config/app_strings.dart';

import 'email_auth_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profilePage';

  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isInit = true;
  bool isLoading = false;
  //late ProfileModel profile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String fullName;
  late String dob;
  late int clubId;
  late String superStrength;
  late String supportTeam;
  late String contactName;
  late String contactRelationship;
  late int contactMobile;
  late String contactEmail;
  late String schoolName;
  late String schoolContactName;
  late String jobTitle;
  late String schoolEmail;
  late String schoolPhone;
  late int clubSafegaurderNumber;
  late String clubSafegaurderMail;
  late String profileImage;

  List<ClubsModel> clubsList = [];
  List<PlayerPositionModel> playerPositionList = [];

  late String selectedClub;
  late String selectedPosition;
  late ProfileModel profileData;

  DateTime selectedDate = DateTime.now();

  late String selectedDateFormatted;

  bool profileCreated = false;
  /* late String name;

  late String email;
/*   String? password;
  String? confirmPassword;
  String? role;
  //String? dob; */
  late String mobile; */

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });

      Provider.of<ClubsProvider>(context, listen: false)
          .fetchSetClubs()
          .then((value) {
        clubsList = value;
        Provider.of<PositionsProvider>(context, listen: false)
            .fetchSetPlayerPositions()
            .then((value) {
          playerPositionList = value;

          profileData = Provider.of<ProfileProvider>(context, listen: false)
              .fetchUserProfile();
          if (profileData.fullName.isNotEmpty) {
            fullName = profileData.fullName;
            dob = profileData.dob;
            clubId = profileData.clubId;
            superStrength = profileData.superStrength;
            supportTeam = profileData.supportTeam;
            contactName = profileData.contactName;
            contactRelationship = profileData.contactRelType;
            contactMobile = int.parse(profileData.contactMobileNo);
            contactEmail = profileData.userEmail;
            schoolName = profileData.schoolName;
            schoolContactName = profileData.schoolContactName;
            jobTitle = profileData.jobTitle;
            schoolEmail = profileData.schoolEmail;
            schoolPhone = profileData.schoolPhoneNo;
            clubSafegaurderNumber =
                int.parse(profileData.clubSafeGuarderNumber);
            clubSafegaurderMail = profileData.clubSafeGuarderEmail;
            profileCreated = true;
          }
          setState(() {
            isLoading = false;
          });
        }).catchError((error) {
          if (error
              .toString()
              .contains("Field 'profileModel' has not been initialized.")) {
            //do nothing
            //print(error.toString());
          } else {
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text(AppStrings.error),
                    content: Text(error.toString()),
                    actions: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            /*   Navigator.of(context)
                            .pop(); // Navigate to previous screen */
                            if (error.toString() ==
                                AppStrings.tokenExpiryMessage) {
                              Navigator.of(context).pushReplacementNamed(
                                  EmailAuthPage.routeName);
                            }
                          },
                          icon: const Icon(Icons.close),
                          label: const Text(AppStrings.close))
                    ],
                  );
                });
          }

          setState(() {
            isLoading = false;
          });
        });
        //});
      });
    }
    super.didChangeDependencies();
    isInit = false;
  }

  void validateCreate() async {
    // if (_formKey.currentState.validate()) {
    /*   var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) { */
    try {
      // _formKey.currentState!.save();
      if (profileCreated) {
        await Provider.of<ProfileProvider>(context, listen: false)
            .updateUserProfile(
          fullName,
          selectedDateFormatted, //dob,
          //clubId,
          int.parse(selectedClub),
          int.parse(selectedPosition),
          superStrength,
          supportTeam,
          contactName,
          contactRelationship,
          contactMobile.toString(),
          contactEmail,
          schoolName,
          schoolContactName,
          jobTitle,
          schoolEmail,
          schoolPhone,
          clubSafegaurderNumber.toString(),
          clubSafegaurderMail,
        );
      } else {
        await Provider.of<ProfileProvider>(context, listen: false)
            .createUserProfile(
          fullName,
          selectedDateFormatted, //dob,
          //clubId,
          int.parse(selectedClub),
          int.parse(selectedPosition),
          superStrength,
          supportTeam,
          contactName,
          contactRelationship,
          contactMobile.toString(),
          contactEmail,
          schoolName,
          schoolContactName,
          jobTitle,
          schoolEmail,
          schoolPhone,
          clubSafegaurderNumber.toString(),
          clubSafegaurderMail,
        );
      }

      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.profileUpdateSuccess),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text(AppStrings.close))
              ],
            );
          });
    } catch (error) {
      //print(error);
      showDialog(
          context: context,
          builder: (_) {
            String errorMsg = error.toString();
            if (error.toString().contains(
                "Field 'selectedDateFormatted' has not been initialized.")) {
              errorMsg = 'Please provide the correct DOB';
            }
            if (error
                .toString()
                .contains("Field 'selectedClub' has not been initialized.")) {
              errorMsg = 'Please select the Club';
            }
            if (error.toString().contains(
                "Field 'selectedPosition' has not been initialized.")) {
              errorMsg = 'Please select the Playing position';
            }
            /*  else {
              errorMsg = error.toString();
            } */
            return AlertDialog(
              title: const Text(AppStrings.error),
              content: Text(errorMsg
                  //error.toString()
                  ),
              actions: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      /*  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          AuthPage.routeName); */
                    },
                    icon: const Icon(Icons.close),
                    label: const Text(AppStrings.close))
              ],
            );
          });
      setState(() {
        isLoading = false;
      });
      //}
    }
    setState(() {
      isLoading = false;
    });
  }

  void filePickSubmit(var picked) {
    //print(picked.files.first.name);
    setState(() {
      isLoading = true;
    });
    Provider.of<ProfileProvider>(context, listen: false)
        .updateUserProfilePic(picked)
        .then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.error),
              content: Text(error.toString()),
              actions: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (error.toString() == AppStrings.tokenExpiryMessage) {
                        Navigator.of(context)
                            .pushReplacementNamed(EmailAuthPage.routeName);
                      }
                    },
                    icon: const Icon(Icons.close),
                    label: const Text(AppStrings.close))
              ],
            );
          });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            AppStrings.profilePage,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            //color: Color(AppColors.blueColor),
            color: Colors.white, //change your color here
          ),
          actions: [
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                elevation: 10,
                primary: const Color(AppConfig.orangeColor),
                /*   shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ), */
              ),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();

                /* Navigator.pushReplacementNamed(
                                  context, EmailAuthPage.routeName); */
                Navigator.pushNamedAndRemoveUntil(context,
                    EmailAuthPage.routeName, (Route<dynamic> route) => false);
              },
              icon: const Icon(
                MdiIcons.logoutVariant,
                color: Colors.white,
              ),
              label: const Text(
                '',
                // AppStrings.logout,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        backgroundColor: const Color(AppConfig.blueColor),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : WillPopScope(
                onWillPop: () {
                  Navigator.pop(context, true);
                  Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName,
                      (Route<dynamic> route) => false);
                  return Future.value(false);
                },
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              var picked = await FilePicker.platform.pickFiles(
                                withReadStream: true,
                                type: FileType.image,
                              );
                              if (picked != null) {
                                //print(picked.files.first.name);
                                filePickSubmit(picked);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: profileCreated
                                          ? profileData.profileImage!.isNotEmpty
                                              ? CachedNetworkImage(
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      profileData.profileImage!,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    AppConfig.defaultImage,
                                                    //width: 50,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    AppConfig.defaultImage,
                                                    // width: 50,
                                                  ),
                                                  //fit: BoxFit.fitHeight,
                                                )
                                              : Image.asset(
                                                  AppConfig.logoImage,
                                                  // width: 225,
                                                )
                                          : Image.asset(
                                              AppConfig.logoImage,
                                              // width: 225,
                                            )
                                      /* Image.network(
                                                profileData.profileImage!) */

                                      ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            AppStrings.fullName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue:
                                  profileCreated ? profileData.fullName : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: firstNameFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.fullNameValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                fullName = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.dob,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  //DateTime.now(),
                                  firstDate: DateTime(1960, 1),
                                  lastDate: DateTime(2101));
                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate = picked;
                                  selectedDateFormatted =
                                      DateFormat('dd/MM/yyyy')
                                          .format(selectedDate);
                                });
                              }
                            },
                            child: Container(
                                height: 60,
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: const Color(AppConfig.grey),
                                    border: Border.all(
                                        // color: Colors.red,
                                        ),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                child: Text(DateFormat('dd-MMM-yyyy')
                                    .format(selectedDate))
                                /*child: 
                               TextFormField(
                                /* initialValue: profileData.dob.isNotEmpty
                                    ? profileData.dob
                                    : '', */
                                style: const TextStyle(
                                  color: Colors.black,
                                  // Color(AppConfig.blueColor),
                                ),
                                cursorColor: Colors.black,
                                //Color(AppConfig.blueColor),
                                //controller: loginEmailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                validator: (value) =>
                                    value!.isEmpty ? AppStrings.dobValidate : null,
                                onChanged: (value) {
                                  dob = value;
                                },
                              ), */
                                ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.club,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonFormField2(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(AppConfig.grey),
                              focusColor: Colors.grey,
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              AppStrings.selectClub,
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: clubsList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.clubId.toString(),
                                      child: Text(
                                        item.clubName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return AppStrings.selectClubValidator;
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                              selectedClub = value.toString();
                            },
                            onSaved: (value) {
                              selectedClub = value.toString();
                            },
                          ),
                          /*Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                           
                             child: TextFormField(
                                //controller: nameController,
                                // initialValue: mobile,
                                style: const TextStyle(
                                  color: Colors.black,
                                  // Color(AppConfig.blueColor),
                                ),
                                cursorColor: Colors.black,
                                //Color(AppConfig.blueColor),
                                //controller: loginEmailController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textInputAction: TextInputAction.next,
                                //focusNode: mobileFocusNode,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return (AppStrings.clubValidate);
                                  }
                                  return null;
                                },
                                /* =>
                                    value.isEmpty ? AppStrings.nameValidate : null, */
                                onChanged: (value) {
                                  clubId = int.parse(value);
                                },
                                //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                              ), 
                          ),*/
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.playingPosition,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonFormField2(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(AppConfig.grey),
                              focusColor: Colors.grey,
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              AppStrings.selectPlayingPosition,
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: playerPositionList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.positionId.toString(),
                                      child: Text(
                                        item.positionName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return AppStrings
                                    .selectPlayingPositionValidator;
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                              selectedPosition = value.toString();
                            },
                            onSaved: (value) {
                              selectedPosition = value.toString();
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.addSuperStrength,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue: profileCreated
                                  ? profileData.superStrength
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.addSuperStrengthValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                superStrength = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.addSupportTeam,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue:
                                  profileCreated ? profileData.supportTeam : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.addSupportTeamValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                supportTeam = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          /*
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ), */
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              AppStrings.inCaseOfEmergency,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.pleaseAddEmergency,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.contactName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue:
                                  profileCreated ? profileData.contactName : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: firstNameFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.contactNameValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                contactName = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.contactRelationship,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              initialValue: profileCreated
                                  ? profileData.contactRelType
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (value) => value!.isEmpty
                                  ? AppStrings.contactRelationshipValidate
                                  : null,
                              onChanged: (value) {
                                contactRelationship = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.contactMobile,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue: profileCreated
                                  ? profileData.contactMobileNo
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings
                                      .contactRelationshipValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                contactMobile = int.parse(value);
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.contactEmail,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue:
                                  profileCreated ? profileData.userEmail : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings
                                      .contactRelationshipValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                contactEmail = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          /*  const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ), */
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              AppStrings.addSchoolContact,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.schoolName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue:
                                  profileCreated ? profileData.schoolName : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.schoolNameValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                schoolName = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.schoolContactName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue: profileCreated
                                  ? profileData.schoolContactName
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: firstNameFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.schoolContactNameValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                schoolContactName = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.schoolContactJobTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              initialValue:
                                  profileCreated ? profileData.jobTitle : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (value) => value!.isEmpty
                                  ? AppStrings.schoolContactJobTitleValidate
                                  : null,
                              onChanged: (value) {
                                jobTitle = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.schoolEmail,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue:
                                  profileCreated ? profileData.schoolEmail : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.schoolEmailValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                schoolEmail = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.schoolPhoneNo,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue: profileCreated
                                  ? profileData.schoolPhoneNo
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings.schoolPhoneNoValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                schoolPhone = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              AppStrings.addClubContact,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.clubSafegaurderNumber,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue: profileCreated
                                  ? profileData.clubSafeGuarderNumber
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings
                                      .clubSafeGaurderPhoneNoValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                clubSafegaurderNumber = int.parse(value);
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppStrings.clubSafegaurderMail,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                border: Border.all(
                                    // color: Colors.red,
                                    ),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: TextFormField(
                              //controller: nameController,
                              initialValue: profileCreated
                                  ? profileData.clubSafeGuarderEmail
                                  : '',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(AppConfig.blueColor),
                              ),
                              cursorColor: Colors.black,
                              //Color(AppConfig.blueColor),
                              //controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.next,
                              //focusNode: firstNameFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (AppStrings
                                      .clubSafeGaurderEmailValidate);
                                }
                                return null;
                              },
                              /* =>
                                  value.isEmpty ? AppStrings.nameValidate : null, */
                              onChanged: (value) {
                                clubSafegaurderMail = value;
                              },
                              //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                            ),
                          ),

                          const SizedBox(height: 30),

                          isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color(AppConfig.buttonBlueColor),
                                    //Color(AppConfig.greenColor),
                                  ),
                                  onPressed: () => validateCreate(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: double.infinity,
                                    child: const Text(
                                      AppStrings.submit,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                          //),
                          const SizedBox(height: 10),
                          Center(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                elevation: 10,
                                primary: const Color(AppConfig.orangeColor),
                                /*   shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ), */
                              ),
                              onPressed: () {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .logout();

                                /* Navigator.pushReplacementNamed(
                                    context, EmailAuthPage.routeName); */
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    EmailAuthPage.routeName,
                                    (Route<dynamic> route) => false);
                              },
                              icon: const Icon(
                                MdiIcons.logoutVariant,
                                color: Colors.white,
                              ),
                              label: const Text(
                                AppStrings.logout,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
