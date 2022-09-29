class LogTimeModel {
  LogTimeModel({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.playingDate,
    required this.trainingTime,
    required this.gameTime,
    required this.levelId,
    required this.levelName,
    required this.totalTime,
    required this.statusId,
    required this.statusName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int playerId;
  String playerName;
  String playingDate;
  String trainingTime;
  String gameTime;
  int levelId;
  String levelName;
  String totalTime;
  int statusId;
  String statusName;
  String createdAt;
  String updatedAt;

  factory LogTimeModel.fromJson(Map<String, dynamic> json) => LogTimeModel(
        id: json["id"],
        playerId: json["player_id"],
        playerName: json["player_name"],
        playingDate: json["playing_date"],
        trainingTime: json["training_time"],
        gameTime: json["game_time"],
        levelId: json["level_id"],
        levelName: json["level_name"],
        totalTime: json["total_time"],
        statusId: json["status_id"],
        statusName: json["status_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "player_id": playerId,
        "player_name": playerName,
        "playing_date": playingDate,
        "training_time": trainingTime,
        "game_time": gameTime,
        "level_id": levelId,
        "level_name": levelName,
        "total_time": totalTime,
        "status_id": statusId,
        "status_name": statusName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
