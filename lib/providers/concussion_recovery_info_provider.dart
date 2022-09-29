import 'package:flutter/material.dart';

import '/models/concussion_recovery_info_model.dart';

class ConcussionRecoveryInfoProvider with ChangeNotifier {
  List<ConcussionRecoveryInfoModel> concussionRecoveryInfoModelList = [
    ConcussionRecoveryInfoModel(
      id: 1,
      advice: [
        'No exercise',
        'Take a break from studying',
        'Keep screen time low',
      ],
      adviserName: 'Alex Waller',
      day: 1,
      checkBackDay: 22,
    ),
    ConcussionRecoveryInfoModel(
      id: 2,
      advice: [
        'No exercise',
        'Take a break from studying',
        'Keep screen time low',
      ],
      adviserName: 'Alex Waller',
      day: 2,
      checkBackDay: 21,
    ),
    ConcussionRecoveryInfoModel(
      id: 3,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Sam Matavesi',
      day: 3,
      checkBackDay: 20,
    ),
    ConcussionRecoveryInfoModel(
      id: 4,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Sam Matavesi',
      day: 4,
      checkBackDay: 19,
    ),
    ConcussionRecoveryInfoModel(
      id: 5,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Ollie Sleightholme',
      day: 5,
      checkBackDay: 18,
    ),
    ConcussionRecoveryInfoModel(
      id: 6,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Sam Matavesi',
      day: 6,
      checkBackDay: 17,
    ),
    ConcussionRecoveryInfoModel(
      id: 7,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Ollie Sleightholme',
      day: 7,
      checkBackDay: 16,
    ),
    ConcussionRecoveryInfoModel(
      id: 8,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Marcus Smith',
      day: 8,
      checkBackDay: 15,
    ),
    ConcussionRecoveryInfoModel(
      id: 9,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Alex Mitchell',
      day: 9,
      checkBackDay: 14,
    ),
    ConcussionRecoveryInfoModel(
      id: 10,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Marcus Smith',
      day: 10,
      checkBackDay: 13,
    ),
    ConcussionRecoveryInfoModel(
      id: 11,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Alex Mitchell',
      day: 11,
      checkBackDay: 12,
    ),
    ConcussionRecoveryInfoModel(
      id: 12,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Raffi Quirk',
      day: 12,
      checkBackDay: 11,
    ),
    ConcussionRecoveryInfoModel(
      id: 13,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Tom Curry',
      day: 13,
      checkBackDay: 10,
    ),
    ConcussionRecoveryInfoModel(
      id: 14,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Emily Scarrat',
      day: 14,
      checkBackDay: 9,
    ),
    ConcussionRecoveryInfoModel(
      id: 15,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Tom Curry',
      day: 15,
      checkBackDay: 8,
    ),
    ConcussionRecoveryInfoModel(
      id: 16,
      advice: [
        'Time to get moving',
        'Avoid triggering symptoms',
        'Take a break from studying',
      ],
      adviserName: 'Raffi Quirk',
      day: 16,
      checkBackDay: 7,
    ),
    ConcussionRecoveryInfoModel(
      id: 17,
      advice: [
        'Time to get moving',
        'Try a brisk walk or medium pace cycling',
        'Avoid resistance training',
      ],
      adviserName: 'Jonny Wilkinson',
      day: 17,
      checkBackDay: 6,
    ),
    ConcussionRecoveryInfoModel(
      id: 18,
      advice: [
        'Time to get moving',
        'Try a brisk walk or medium pace cycling',
        'Avoid resistance training',
      ],
      adviserName: 'John Fletcher',
      day: 18,
      checkBackDay: 5,
    ),
    ConcussionRecoveryInfoModel(
      id: 19,
      advice: [
        'Add running drills to your recovery',
        'Avoid head impact activities',
      ],
      adviserName: 'Jonny Wilkinson',
      day: 19,
      checkBackDay: 4,
    ),
    ConcussionRecoveryInfoModel(
      id: 20,
      advice: [
        'Add running drills to your recovery',
        'Avoid head impact activities',
      ],
      adviserName: 'John Fletcher',
      day: 20,
      checkBackDay: 3,
    ),
    ConcussionRecoveryInfoModel(
      id: 21,
      advice: [
        'Add running drills to your recovery',
        'Avoid head impact activities',
      ],
      adviserName: 'Russell Earnshaw',
      day: 2,
      checkBackDay: 21,
    ),
    ConcussionRecoveryInfoModel(
      id: 22,
      advice: [
        'Add running drills to your recovery',
        'Avoid head impact activities',
      ],
      adviserName: 'Russell Earnshaw',
      day: 22,
      checkBackDay: 1,
    ),
  ];

  List<ConcussionRecoveryInfoModel> get fetchConcussionRecoveryInfoList {
    return [...concussionRecoveryInfoModelList];
  }
}
