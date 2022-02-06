import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/view/home.dart';
import 'package:whiteboard/whiteboard.dart';

class CartReceiptController extends GetxController {

  TextEditingController client_name = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController contract_number = TextEditingController();
  TextEditingController plate_number = TextEditingController();
  TextEditingController verification_code = TextEditingController();
  TextEditingController client_location = TextEditingController();
  WhiteBoardController whiteBoardController = WhiteBoardController();
  RxString driverNameValue = "non".obs;
  RxList drivers_name = ["Maya0","Maya1","Maya2","Maya3"].obs;
  var codeValue = 0.obs;
  RxList code = ["Select Code","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  RxList code2 = ["اختر رمز","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  var select_value = 0.obs;
  var validate = false.obs;
  var code_validate = true.obs;
  var driver_validate = true.obs;
  var verification_validate = false.obs;
  var choose = false.obs;
  List emirate = [
    "assets/emirate/abu dhabi.svg", "assets/emirate/ajman.svg",
    "assets/emirate/dubai.svg", "assets/emirate/fujairah.svg",
    "assets/emirate/ras al khaimah.svg", "assets/emirate/sharjah.svg",
    "assets/emirate/um al quwain.svg"
  ].obs;

  submit(BuildContext context) {
    if (driverNameValue == "non") {
      driver_validate.value = false;
    } else {
      driver_validate.value = true;
    }
    if (codeValue == 0) {
      code_validate.value = false;
    } else {
      code_validate.value = true;
    }
    if(client_name.text.isEmpty || phone_number.text.isEmpty ||
       contract_number.text.isEmpty  ||
       plate_number.text.isEmpty || driverNameValue.value == false ||
       client_location.text.isEmpty) {
      validate.value = true;
    }
    else {
      validate.value = false;
      driver_verification_code(context);
    }
  }

  driver_verification_code(BuildContext context) {
    return showGeneralDialog(
        context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
          return GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
            color: AppColors.main.withOpacity(0.95),
            child: Dialog(
              backgroundColor: AppColors.main2,
              child: Container(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Text(
                        !choose.value ?
                        App_Localization.of(context)!.translate("driver_verification_code")
                            : App_Localization.of(context)!.translate("please_choose"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),),
                    ),
                    SizedBox(height: 20),
                    !choose.value ?
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: AppColors.main,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: AppColors.main3),
                          controller: verification_code,
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5,right: 5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            hintText: App_Localization.of(context)!.translate("enter_the_code"),
                            hintStyle: TextStyle(color: AppColors.main3,fontSize: 13),
                          ),
                        ),
                      ),
                    ) :
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //todo something
                              TopBar().success_top_bar(
                                  context,App_Localization.of(context)!.translate("uploaded_successfully"));
                              Get.off(() => Home());
                              choose.value = false;
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
                              //todo something
                              TopBar().success_top_bar(
                                  context,App_Localization.of(context)!.translate("saved_successfully"));
                              Get.off(() => Home());
                              choose.value = false;
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
                    !choose.value ?
                    GestureDetector(
                      onTap: () {
                        verification_submit(context);
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.turquoise,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              App_Localization.of(context)!.translate("submit"),
                              style: TextStyle(color: Colors.white,fontSize: 13),),
                          ),
                        ),
                      ),
                    ) : Center(),
                  ],
                ),
              ),
            )
      ),
          );
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

  verification_submit(BuildContext context) {
    if(verification_code.text.isEmpty) {
      verification_validate.value = true;
      TopBar().error_top_bar(
        context,App_Localization.of(context)!.translate("please_enter_the_code"));
    }
    else {
      verification_validate.value = false;
      Get.back();
      choose.value = true;
    }
  }


}