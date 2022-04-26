import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {



  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  var select_nav_bar = 1.obs;
  var select_value = 0.obs;
  String? value = "non";
  List languages = [
    {
      "name":"English",
      "id":"en"},
    {
      "name":"Arabic",
      "id":"ar"}
  ].obs;
}