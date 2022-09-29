class ConcussionRecoveryInfoModel {
  ConcussionRecoveryInfoModel({
    required this.id,
    required this.day,
    required this.adviserName,
    required this.advice,
    required this.checkBackDay,
  });

  int id;
  int day;
  String adviserName;
  List<String> advice;

  int checkBackDay;
}
