
class ExperienceModel {
  int? id;
  String? name;
  String? tagline;
  String? description;
  String? imageUrl;
  String? iconUrl;

  ExperienceModel({this.id, this.name, this.tagline, this.description, this.imageUrl, this.iconUrl});

  ExperienceModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["tagline"] is String) {
      tagline = json["tagline"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if(json["icon_url"] is String) {
      iconUrl = json["icon_url"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["tagline"] = tagline;
    _data["description"] = description;
    _data["image_url"] = imageUrl;
    _data["icon_url"] = iconUrl;
    return _data;
  }
}