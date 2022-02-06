import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Global {

  static String language_code = "en";

  static Future<String> load_language() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String lang=prefs.getString("language")??'def';
      if(lang!="def") {
        Global.language_code=lang;
      }
      else {
        Global.language_code="en";
      }
      Get.updateLocale(Locale(language_code));
      return Global.language_code;
    }
    catch(e) {
      return "en";
    }
  }

  static set_language(BuildContext context,String lang) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("language", lang);
      //print(lang);
      Global.language_code=lang;
      MyApp.set_locale(context, Locale(lang));
      Get.updateLocale(Locale(lang));
    });
  }

}
