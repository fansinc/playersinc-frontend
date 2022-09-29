class ProfileModel {
  ProfileModel({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.fullName,
    required this.dob,
    this.profileImage,
    required this.clubId,
    required this.clubName,
    required this.superStrength,
    required this.supportTeam,
    required this.playingPositionId,
    required this.playingPositionName,
    required this.contactName,
    required this.contactRelType,
    required this.contactMobileNo,
    required this.contactEmail,
    required this.schoolName,
    required this.schoolContactName,
    required this.jobTitle,
    required this.schoolEmail,
    required this.schoolPhoneNo,
    required this.clubSafeGuarderNumber,
    required this.clubSafeGuarderEmail,
    required this.createdAt,
    required this.updatedAt,
    required this.clubImage,
    // this.clubs,
  });

  int id;
  int userId;
  String userEmail;
  String fullName;
  String dob;
  String? profileImage;
  int clubId;
  String clubName;
  String superStrength;
  String supportTeam;
  int playingPositionId;
  String playingPositionName;
  String contactName;
  String contactRelType;
  String contactMobileNo;
  String contactEmail;
  String schoolName;
  String schoolContactName;
  String jobTitle;
  String schoolEmail;
  String schoolPhoneNo;
  String clubSafeGuarderNumber;
  String clubSafeGuarderEmail;
  String createdAt;
  String updatedAt;
  String clubImage;
  //Clubs? clubs;

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_email": userEmail,
        "full_name": fullName,
        "dob": dob,
        "club_id": clubId,
        "club_name": clubName,
        "super_strength": superStrength,
        "support_team": supportTeam,
        "contact_name": contactName,
        "rel_type": contactRelType,
        "mobile_no": contactMobileNo,
        "school_name": schoolName,
        "school_contact_name": schoolContactName,
        "job_title": jobTitle,
        "school_email": schoolEmail,
        "school_phone_no": schoolPhoneNo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        // "Clubs": clubs!.toJson(),
      };
}

class Clubs {
  Clubs({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.ownerName,
    required this.statusId,
    required this.statusName,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.clubImage,
  });

  int id;
  String name;
  int ownerId;
  String ownerName;
  int statusId;
  String statusName;
  int createdBy;
  int updatedBy;
  String createdAt;
  String updatedAt;
  String clubImage;
/* 
  factory ClubsData.fromJson(Map<String, dynamic> json) => ClubsData(
        id: json["id"],
        name: json["name"],
        ownerId: json["owner_id"],
        ownerName: json["owner_name"],
        statusId: json["status_id"],
        statusName: json["status_name"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      ); */

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "owner_id": ownerId,
        "owner_name": ownerName,
        "status_id": statusId,
        "status_name": statusName,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
