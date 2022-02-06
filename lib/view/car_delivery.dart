import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:vip_delivery_version_1/const/Global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/car_delivery_controller.dart';

class CarDelivery extends StatelessWidget {
  CarDelivery({Key? key}) : super(key: key);

  CarDeliveryController carDeliveryController = Get.put(CarDeliveryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _body(context),
                _footer(context),
              ],
            ),
          ),
        ),
      ),)
    );
  }

  _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.28,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              image: DecorationImage(
                  image: AssetImage("assets/home/car_receipt.png"),
                  fit: BoxFit.fitWidth
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,),
                ),
                Center(
                  child: Text(
                    App_Localization.of(context)!.translate("car_delivery"),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),),
                ),
                Center()
              ],
            ),
          ),
        ),
      ],
    );
  }
  _footer(BuildContext context) {
    return GestureDetector(
      onTap: () {
       if(carDeliveryController.selected.value == 0) {
         carDeliveryController.client_phone_submit(context);
       }
       else if(carDeliveryController.selected.value == 1) {
         carDeliveryController.plate_number_submit(context);
       }
       else {
         carDeliveryController.contract_number_submit(context);
       }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 45,
        decoration: BoxDecoration(
            color: AppColors.turquoise,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text(
            App_Localization.of(context)!.translate("submit"),
            style: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  carDeliveryController.selected.value = 0;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.main2,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: carDeliveryController.selected.value == 0 ?
                          AppColors.turquoise : Colors.transparent,
                      width: 2
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     SvgPicture.asset("assets/icons/phone.svg",width: 30,height: 30),
                     SizedBox(height: 5),
                     Text(
                        App_Localization.of(context)!.translate("client_phone"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  carDeliveryController.selected.value = 1;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      color: AppColors.main2,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: carDeliveryController.selected.value == 1 ?
                          AppColors.turquoise : Colors.transparent,
                        width: 2
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/plate.svg",width: 30,height: 30),
                      SizedBox(height: 5),
                      Text(
                        App_Localization.of(context)!.translate("plate_number"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  carDeliveryController.selected.value = 2;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      color: AppColors.main2,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: carDeliveryController.selected.value == 2 ?
                          AppColors.turquoise : Colors.transparent,
                        width: 2
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/contract.svg",width: 30,height: 30),
                      SizedBox(height: 5),
                      Text(
                        App_Localization.of(context)!.translate("contract_number"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 12
                        ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 50),
        carDeliveryController.selected.value == 0 ? _client_phone(context) :
         carDeliveryController.selected.value == 1 ?
          _plate_number(context) : _contract_number(context),
        SizedBox(height: 50),
      ],
    );
  }
  _client_phone(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InternationalPhoneNumberInput(
            textAlign: TextAlign.start,
            textFieldController: carDeliveryController.client_phone,
            onInputChanged: (PhoneNumber number) {
             print(number.phoneNumber);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            textStyle: TextStyle(color: AppColors.main3),
            ignoreBlank: true,
            spaceBetweenSelectorAndTextField: 0,
            selectorTextStyle: TextStyle(color: Colors.white),
            initialValue: PhoneNumber(isoCode: "AE"),
            keyboardType: TextInputType.number,
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: AppColors.main2,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                    color: carDeliveryController.client_validate.value &&
                           carDeliveryController.client_phone.text.isEmpty ?
                    Colors.red :Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: carDeliveryController.client_validate.value &&
                        carDeliveryController.client_phone.text.isEmpty ?
                    Colors.red :Colors.transparent
                ),
              ),
              hintText: App_Localization.of(context)!.translate("client_phone"),
              hintStyle: TextStyle(color: AppColors.main3,fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
  _plate_number(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _btm_sheet_code(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.28,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: !carDeliveryController.code_validate.value ?
                        Colors.red : Colors.black87
                    )
                ),
                child: Center(
                  child:
                  Text(
                    Global.language_code == "en" ?
                    carDeliveryController.code[carDeliveryController.codeValue.value] :
                    carDeliveryController.code2[carDeliveryController.codeValue.value],
                    style: TextStyle(
                        fontSize: 15
                    ),),),
              ),
            ),
            GestureDetector(
              onTap: () {
                _btm_sheet_emirate(context);
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Center(
                  child:
                  SvgPicture.asset(
                    carDeliveryController.emirate[carDeliveryController.select_value.value],
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: carDeliveryController.plate_validate.value && carDeliveryController.plate_number.text.isEmpty ?
                      Colors.red : Colors.black87
                  )
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black87),
                controller: carDeliveryController.plate_number,
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5,right: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: App_Localization.of(context)!.translate("plate_number"),
                  hintStyle: TextStyle(color: Colors.black87,fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _btm_sheet_emirate(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context)
      {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
              color: AppColors.main2,
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
                    App_Localization.of(context)!.translate("select_an_emirate"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: carDeliveryController.emirate.length,
                    itemBuilder: (context,index) {
                      return Obx(()=> GestureDetector(
                        onTap: () {
                          carDeliveryController.select_value.value = index;
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(),
                                  SvgPicture.asset(
                                    carDeliveryController.emirate[index],
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: carDeliveryController.select_value.value == index ?
                                    Colors.white : Colors.transparent,size: 20,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.white,
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
  _btm_sheet_code(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context)
      {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
              color: AppColors.main2,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: carDeliveryController.code.length,
                    itemBuilder: (context,index) {
                      return Obx(()=> GestureDetector(
                        onTap: () {
                          carDeliveryController.codeValue.value = index;
                          Get.back();
                          carDeliveryController.code_validate.value = true;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(),
                                  Text(
                                    Global.language_code == "en" ?
                                    carDeliveryController.code[index] :
                                    carDeliveryController.code2[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nawar',
                                        fontSize: 15
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: carDeliveryController.codeValue.value == index ?
                                    Colors.white : Colors.transparent,size: 20,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.white,
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
  _contract_number(BuildContext context) {
    return  Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: AppColors.main2,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: carDeliveryController.contract_validate.value && carDeliveryController.contract_number.text.isEmpty ?
                  Colors.red : Colors.transparent
              )
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: AppColors.main3),
            controller: carDeliveryController.contract_number,
            cursorColor: Colors.white,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintText: App_Localization.of(context)!.translate("contract_number"),
              hintStyle: TextStyle(color: AppColors.main3,fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
