class Geolocation {
  String? locality;
  String? district;

  Geolocation({required this.locality, required this.district});

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    String locality;
    String district = "";
    if (json['geo_object']['locality'] != null) {
      locality = json['geo_object']['locality']['name'];
    } else if (json['geo_object']['province'] != null) {
      locality = json['geo_object']['province']['name'];
    } else {
      locality = "А где вы?";
    }
    if (json['geo_object']['district'] != null) {
      district = json['geo_object']['district']['name'];
    }
    return Geolocation(locality: locality, district: district);
  }
}

class GeoObject {
  District? district;
  Locality? locality;

  GeoObject({this.district, this.locality});

  factory GeoObject.fromJson(Map<String, dynamic> json) => GeoObject(
        district: json['district'] as dynamic,
        locality: json['locality'] == null
            ? null
            : Locality.fromJson(json['locality'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'district': district,
        'locality': locality?.toJson(),
      };
}

class Locality {
  String? name;

  Locality({this.name});

  factory Locality.fromJson(Map<String, dynamic> json) => Locality(
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

class District {
  String? name;

  District({this.name});

  factory District.fromJson(Map<String, dynamic> json) => District(
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
