import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vip_delivery_version_1/model/chauffer.dart';
import 'package:vip_delivery_version_1/model/mediatype.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';
import '../main.dart';

class Global {

  static String language_code = "en";
  static List<Chauffeur> chauffeur = <Chauffeur>[];
  static List<Media> media = <Media>[];
  static List<Media> video = <Media>[];
  static List<Media> signature = <Media>[];
  static List<OfflineHistory> offline_contract= <OfflineHistory>[];

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
  static Media get_media_type(String id){
    if(id=="v"){
      return video.first;
    }
    for(int i=0;i<media.length;i++){
      if(id==media[i].id.toString()){
        return media[i];
      }
    }
    for(int i=0;i<signature.length;i++){
      if(id==signature[i].id.toString()){
        return signature[i];
      }
    }
    for(int i=0;i<video.length;i++){
      if(id==video[i].id.toString()){
        return video[i];
      }
    }
    return media.first;
  }
  static String get_driver_name_by_id(String id){
    for(int i=0;i<chauffeur.length;i++){
      if(chauffeur[i].id.toString()==id){
        return chauffeur[i].name;
      }
    }
    return "none";
  }
  static String get_driver_pin_by_id(String id){
    for(int i=0;i<chauffeur.length;i++){
      if(chauffeur[i].id.toString()==id){
        return chauffeur[i].pinCode;
      }
    }
    return "error";
  }
  static int get_media_type_by_name(String name){
    for(int i=0;i<media.length;i++){
      if(media[i].title.toString().contains(name)){
        return media[i].id;
      }
    }
    for(int i=0;i<signature.length;i++){
      if(signature[i].title.toString().contains(name)){
        return signature[i].id;
      }
    }
    for(int i=0;i<video.length;i++){
      if(video[i].title.toString().contains(name)){
        return video[i].id;
      }
    }
    return -1;
  }
  static Future load_offline_contract() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String result = prefs.getString("offline_contract")??'def';
      offline_contract = List<OfflineHistory>.from(json.decode(result).map((x) => OfflineHistory.fromMap(x)));
    }
    catch(e) {
      return e;
    }
  }
  static save_offline_contract(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("offline_contract", json.encode(List<dynamic>.from(Global.offline_contract.map((x) => x.toMap()))));
    });
  }

}
