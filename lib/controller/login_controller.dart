import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/view/home.dart';

class LoginController extends GetxController {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var validate = false.obs;
  var isHidden = true.obs;

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
      Get.offAll(()=>Home());
    }
  }
}