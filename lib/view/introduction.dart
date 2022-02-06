import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/intro_controller.dart';
import 'package:vip_delivery_version_1/view/login.dart';

class Introduction extends StatelessWidget {
  Introduction({Key? key}) : super(key: key);

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColors.main,
            image: DecorationImage(
              image: AssetImage("assets/introduction/introduction.png"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.2,
                child: SvgPicture.asset("assets/icons/logo/logo.svg"),
              ),
              SizedBox(height: 10,),
              _start_btn(context),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  //remove later
  _start_btn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.off(()=> Login());
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        child: Center(
          child: Text(
            App_Localization.of(context)!.translate("start"),
            style: TextStyle(
              fontSize: 18,
              color: AppColors.main
            ),),
        ),
      ),
    );
  }
}
