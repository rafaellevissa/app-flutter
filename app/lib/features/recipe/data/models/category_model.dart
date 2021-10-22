import 'dart:convert';
import 'dart:core';

import 'package:desafio/features/recipe/data/models/recipe_model.dart';
import 'package:desafio/helpers/category_model_json.dart';
class CategoryModel {
  String name = "";
  String imagePath = "";
  int id = 0;
  List<RecipeModel> recipes = <RecipeModel>[];

  CategoryModel({
    required this.name,
    required this.id,
    required this.recipes,
    required this.imagePath,
  });

  CategoryModel.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'];
      name = json['name'];
      imagePath = json['imagePath'];

      List< dynamic> offersFromJson = json['recipes'];
      recipes = offersFromJson.map((i) =>
          RecipeModel.fromJSON(i as Map<String, dynamic>),
      ).toList();
    } catch (error) {
      print(error);
    }
  }

  static List<CategoryModel>? getCategoryModelFromJson() {
    List<CategoryModel>? categoryModel = [];
    var mappedJsonAsList = jsonDecode(categoryListModel) as List;
    mappedJsonAsList.forEach((element) {
      try {
        var category = CategoryModel.fromJSON(element as Map<String, dynamic>);
        categoryModel.add(category);
      } catch (error) {
        print(error);
      }
    });

    return categoryModel;
  }


}
