import 'dart:async';

import 'package:desafio/features/authentication/presentation/pages/login_page.dart';
import 'package:desafio/features/recipe/data/models/category_model.dart';
import 'package:desafio/features/recipe/presentation/pages/recipe_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late User user;
  late List<CategoryModel> listCategoryModel;

  late TabController _tabController;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    super.initState();
    listCategoryModel = CategoryModel.getCategoryModelFromJson()!;
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Column(
            children: [
              _buildHeader(),
              _buildUserInformation(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade400, width: 0.5),
                  ),
                ),
              ),
              DefaultTabController(
                length: 3,
                child: Container(
                  child: Column(
                    children: [
                      _buildTabs(),
                      _buildTabContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/nav_1.png"),
                  color: Colors.black,
                  size: 35,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/nav_2.png"),
                  color: Colors.black,
                  size: 35,
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/nav_3.png"),
                  color: Color(0xFF30BE76),
                  size: 35,
                ),
                label: 'School',
              ),
            ],
            currentIndex: 2,
            selectedItemColor: Colors.amber[800],
            onTap: (value) {},
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.7, color: Colors.grey.shade400),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 26),
      height: 50,
      child: TabBar(
        onTap: (value) => print(null),
        labelPadding: EdgeInsets.zero,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        tabs: [
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listCategoryModel.length.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Text('Recipes', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '75',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Saved',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '248',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Following',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: Row(children: [
        Expanded(
          child: Text(
            'My Kitchen',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Icon(
          Icons.settings_outlined,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            _signOut(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: Text('Settings'),
          ),
        ),
      ]),
    );
  }

  Widget _buildUserInformation() {
    print(user);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: user.photoURL != null
                  ? CachedNetworkImageProvider(user.photoURL as String)
                      as ImageProvider
                  : AssetImage("assets/avatar_picture.png"),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName != null
                      ? user.displayName as String
                      : 'Nick Evans',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Potato Master',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '584 followers',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 18, right: 18),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                    Text(
                      '23k likes',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Icon(Icons.edit_outlined, color: Colors.black),
          )
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildTabContent() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: (size.height * 0.5) - 60,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildSupportTab(),
          _buildSupportTab(),
          _buildSupportTab(),
        ],
      ),
    );
  }

  Widget _buildSupportTab() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                children: _generateChildren(6),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _generateItem(double width, double height, CategoryModel category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipePage(
              recipes: category.recipes,
            ),
          ),
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 25,
        height: 140,
        padding: EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
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
                  child: Image.asset(category.imagePath,
                      width: double.infinity, fit: BoxFit.fill),
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
                height: 30,
                child: Center(
                  child: Text(
                    category.name,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _generateChildren(int count) {
    List<Widget> items = [];

    for (int i = 0; i < listCategoryModel.length; i++) {
      items.add(_generateItem(90, 75, listCategoryModel[i]));
    }

    return items;
  }
}
