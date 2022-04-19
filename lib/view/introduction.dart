import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/intro_controller.dart';

class Introduction extends StatefulWidget {
  Introduction({Key? key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {

  IntroController introController = Get.put(IntroController());

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.2,
                child: SvgPicture.asset("assets/icons/logo/logo.svg"),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  App_Localization.of(context)!.translate("welcome"),
                  style: TextStyle(
                    color: AppColors.main3,
                    fontSize: 30
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
