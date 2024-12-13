import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishlistsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Wishlist",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Explore Topics Section
            sectionTitle("Explore Topics"),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                topicCard("AutoCAD", "assets/png/AutoCAD-architecture.png"),
                topicCard("AutoCAD Electrical",
                    "assets/png/AutoCAD-architecture.png"),
                topicCard("SolidWorks", "assets/png/AutoCAD-architecture.png"),
                topicCard("Fusion 360", "assets/png/AutoCAD-architecture.png"),
                topicCard("Revit", "assets/icons/revit.svg"),
                topicCard(
                    "AutoCAD Architecture", "assets/icons/autocad_arc.svg"),
                topicCard("GD&T", "assets/icons/gdt.svg"),
                topicCard("AutoCAD Plant 3D", "assets/icons/autocad_p3d.svg"),
              ],
            ),
            SizedBox(height: 24),

            // Explore Collections Section
            sectionTitle("Explore Collections"),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                collectionCard("Certification Prep",
                    "assets/icons/certification_prep.svg"),
                collectionCard("FEA", "assets/icons/fea.svg"),
                collectionCard("Machining", "assets/icons/machining.svg"),
                collectionCard("Structural Engineering",
                    "assets/icons/structural_engineering.svg"),
                collectionCard(
                    "Product Design", "assets/icons/product_design.svg"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Section title widget
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Topic card widget
  Widget topicCard(String title, String iconPath) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            iconPath,
            height: 40,
            color: Colors.pinkAccent,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Collection card widget
  Widget collectionCard(String title, String iconPath) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            iconPath,
            height: 40,
            color: Colors.orangeAccent,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
