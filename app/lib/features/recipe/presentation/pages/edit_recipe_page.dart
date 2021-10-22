import 'package:desafio/features/recipe/data/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class EditRecipePage extends StatefulWidget {
  RecipeModel recipe;

  EditRecipePage({required RecipeModel recipe}) : recipe = recipe;

  @override
  _EditRecipePageState createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  String dropdownValue = 'Western(5)';
  final _nameRecipe = TextEditingController();

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
    _nameRecipe.text = widget.recipe.name;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            margin: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Column(
              children: [
                _buildButtonBack(),
                _buildHeader(),
                _buildInformation(),
                _buildGallery(),
                _buildIngredients(),
                _buildHowToCook(),
                _buildAdditionalInfo('Info'),
                _buildFooter(),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              'Save to',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          Row(
            children: [
              _buildDropDown(),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shadowColor: Colors.grey,
                    primary: Color(0xFF30BE76),
                    side: BorderSide(
                      width: 2.0,
                      color: Color(0xFF30BE76),
                    ),
                  ),
                  child: const Text('Save Recipe'),
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 50),
      child: Column(
        children: [
          SizedBox(
            height: 55,
            width: double.infinity,
            child: TextButton(
              child: Text(
                'Post to Feed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF30BE76),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(
                  () {},
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.black,
                  ),
                  Text(
                    'Remove from Coockbock',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(String info) {
    return _buildCard(
      'Additional Info',
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView(
          children: <Widget>[
            ListTile(
              minLeadingWidth: 100,
              leading: Text(
                'Serving Time',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              title: Text(widget.recipe.info.servingTime),
            ),
            ListTile(
              minLeadingWidth: 100,
              leading: Text(
                'Nutritition Facts',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              title: Text(
                  widget.recipe.info.nutrictionsFacts.join("\n")),
            ),
            ListTile(
              minLeadingWidth: 100,
              leading: Text(
                'Tags',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              title: Text(widget.recipe.info.tags.join(", ")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToCook() {
    return _buildCard(
      'How to Cook',
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView.builder(
          itemCount: widget.recipe.howCook.length,
          itemBuilder: (context, index) {
            return _buildItemList(index + 1, widget.recipe.howCook[index]);
          },
        ),
      ),
    );
  }

  Widget _buildItemList(int index, String text) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFF30BE76),
            width: 1.5,
          ),
        ),
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Color(0xFF30BE76),
          ),
        ),
      ),
      title: Text(text),
    );
  }

  Widget _buildGallery() {
    return _buildCard(
      'Gallery',
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Image.asset(
              'assets/category_1.jpg',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              height: (MediaQuery.of(context).size.height * 0.2) - 30,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageGallery(),
              SizedBox(width: 10),
              _buildImageGallery(),
              SizedBox(width: 10),
              _buildImageGallery(last: true),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return _buildCard(
      'Ingredients',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            _buildImageIngredient(),
            SizedBox(
              width: 5,
            ),
            _buildImageIngredient(),
            SizedBox(
              width: 5,
            ),
            _buildImageIngredient(),
            SizedBox(
              width: 5,
            ),
            _buildImageIngredient(),
            SizedBox(
              width: 5,
            ),
            _buildImageIngredient(last: true),
          ]),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(widget.recipe.ingredients.join(", ")),
          )
        ],
      ),
    );
  }

  Widget _buildImageIngredient({bool last = false}) {
    return Expanded(
      child: last
          ? Stack(
              fit: StackFit.passthrough,
              children: [
                Opacity(
                  opacity: 0.4,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/login_logo.jpeg',
                      fit: BoxFit.fill,
                      height: 60,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    '5+',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            )
          : ClipOval(
              child: Image.asset(
                'assets/category_5.jpg',
                fit: BoxFit.fill,
                height: 60,
              ),
            ),
    );
  }

  Widget _buildDropDown() {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        height: 50,
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
          items: <String>['Western(5)', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildInformation() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 75,
            width: 75,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: Image.asset(
                'assets/login_logo.jpeg',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _nameRecipe,
                decoration: InputDecoration(
                  // errorText: _validateEmail ? 'Value Can\'t Be Empty' : null,
                  labelText: "Recipe name",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery({bool last = false}) {
    return Expanded(
      child: last
          ? Stack(
              fit: StackFit.passthrough,
              children: [
                Opacity(
                  opacity: 0.4,
                  child: Container(
                    child: Image.asset(
                      'assets/login_logo.jpeg',
                      fit: BoxFit.fitWidth,
                      height: 100,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 40,
                  child: Text(
                    '12+',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            )
          : Container(
              child: Image.asset(
                'assets/category_2.jpg',
                fit: BoxFit.fitWidth,
                height: 100,
              ),
            ),
    );
  }

  Widget _buildCard(String title, Widget children) {
    return Container(
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
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF30BE76),
                ),
              ],
            ),
          ),
          children,
        ],
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Edit Recipe',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
