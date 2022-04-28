import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:vip_delivery_version_1/controller/new_api.dart';
import 'package:vip_delivery_version_1/view/home.dart';

class LoginController extends GetxController {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var validate = false.obs;
  var isHidden = true.obs;
  var is_loading = false.obs;

  visible_password() {
    isHidden.value = !isHidden.value;
  }

  login(BuildContext context) {
    if(email.text.isEmpty || password.text.isEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(email.text) ||
        password.text.length < 6)
    {
      validate.value = true;
    }
    else {
      validate.value = false;
      is_loading.value = true;
      Get.offAll(()=>Home());
    }
  }

  newLogin(BuildContext context){
    is_loading.value = true;
    NewApi.login(email.text, password.text).then((value){
      if(value){
        //is_loading.value = true;
        NewApi.getChauffeur().then((value) {
          Global.chauffeur.addAll(value);
          NewApi.getMedia().then((signatures) {
            Global.media.addAll(signatures);
            Global.saveLoginInfo(email.text, password.text);
            is_loading.value = false;
            Get.offAll(()=>Home());
          });
        });

      }else{
        print('Field');
        is_loading.value = false;
        TopBar().error_top_bar(context,
            App_Localization.of(context)!.translate("wrong_email_password"));
      }
    });
  }

}