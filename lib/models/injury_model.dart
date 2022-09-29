class InjuryModel {
  InjuryModel({
    required this.id,
    required this.playerId,
    required this.playerName,
    required this.injuredDate,
    required this.injury,
    required this.howLongDate,
    required this.statusId,
    required this.statusName,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    // required  this.symptoms,
  });

  int id;
  int playerId;
  String playerName;
  String injuredDate;
  //String injuredPlace;
  String injury;
  String howLongDate;
  //String diagnosis;
  int statusId;
  String statusName;
  int createdBy;
  int updatedBy;
  String createdAt;
  String updatedAt;
  //  Symptoms symptoms;

  factory InjuryModel.fromJson(Map<String, dynamic> json) => InjuryModel(
        id: json["id"],
        playerId: json["player_id"],
        playerName: json["player_name"],
        injuredDate: json["injured_date"],
        injury: json["injured_place"],
        howLongDate: json["diagnosis"],
        statusId: json["status_id"],
        statusName: json["status_name"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        //symptoms: Symptoms.fromJson(json["Symptoms"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "player_id": playerId,
        "player_name": playerName,
        "injured_date": injuredDate,
        "injury": injury,
        "howLongDate": howLongDate,
        "status_id": statusId,
        "status_name": statusName,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        // "Symptoms": symptoms.toJson(),
      };
}
/* 
class Symptoms {
    Symptoms({
        this.data,
    });

    List<dynamic> data;

    factory Symptoms.fromJson(Map<String, dynamic> json) => Symptoms(
        data: List<dynamic>.from(json["data"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
    };
}
 */