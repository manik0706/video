import 'package:flutter/material.dart';
import 'package:sourcecad_app/h/HomeScreens/categorieslist.dart';
import 'package:sourcecad_app/h/HomeScreens/circlebutton.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),
                ],
              ),
              onPressed: () {},
            )),
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
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Top searches',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: const [
                  CircleButton(text: 'autoCAD'),
                  CircleButton(text: 'solidWorks'),
                  CircleButton(text: 'fusion 360'),
                  CircleButton(text: 'revit'),
                  CircleButton(text: 'dynamo'),
                  CircleButton(text: '3D printing'),
                  CircleButton(text: 'sketchup'),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Browse categories',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const CategoriesList(),
            ],
          ),
        ),
      ),
    );
  }
}
