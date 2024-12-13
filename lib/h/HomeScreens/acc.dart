import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  var finalName = ""; // Variable to store the username

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Load the username when the screen initializes
  }

  // Method to load the username from SharedPreferences
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      finalName = prefs.getString("username") ??
          "No username found"; // Set the username or a default message
    });
  }

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
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       // Navigation action placeholder
            //     },
            //     // icon: Icon(Icons.abc),
            //   ),
            // ],
            // backgroundColor: Colors.black,
            title: Text(
              'Account',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Image.asset("assets/png/1687 2.png"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        finalName,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 12),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         finalName, // Display the username here
                      //         style:
                      //             TextStyle(color: Colors.black, fontSize: 24),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'Become an Instructor',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 116, 87, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Video Preference',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Download Options',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Video Playback Options',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 15.0),
                //   child: Text(
                //     'Account Settings',
                //     style: TextStyle(color: Colors.grey, fontSize: 14),
                //   ),
                // ),
                // ListTile(
                //   title: Text(
                //     'Account Security',
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_outlined,
                //     color: Colors.grey,
                //   ),
                // ),
                // ListTile(
                //   title: Text(
                //     'Email Notification Preference',
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_outlined,
                //     color: Colors.grey,
                //   ),
                // ),
                // ListTile(
                //   title: Text(
                //     'Learning Reminders',
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_outlined,
                //     color: Colors.grey,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Support',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                ListTile(
                  title: Text(
                    'About SourceCAD',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                  ),
                ),
                // ListTile(
                //   title: Text(
                //     'About Udemy for Business',
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_outlined,
                //     color: Colors.grey,
                //   ),
                // ),
                ListTile(
                  title: Text(
                    'FAQs',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Share the SourceCAD app',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 15.0),
                //   child: Text(
                //     'Diagnostic',
                //     style: TextStyle(color: Colors.grey, fontSize: 14),
                //   ),
                // ),
                // ListTile(
                //   title: Text(
                //     'Status',
                //     style: TextStyle(color: Colors.black, fontSize: 16),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_outlined,
                //     color: Colors.grey,
                //   ),
                // ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: MaterialButton(
                      onPressed: () {
                        Get.to(
                          exit(0),
                        );
                      },
                      child: Text(
                        'Sign out',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 116, 87, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
