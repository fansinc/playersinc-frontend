class Missions {
  Missions({
    required this.id,
    required this.name,
    required this.missions,
  });

  int id;
  String name;

  List<MissionsData> missions;
}

class MissionsData {
  MissionsData({
    required this.id,
    required this.name,
    required this.description,
    required this.missionLevelId,
    required this.ageGroupId,
    required this.price,
    required this.statusId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    this.isEligible,
    required this.isCompleted,
  });

  int id;
  String name;
  String description;

  int missionLevelId;

  int ageGroupId;

  String price;
  int statusId;

  int createdBy;
  int updatedBy;
  String createdAt;
  String updatedAt;
  bool? isEligible;
  bool isCompleted;
  // Challenges assets;

  factory MissionsData.fromJson(Map<String, dynamic> json) => MissionsData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        missionLevelId: json["challenge_level_id"],
        ageGroupId: json["age_group_id"],
        price: json["price"],
        statusId: json["status_id"],
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
        "mission_level_id": missionLevelId,
        "age_group_id": ageGroupId,
        "price": price,
        "status_id": statusId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
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
