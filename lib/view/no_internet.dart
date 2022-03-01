import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/view/login.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: Column(
            children: [
              SizedBox(height: 100),
              Icon(Icons.wifi_off,size: 130,color: AppColors.main3,),
              SizedBox(height: 10),
              Text(
                App_Localization.of(context)!.translate("no_internet"),
                style: TextStyle(
                    color: AppColors.main3,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  API.internet().then((internet) {
                    if(internet) {
                      Get.off(() => Login());
                    }
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.main3,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text(
                      App_Localization.of(context)!.translate("reload"),
                      style: TextStyle(
                          color: AppColors.main,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
