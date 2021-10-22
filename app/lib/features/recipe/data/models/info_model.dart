import 'dart:core';

class InfoModel {
  String servingTime = "";
  late List<String> nutrictionsFacts;
  late List<String> tags;

  InfoModel({
    required this.servingTime,
    required this.nutrictionsFacts,
    required this.tags,
  });

  InfoModel.fromJSON(Map<String, dynamic> json) {
    try {
      servingTime = json['servingTime'];
      nutrictionsFacts = List.from(json['nutrictionsFacts']);
      tags = List.from(json['tags']);
    } catch (error) {
      print(error);
    }
  }
}
