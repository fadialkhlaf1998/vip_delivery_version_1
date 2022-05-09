import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/controller/car_delivery_controller.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:vip_delivery_version_1/controller/new_api.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';
import 'package:vip_delivery_version_1/view/car_delivery.dart';
import 'package:vip_delivery_version_1/view/home.dart';
import 'package:vip_delivery_version_1/view/no_internet.dart';
import 'package:whiteboard/whiteboard.dart';

class SignatureController extends GetxController {

  WhiteBoardController whiteBoardController = WhiteBoardController();
  CarDeliveryController carDeliveryController = Get.find();
  HistoryController historyController = Get.find();

  bool driverSignatureCheck = false;
  bool clientSignatureCheck = false;
  int mediaLength = 0;
  int length = 0;

  File? driver;
  File? client;
  var is_driver = true.obs;
  var is_loading = false.obs;
  var success = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    driver=null;
    client=null;
    is_driver.value = true;
    is_loading = false.obs;
    success = false.obs;
  }

  @override
  void dispose() {
   // print('*******DELETE**********');
    Get.delete<SignatureController>();
    super.dispose();
  }

  signature_submit(BuildContext context) {
    if(client!=null && driver!=null){
      choose_upload_type(context);
    }else{
      whiteBoardController.convertToImage();
      whiteBoardController.clear();
    }
  }
  choose_upload_type(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return Obx(() => GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            color: AppColors.main.withOpacity(0.95),
            child: !is_loading.value ?
            Dialog(
              backgroundColor: AppColors.main2,
              child: Container(
                  height: 200,
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Text(
                          App_Localization.of(context)!.translate("please_choose"),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15
                          ),),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // clear_textfields();
                                //TODO
                                /** Upload now Function */
                                upload_now_button(context);
                                this.dispose();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.main,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    App_Localization.of(context)!.translate("upload_now"),
                                    style: TextStyle(
                                        color: AppColors.main3,
                                        fontSize: 15
                                    ),),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                //clear_textfields();
                                upload_save_latter_button(context);
                                this.dispose();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.main,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(
                                    App_Localization.of(context)!.translate("save_and_upload_later"),
                                    style: TextStyle(
                                        color: AppColors.main3,
                                        fontSize: 15
                                    ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  )
              ),
            ) :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator(color: AppColors.main3,)),
                )
              ],
            ),
          ),
        ));
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
  upload_now_button(BuildContext context) async {

      if(Global.offline_contract.last.clientPhone.length < 10){
        is_loading.value = true;
        TopBar().error_top_bar(context,
            App_Localization.of(context)!.translate("check_phone"));
        Global.offline_contract.removeLast();
        Get.back();
        Get.back();
      }else{
        try{
          is_loading.value = true;
          NewApi.internet().then((internet) {
            if(internet){
              NewApi.upload_offLine_history(Global.offline_contract.last).then((value) {
                if(value){
                  is_loading.value = true;
                  success.value = true;
                  TopBar().success_top_bar(
                      context,App_Localization.of(context)!.translate("uploaded_successfully"));
                  clear_textfields();
                  historyController.getHistory();
                  Get.offAll(() => Home());
                } else {
                  is_loading.value = true;
                  TopBar().error_top_bar(
                      context,App_Localization.of(context)!.translate("upload_failed"));
                  Get.offAll(() => Home());
                }
              });
            }else {
              Get.to(() => NoInternet())!.then((value) {
                // upload_now_button(context);
              });
            }
          });
        }catch(e){
          TopBar().error_top_bar(
              context,"error");
        }
      }

  }
  upload_save_latter_button(BuildContext context) async {
    if(Global.offline_contract.last.clientPhone.length<10){
      is_loading.value = true;
      TopBar().error_top_bar(context,
          App_Localization.of(context)!.translate("check_phone"));
      Global.offline_contract.removeLast();
       Get.back();
       Get.back();
      //Get.offAll(()=> CarDelivery());
    }else {
      try{
        is_loading.value = true;
        Global.save_offline_contract();
        success.value = true;
        TopBar().success_top_bar(context, App_Localization.of(context)!.translate("saved_successfully"));
        clear_textfields();
        Get.offAll(() => Home());
      }
      catch(e) {
        TopBar().error_top_bar(
            context,"error");
        print(e);
      }
    }
  }
  clear_textfields() {
    carDeliveryController.client_name.clear();
    carDeliveryController.phone_number.clear();
    carDeliveryController.driverNameValue = "non".obs;
    carDeliveryController.contract_number.clear();
    carDeliveryController.codeValue = 0.obs;
    carDeliveryController.plate_number.clear();
    carDeliveryController.verification_code.clear();
    carDeliveryController.imgs.clear();
    carDeliveryController.videos.clear();
  }

}