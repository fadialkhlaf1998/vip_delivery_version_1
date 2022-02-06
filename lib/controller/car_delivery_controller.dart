import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/view/home.dart';

class CarDeliveryController extends GetxController {

  TextEditingController client_phone = TextEditingController();
  TextEditingController plate_number = TextEditingController();
  TextEditingController contract_number = TextEditingController();
  var selected = 0.obs;
  var client_validate = false.obs;
  var plate_validate = false.obs;
  var code_validate = true.obs;
  var contract_validate = false.obs;
  var codeValue = 0.obs;
  RxList code = ["Select Code","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  RxList code2 = ["اختر رمز","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  var select_value = 0.obs;
  List emirate = [
    "assets/emirate/abu dhabi.svg",
    "assets/emirate/ajman.svg",
    "assets/emirate/dubai.svg",
    "assets/emirate/fujairah.svg",
    "assets/emirate/ras al khaimah.svg",
    "assets/emirate/sharjah.svg",
    "assets/emirate/um al quwain.svg"
  ].obs;

  client_phone_submit(BuildContext context) {
    if(client_phone.text.isEmpty) {
      client_validate.value = true;
    }
    else {
      client_validate.value = false;
      TopBar().success_top_bar(context,
        App_Localization.of(context)!.translate("car_delivered_successfully"));
      Get.off(() => Home());
    }
  }

  plate_number_submit(BuildContext context) {
    if (codeValue == 0) {
      code_validate.value = false;
    } else {
      code_validate.value = true;
    }
    if(plate_number.text.isEmpty || code_validate.value ==false) {
      plate_validate.value = true;
    }
    else {
      plate_validate.value = false;
      TopBar().success_top_bar(context,
          App_Localization.of(context)!.translate("car_delivered_successfully"));
      Get.off(() => Home());
    }
  }

  contract_number_submit(BuildContext context) {
    if(contract_number.text.isEmpty) {
      contract_validate.value = true;
    }
    else {
      contract_validate.value = false;
      TopBar().success_top_bar(context,
          App_Localization.of(context)!.translate("car_delivered_successfully"));
      Get.off(() => Home());
    }
  }
}