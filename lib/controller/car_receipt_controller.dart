import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/controller/intro_controller.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/model/plate.dart';

class CartReceiptController extends GetxController {

  IntroController introController = Get.find();
  TextEditingController client_phone = TextEditingController();
  TextEditingController plate_number = TextEditingController();
  TextEditingController contract_number = TextEditingController();
  List<History> history = <History>[];
  List<History> in_progress = <History>[];
  var selected = 0.obs;
  var client_validate = false.obs;
  var plate_validate = false.obs;
  var code_validate = true.obs;
  var contract_validate = false.obs;
  String phone = "non";
  var codeValue = 0.obs;
  var codeValue2 = "A".obs;
  RxList code = ["Select Code","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  RxList code2 = ["اختر رمز","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  var select_value = 0.obs;
  List <Plate> emirate = [
    Plate("assets/emirate/abu_dhabi.svg","ABU DHABI"),
    Plate("assets/emirate/ajman.svg","AJMAN"),
    Plate("assets/emirate/dubai.svg","DUBAI"),
    Plate("assets/emirate/fujairah.svg","FUJAIRAH"),
    Plate("assets/emirate/ras_al_khaimah.svg","RAS AL KHAIMAH"),
    Plate("assets/emirate/sharjah.svg","SHARJAH"),
    Plate("assets/emirate/um_al_quwain.svg","UMM AL QUWAIN"),
  ].obs;
  var is_loading = false.obs;

  phone_submit(BuildContext context) {
    if(client_phone.text.isEmpty) {
      client_validate.value = true;
    }
    else {
      client_validate.value = false;
      submit_button(context);
    }
  }
  plate_submit(BuildContext context) {
    if (codeValue == 0) {
      code_validate.value = false;
    } else {
      code_validate.value = true;
    }
    if (plate_number.text.isEmpty || code_validate.value == false) {
      plate_validate.value = true;
    }
    else {
      plate_validate.value = false;
      submit_button(context);
    }
  }
  contract_submit(BuildContext context) {
    if(contract_number.text.isEmpty) {
      contract_validate.value = true;
    }
    else {
      contract_validate.value = false;
      submit_button(context);
    }
  }
  submit_button(BuildContext context) {
    is_loading.value = true;
    API.get_history(
        selected == 0 ? phone : selected == 1 ? code[codeValue.value] + " | " + emirate[select_value.value].id + " | " + plate_number.text : contract_number.text)
        .then((value) {
      if (value.length == 0) {
        is_loading.value = false;
        TopBar().error_top_bar(context,
          App_Localization.of(context)!.translate("data_not_correct"));
      }else {
        if(value.first.status != "Received") {
          history.addAll(value);
          is_loading.value = false;
          in_progress = history.where((i) => i.status!="Received").toList();
        }else {
          TopBar().error_top_bar(context,
                App_Localization.of(context)!.translate("car_received_recently"));
            is_loading.value = false;
        }
      }
    });
  }
  clear_textfields() {
    client_phone.clear();
    plate_number.clear();
    contract_number.clear();
    in_progress.clear();
    history.clear();
    is_loading.value = false;
    selected.value = 0;
    codeValue.value = 0;
    select_value.value = 0;
  }
}