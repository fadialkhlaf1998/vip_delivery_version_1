import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/controller/intro_controller.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/view/contract.dart';
import 'package:vip_delivery_version_1/view/no_internet.dart';

class HistoryController extends GetxController {

  var select_history = 0.obs;
  TextEditingController search = TextEditingController();
  IntroController introController = Get.find();

  get_contract_images(History history){
    API.internet().then((internet) {
      if(internet){
        introController.is_loading.value = true;
        API.get_contract_image(history.id.toString()).then((value) {
          Get.to(() => Contract(history,value));
          introController.is_loading.value = false;
        });
      } else {
        Get.to(()=> NoInternet())!.then((value) {
          get_contract_images(history);
        });
      }
    });
  }

}