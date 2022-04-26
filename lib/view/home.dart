import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/car_receipt_controller.dart';
import 'package:vip_delivery_version_1/controller/edit_contract_controller.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:vip_delivery_version_1/controller/home_controller.dart';
import 'package:vip_delivery_version_1/controller/intro_controller.dart';
import 'package:vip_delivery_version_1/view/car_delivery.dart';
import 'package:vip_delivery_version_1/view/car_recipt.dart';
import 'package:vip_delivery_version_1/view/history.dart';
import 'package:vip_delivery_version_1/view/login.dart';

class Home extends StatelessWidget {
  Home () {
    if(Global.language_code == "en") {
      homeController.select_value.value = 0; }
    else {
      homeController.select_value.value = 1; }
  }

  HomeController homeController = Get.put(HomeController());
  IntroController introController = Get.find();
  CartReceiptController cartReceiptController = Get.put(CartReceiptController());
  EditContractController editContractController = Get.put(EditContractController());
  HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.main,
       body: SafeArea(
         child: Obx(() {
           return  Stack(
             children: [
               Container(width: MediaQuery.of(context).size.width,),
               Obx(() {
                 return homeController.select_nav_bar.value == 0 ? HistoryView() :
                 homeController.select_nav_bar.value == 1 ?  _home(context) : Center();
               }),
               Positioned(bottom: 0,child: _btnNavBar(context)),
               homeController.select_nav_bar.value == 1 ?  Positioned(
                 top: 0,
                 child: Container(
                   child: IconButton(
                     onPressed: ()async{
                       await Global.logout();
                       Get.offAll(()=>Login());
                     },
                     icon: Icon(Icons.logout, color: Colors.white,),
                   ),
                 ),
               ) : Center(),
             ],
           );
         })
       ),
    );
  }

  _btnNavBar(BuildContext context) {
    return Obx(() => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.main2,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  homeController.select_nav_bar.value = 0;
                  introController.temp.clear();
                  introController.histories.addAll(introController.temp);
                  historyController.search.clear();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/history.svg",width: 18,height: 18,
                        color: homeController.select_nav_bar.value == 0 ?
                        AppColors.turquoise : Colors.white),
                    Text(
                      App_Localization.of(context)!.translate("history"),
                      style: TextStyle(
                        color: homeController.select_nav_bar.value == 0 ?
                        AppColors.turquoise : Colors.white,
                          fontSize: 12
                    ),)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _btm_sheet_languages(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.translate_outlined,size: 20,color: Colors.white,),
                    Text(
                      App_Localization.of(context)!.translate("languages"),
                      style: TextStyle(
                        color: homeController.select_nav_bar.value == 2 ?
                        AppColors.turquoise : Colors.white,
                        fontSize: 13
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            homeController.select_nav_bar.value = 1;
          },
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
                color: AppColors.main2,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.main3,width: 1),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      offset: Offset(0, 2.8),
                      color: Colors.black38,
                    spreadRadius: 0.1,
                  )
                ]
                // border: Border.all(color: Colors.white)
            ),

            child: Icon(Icons.home_outlined,size: 25,
                color: homeController.select_nav_bar.value == 1 ?
                AppColors.turquoise : Colors.white,),
          ),
        ),

      ],
    ));
  }
  _home(BuildContext context) {
    return SafeArea(
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
          child: Column(
            children: [
              SizedBox(height: 80),
              _header(context),
              SizedBox(height: 50),
              _body(context)
            ],
          ),
        ),
      ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => CartReceipt());
            cartReceiptController.clear_textfields();
            editContractController.clear();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: AppColors.violet,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/picking/car-receipt.svg"),
                    ),
                  ),
                  Text(
                    App_Localization.of(context)!.translate("car_receipt"),
                    style: TextStyle(color: Colors.white,fontSize: 25),),
                  Center()
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: () {
            Get.to(()=> CarDelivery());
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: AppColors.turquoise,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset("assets/picking/car-delivery.svg"),
                    ),
                  ),
                  SizedBox(width: 2,),
                  Text(
                    App_Localization.of(context)!.translate("car_delivery"),
                    style: TextStyle(color: Colors.white,fontSize: 25),),
                  Center()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  _btm_sheet_languages(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context)
      {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
              color: AppColors.main,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Center(
                  child: Text(
                    App_Localization.of(context)!.translate("languages"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: homeController.languages.length,
                    itemBuilder: (context,index) {
                      return Obx(()=> GestureDetector(
                        onTap: () {
                          Global.set_language(context, homeController.languages[index]['id']);
                          homeController.select_value.value = index;
                          if(homeController.languages[index]['id'] == "en" ) {
                            homeController.value = homeController.languages[index]["name"];
                          }
                          else {
                            homeController.value = homeController.languages[index]["name"];
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              color: AppColors.main,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    homeController.languages[index]['id'] == "en"?
                                    App_Localization.of(context)!.translate("english") :
                                    App_Localization.of(context)!.translate("arabic"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: homeController.select_value.value == index ?
                                    Colors.white : Colors.transparent,size: 25,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.main3,
                              thickness: 1,
                            )
                          ],
                        ),
                      ));
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
