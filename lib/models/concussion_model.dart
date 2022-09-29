class ConcussionModel {
  ConcussionModel({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.concussionDate,
    required this.statusId,
    required this.statusName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int playerId;
  String playerName;
  String concussionDate;

  int statusId;
  String statusName;
  String createdAt;
  String updatedAt;

  factory ConcussionModel.fromJson(Map<String, dynamic> json) =>
      ConcussionModel(
        id: json["id"],
        playerId: json["player_id"],
        playerName: json["player_name"],
        concussionDate: json["concussion_date"],
        statusId: json["status_id"],
        statusName: json["status_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "player_id": playerId,
        "player_name": playerName,
        "concussion_date": concussionDate,
        "status_id": statusId,
        "status_name": statusName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
