import 'package:hive_flutter/adapters.dart';
import 'package:sourcecad_app/utils/session_key.dart';

class HiveUtils {
  static Box<dynamic>? session;

  static init() async {
    await Hive.initFlutter();
    session = await Hive.openBox<dynamic>('session');
  }

  static addSession(SessionKey key, dynamic value) {
    return session!.put(key.name, value);
  }

  static T getSession<T>(SessionKey key, {T? defaultValue}) {
    return session!.get(key.name, defaultValue: defaultValue);
  }

  static void clear() {
    session!.clear();
  }
}
