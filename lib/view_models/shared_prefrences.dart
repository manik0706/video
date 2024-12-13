import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("username") ?? "No username found";
}
