import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/login_controller.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: AppColors.main,
              image: DecorationImage(
                  image: AssetImage("assets/login/login.png"),
                  fit: BoxFit.cover
              )
          ),
          child: SingleChildScrollView(
            child: !loginController.is_loading.value ?
            Column(
              children: [
                SizedBox(height: 80),
                _header(context),
                SizedBox(height: 50),
                _body(context),
                SizedBox(height: 50),
                _login_btn(context),
              ],
            ) :
            Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.main3,),
              ),
            ),
          ),
        ),
      )),
      floatingActionButton:
      GestureDetector(
          onTap: () {
            //todo something
          },
          child: SvgPicture.asset("assets/icons/info.svg",width: 23, height: 23,))
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.2,
      child: SvgPicture.asset("assets/icons/logo/logo.svg"),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: loginController.email,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              loginController.validate.value &&
                  (loginController.email.text.isEmpty ||
                      !RegExp(r'\S+@\S+\.\S+').hasMatch(loginController.email.text)) ?
              App_Localization.of(context)!.translate("email_is_required") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.main3),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.main3),
              ),
              hintText:  App_Localization.of(context)!.translate("email"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: loginController.password,
            obscureText: loginController.isHidden.value,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              errorText:
              loginController.validate.value &&
                  (loginController.password.text.isEmpty ||
                      loginController.password.text.length < 6) ?
              App_Localization.of(context)!.translate("must_be_at_least_6_character") : null,
              errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.main3),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.main3),
              ),
              hintText: App_Localization.of(context)!.translate("password"),
              hintStyle: TextStyle(color: Colors.white,fontSize: 15),
              suffixIcon: InkWell(
                onTap: loginController.visible_password,
                child: Icon(
                  loginController.isHidden.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  _login_btn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        loginController.login(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        color: Colors.white,
        child: Center(
          child: Text(App_Localization.of(context)!.translate("log_in"),
            style: TextStyle(
              color: AppColors.main,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }

}
