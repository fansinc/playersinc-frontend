class Challenges {
  Challenges({
    required this.id,
    required this.name,
    required this.type,
    required this.position,
    required this.challenges,
  });

  int id;
  String name;
  String type;
  int position;
  List<ChallengesData> challenges;
}

class ChallengesData {
  ChallengesData({
    required this.id,
    required this.name,
    required this.description,
    required this.physicalSkills,
    required this.brainSkills,
    required this.rugbySkills,
    required this.challengeLevelId,
    //required this.challengeLevelName,
    required this.stageId,
    //required this.stageName,
    //required this.stagePosition,
    required this.ageGroupId,
    //required this.ageGroupName,
    required this.price,
    required this.statusId,
    //required this.statusName,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    //required this.assets,
    this.isEligible,
    required this.isCompleted,
  });

  int id;
  String name;
  String description;
  String physicalSkills;
  String brainSkills;
  String rugbySkills;
  int challengeLevelId;
  //String challengeLevelName;
  int stageId;
/*   String stageName;
  String stagePosition; */
  int ageGroupId;
  //String ageGroupName;
  String price;
  int statusId;
  //String statusName;
  int createdBy;
  int updatedBy;
  String createdAt;
  String updatedAt;
  bool? isEligible;
  bool isCompleted;
  // Challenges assets;

  factory ChallengesData.fromJson(Map<String, dynamic> json) => ChallengesData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        physicalSkills: json["physical_skills"],
        brainSkills: json["brain_skills"],
        rugbySkills: json["rugby_skills"],
        challengeLevelId: json["challenge_level_id"],
        //challengeLevelName: json["challenge_level_name"],
        stageId: json["stage_id"],
        //stageName: json["stage_name"],
        // stagePosition: json["stage_position"],
        ageGroupId: json["age_group_id"],
        // ageGroupName: json["age_group_name"],
        price: json["price"],
        statusId: json["status_id"],
        // statusName: json["status_name"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isCompleted: json["is_completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "physical_skills": physicalSkills,
        "brain_skills": brainSkills,
        "rugby_skills": rugbySkills,
        "challenge_level_id": challengeLevelId,
        //"challenge_level_name": challengeLevelName,
        "stage_id": stageId,
        // "stage_name": stageName,
        // "stage_position": stagePosition,
        "age_group_id": ageGroupId,
        // "age_group_name": ageGroupName,
        "price": price,
        "status_id": statusId,
        //"status_name": statusName,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        //"Assets": assets.toJson(),
      };
}



/* class Meta {
    Meta({
        this.pagination,
    });

    Pagination pagination;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
    };
}

class Pagination {
    Pagination({
        this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
        this.links,
    });

    int total;
    int count;
    int perPage;
    int currentPage;
    int totalPages;
    Links links;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: Links.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": links.toJson(),
    };
}

class Links {
    Links();

    factory Links.fromJson(Map<String, dynamic> json) => Links(
    );

    Map<String, dynamic> toJson() => {
    };
} */
