import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noahrealstate/app/data/model/data_model.dart';

class CacheHelper {
  static const String _propertyKey = 'cached_properties';
  static const String _contactAddedKey = 'contact_added';


  static Future<void> cacheProperties(List<Property> properties) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = properties.map((property) => property.toJson()).toList();
    prefs.setString(_propertyKey, jsonEncode(jsonData));
  }

  static Future<List<Property>?> getCachedProperties() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_propertyKey);
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString) as List;
      return jsonData.map((json) => Property.fromJson(json)).toList();
    }
    return null;
  }

  static Future<void> addContacts(bool added) async {
     final prefs = await SharedPreferences.getInstance();
     prefs.setBool(_contactAddedKey, added);
  }
  static Future<bool> getAddContacts() async {
     final prefs = await SharedPreferences.getInstance();
   return  prefs.getBool(_contactAddedKey)??false;
  }
}
