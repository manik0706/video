import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sourcecad_app/h/HomeScreens/categorieslist.dart';
import 'package:sourcecad_app/h/HomeScreens/explainsection.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({Key? key}) : super(key: key);

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop(); // Exits the app and takes user to home screen
          return false; // Prevents the default back behavior
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: const [
                Text(
                  'All Courses',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                  ))
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ExplainSection(
                      title: 'What will you learn first?',
                      desc: 'Your courses will go here.'),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Browse Categories',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  CategoriesList(),
                  Padding(padding: EdgeInsets.all(30))
                ],
              ),
            ),
          ),
        ));
  }
}
