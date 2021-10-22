import 'dart:core';

import 'package:desafio/features/recipe/data/models/info_model.dart';

class RecipeModel {
  String imagePath = "";
  String name = "";
  List<String> ingredients = List.empty();
  List<String> howCook = List.empty();
  late InfoModel info;

  RecipeModel({
    required this.imagePath,
    required this.name,
    required this.ingredients,
    required this.howCook,
    required this.info,
  });

  RecipeModel.fromJSON(Map<String, dynamic> json) {
    try {
      imagePath = json['imagePath'];
      name = json['name'];
      ingredients = List.from(json['ingredients']);
      howCook = List.from(json['howCook']);
      info = InfoModel.fromJSON(json['info']);
    } catch (error) {
      print(error);
    }
  }
}
