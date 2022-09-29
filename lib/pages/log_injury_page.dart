//import '/pages/email_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/providers/injury_provider.dart';
import '/models/symptoms_model.dart';
//import '/providers/symptoms_provider.dart';
import 'package:provider/provider.dart';

//import 'package:dropdown_button2/dropdown_button2.dart';

import '/providers/profile_provider.dart';

import '/config/app_config.dart';
import '/config/app_strings.dart';

//import 'email_auth_page.dart';

class LogInjuryPage extends StatefulWidget {
  static const routeName = '/logInjuryPage';

  const LogInjuryPage({Key? key}) : super(key: key);
  @override
  State<LogInjuryPage> createState() => _LogInjuryPageState();
}

class _LogInjuryPageState extends State<LogInjuryPage> {
  bool isInit = true;
  bool isLoading = false;
  //late ProfileModel profile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String playerId;
  late String injuredDate;
  late String howLongDate;
  late String injury;
  //late String injuredPlace;
  //late List<int> symptoms = [];

  List<SymptomsModel> symptomsList = [];

  late String selectedSymptom;

  DateTime selectedDate = DateTime.now();

  /* @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });

      Provider.of<SymptomsProvider>(context, listen: false)
          .fetchSetSymptoms()
          .then((value) {
        symptomsList = value;

        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        // print(error);
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
      //});

    }
    super.didChangeDependencies();
    isInit = false;
  } */

  void validateCreate() async {
    // if (_formKey.currentState.validate()) {
    /*   var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) { */
    try {
      // _formKey.currentState!.save();
      //symptoms.add(int.parse(selectedSymptom));
      await Provider.of<InjuryProvider>(context, listen: false)
          .createPlayerInjury(
        playerId, injuredDate, injury, howLongDate,
        //symptoms
      );
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.success),
              content: const Text(AppStrings.injuryLogSuccess),
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
            return AlertDialog(
              title: const Text(AppStrings.error),
              content: Text(error.toString()),
              actions: [
                ElevatedButton.icon(
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

  @override
  Widget build(BuildContext context) {
    final profileData =
        Provider.of<ProfileProvider>(context).fetchUserProfile();
    playerId = profileData.userId.toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            AppStrings.injuryPageTitle,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            //color: Color(AppColors.blueColor),
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: const Color(AppConfig.logInjuryPageColor),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          AppStrings.dateInjury,
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
                                lastDate: DateTime.now());
                            //DateTime(2101));
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                                injuredDate = DateFormat('dd/MM/yyyy')
                                    .format(selectedDate);
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                /*  border: Border.all(
                                  // color: Colors.red,
                                  ), */
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Text(
                                DateFormat('dd-MMM-yyyy').format(selectedDate)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          AppStrings.whatsInjury,
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
                              /* border: Border.all(
                                  // color: Colors.red,
                                  ), */
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: TextFormField(
                            //controller: nameController,

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
                              injury = value;
                            },
                            //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          AppStrings.howLongInjury,
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
                                howLongDate = DateFormat('dd/MM/yyyy')
                                    .format(selectedDate);
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: const Color(AppConfig.grey),
                                /*  border: Border.all(
                                  // color: Colors.red,
                                  ), */
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Text(
                                DateFormat('dd-MMM-yyyy').format(selectedDate)),
                          ),
                        ),
                        /*  const SizedBox(height: 10),
                        const Text(
                          AppStrings.symptom,
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
                            AppStrings.selectSymptom,
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
                          items: symptomsList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.symptomId.toString(),
                                    child: Text(
                                      item.symptomName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return AppStrings.selectSymptomValidator;
                            }
                          },
                          onChanged: (value) {
                            //Do something when changing the item if you want.
                            selectedSymptom = value.toString();
                          },
                          onSaved: (value) {
                            selectedSymptom = value.toString();
                          },
                        ), */

                        const SizedBox(height: 30),

                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(
                                        AppConfig.logInjuryButtonColor),
                                    //Color(AppConfig.greenColor),
                                  ),
                                  onPressed: () => validateCreate(),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 150,
                                    child: const Text(
                                      AppStrings.save,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 50),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              /* border: Border.all(
                                  // color: Colors.red,
                                  ), */
                              borderRadius: BorderRadius.circular(30)),
                          //padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: const Text(
                            AppStrings.openInjuryLog,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
