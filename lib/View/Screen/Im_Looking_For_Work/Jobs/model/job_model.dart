import 'dart:math';
import 'package:go_roqit_app/service/api_url.dart';

class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String location;
  final String jobType;
  final String salary;
  final String logoUrl;
  final String postedTime;
  final String workingHours;
  final String workSystem;
  final List<String> skills;
  final String companyDescription;
  final List<String> businessPhotos;
  final List<String> requirements;
  final List<String> benefits;
  final double? latitude;
  final double? longitude;
  final String recruiterId;
  final double? distance;

  JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.logoUrl,
    required this.postedTime,
    required this.workingHours,
    required this.workSystem,
    required this.skills,
    required this.companyDescription,
    required this.businessPhotos,
    required this.requirements,
    required this.benefits,
    this.latitude,
    this.longitude,
    required this.recruiterId,
    this.distance,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    String constructSalary() {
        if (json["paymentType"] == "hourly" || json["paymentType"] == "monthly") {
            if (json["minSalary"] != null && json["maxSalary"] != null) {
                return "\$${json["minSalary"]} - \$${json["maxSalary"]}/${json["paymentType"]}";
            } else if (json["minSalary"] != null) {
                 return "\$${json["minSalary"]}/${json["paymentType"]}";
            }
        }
        if (json["rent"] != null) {
             return "\$${json["rent"]}/${json["paymentType"] ?? "Rent"}";
        }
        return "Not specified";
    }

    String logo = "https://images.unsplash.com/photo-1560066984-138dadb4c035?ixlib=rb-1.2.1&auto=format&fit=crop&w=200&q=80"; // default
    if (json["user"] != null && json["user"]["profile"] != null && json["user"]["profile"]["companyLogo"] != null) {
         logo = ApiUrl.IMGUrl + json["user"]["profile"]["companyLogo"];
    }

    double? lat = json["latitude"]?.toDouble();
    double? lng = json["longitude"]?.toDouble();

    // Check for GeoJSON location field if top-level lat/lng are missing
    if (json["location"] != null && json["location"]["coordinates"] != null) {
      List coords = json["location"]["coordinates"];
      if (coords.length >= 2) {
        lng = coords[0]?.toDouble();
        lat = coords[1]?.toDouble();
      }
    }
    
    if (lat == null || lng == null) {
      final random = Random();
      // Base Dhaka: 23.8103, 90.4125
      lat = 23.8103 + (random.nextDouble() - 0.5) * 0.1;
      lng = 90.4125 + (random.nextDouble() - 0.5) * 0.1;
    }

    List<String> photos = [];
    if (json["user"]?["profile"]?["portfolio"] != null && json["user"]["profile"]["portfolio"] is List) {
      for (var item in json["user"]["profile"]["portfolio"]) {
        if (item is String) {
          photos.add("${ApiUrl.IMGUrl}$item");
        } else if (item is Map && item["path"] != null) {
          photos.add("${ApiUrl.IMGUrl}${item["path"]}");
        }
      }
    }
    if (photos.isEmpty) photos.add(logo);

    return JobModel(
        id: json["_id"] ?? "",
        title: json["title"] ?? "",
        companyName: json["user"]?["profile"]?["companyName"] ?? "Unknown Company",
        location: json["jobLocation"] ?? "",
        jobType: json["type"] ?? "",
        salary: constructSalary(),
        logoUrl: logo,
        postedTime: json["createdAt"] != null ? DateTime.parse(json["createdAt"]).toString().substring(0, 10) : "",
        workingHours: "Not Specified",
        workSystem: json["engagementType"] ?? "On-site",
        skills: json["experianceLabel"] != null ? [json["experianceLabel"]] : [],
        companyDescription: json["user"]?["profile"]?["companyDescription"] ?? json["description"] ?? "",
        businessPhotos: photos,
        requirements: [],
        benefits: [],
        latitude: lat, 
        longitude: lng,
        recruiterId: json["user"] != null ? (json["user"]["_id"] ?? "") : "",
        distance: json["distance"]?.toDouble(),
    );
  }
}
