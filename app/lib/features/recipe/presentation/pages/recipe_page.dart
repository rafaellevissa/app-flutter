import 'dart:async';

import 'package:desafio/features/authentication/presentation/pages/login_page.dart';
import 'package:desafio/features/recipe/data/models/recipe_model.dart';
import 'package:desafio/features/recipe/presentation/pages/edit_recipe_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipePage extends StatefulWidget {
  List<RecipeModel> recipes = [];

  RecipePage({required List<RecipeModel> recipes}) : recipes = recipes;

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String dropdownValue = 'Western(5)';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Column(
            children: [
              _buildButtonBack(),
              _buildHeader(),
              _buildDropDown(size),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropDown(Size size) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 15, right: 10),
      width: size.width,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.grey,
        ),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontSize: 15),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Western(5)']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 1.0, right: 1.0),
        scrollDirection: Axis.vertical,
        itemCount: widget.recipes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                _buildCard(index),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditRecipePage(
              recipe: widget.recipes[index],
            ),
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  widget.recipes[index].imagePath,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              padding: EdgeInsets.all(15),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipes[index].name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(widget.recipes[index].info.servingTime),
                      Container(
                        margin: EdgeInsets.only(left: 18, right: 18),
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                      ),
                      Text(widget.recipes[index].ingredients.length.toString() +
                          ' ingredients'),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xFF30BE76),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_arrow_outlined,
                              color: Color(0xFF30BE76),
                            ),
                            Text(
                              'Cook',
                              style: TextStyle(
                                color: Color(0xFF30BE76),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBack() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          Container(
            child: Text(
              'Back to My Profile',
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(children: [
        Expanded(
          child: Text(
            'My Recipes',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Icon(
          Icons.add_sharp,
          color: Color(0xFF30BE76),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              'Add New',
              style: TextStyle(
                color: Color(0xFF30BE76),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
