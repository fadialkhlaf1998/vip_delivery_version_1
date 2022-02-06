import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vip_delivery_version_1/const/Global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/car_receipt_controller.dart';
import 'package:whiteboard/whiteboard.dart';

class CartReceipt extends StatelessWidget {
  CartReceipt({Key? key}) : super(key: key);

  CartReceiptController cartReceiptController = Get.put(CartReceiptController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Obx(() => SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.main,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _car_receipt_body(context),
                _footer(context),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ))
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
                  image: AssetImage(!cartReceiptController.choose.value ?
                      "assets/home/car_receipt.png" :
                      "assets/home/signature.png"
                  ),
                  fit: BoxFit.fitWidth
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.16,
            child: !cartReceiptController.choose.value ?
            Row(
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
                    App_Localization.of(context)!.translate("car_receipt"),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),),
                ),
                Center()
              ],
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    App_Localization.of(context)!.translate("signature"),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),),
                ),
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
        cartReceiptController.submit(context);
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
  _car_receipt_body(BuildContext context) {
    return !cartReceiptController.choose.value ?
      Column(
      children: [
        SizedBox(height: 15,),
        _client_name(context),
        SizedBox(height: 10,),
        _phone_number(context),
        SizedBox(height: 10,),
        _driver_name(context),
        SizedBox(height: 10,),
        _contract_number(context),
        SizedBox(height: 10,),
        _client_location(context),
        SizedBox(height: 20,),
        _code_emirate_plate(context),
        SizedBox(height: 30,),
        _images_videos(context),
        SizedBox(height: 30,),
      ],
    ) : _signature_body(context);
  }
  _client_name(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.main2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: cartReceiptController.validate.value && cartReceiptController.client_name.text.isEmpty ?
              Colors.red : Colors.transparent
          )
      ),
      child: TextField(
        style: TextStyle(color: AppColors.main3),
        controller: cartReceiptController.client_name,
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5,right: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: App_Localization.of(context)!.translate("client_name"),
          hintStyle: TextStyle(color: AppColors.main3,fontSize: 15),
        ),
      ),
    );
  }
  _phone_number(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.main2,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: cartReceiptController.validate.value && cartReceiptController.phone_number.text.isEmpty ?
                Colors.red : Colors.transparent
            )

        ),
        child: IntlPhoneField(
          style: TextStyle(color: AppColors.main3),
          controller: cartReceiptController.phone_number,
          textAlign: TextAlign.start,
          dropDownIcon: Icon(Icons.arrow_drop_down,color: AppColors.main3,),
          decoration: InputDecoration(
            counterStyle: TextStyle(color: Colors.transparent),
            contentPadding: EdgeInsets.only(left: 5,right: 5),
            hintText: App_Localization.of(context)!.translate("phone_number"),
            hintStyle: TextStyle(color: AppColors.main3),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.main2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.main2),
            ),
          ),
          initialCountryCode: 'AE',
          countryCodeTextColor: Colors.white,
          showDropdownIcon: true,
          onChanged: (phone) {
            print(phone.countryCode);
          },
        )
    );
  }
  _driver_name(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.main2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: !cartReceiptController.driver_validate.value ?
              Colors.red : Colors.transparent
          )
      ),
      child:  DropdownButton(
        underline: Container(),
        dropdownColor: AppColors.main,
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            App_Localization.of(context)!.translate("driver's_name"),
            style: TextStyle(color: AppColors.main3,fontSize: 15),),
        ),
        value: cartReceiptController.driverNameValue.value =="non" ? null: cartReceiptController.driverNameValue.value,
        icon: Icon(Icons.arrow_drop_down , size: 25,color: AppColors.main3),
        items: cartReceiptController.drivers_name.value.map((newvalue) {
          return DropdownMenuItem(
            value: newvalue,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.all(5),
              child: Text(newvalue,
                style: TextStyle(
                    color: AppColors.main3
                ),),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          cartReceiptController.driverNameValue.value = newValue.toString();
          cartReceiptController.driver_validate.value = true;
        },
      ),
    );
  }
  _contract_number(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.main2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: cartReceiptController.validate.value && cartReceiptController.contract_number.text.isEmpty ?
              Colors.red : Colors.transparent
          )
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(color: AppColors.main3),
        controller: cartReceiptController.contract_number,
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5,right: 5),
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
    );
  }
  _client_location(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.main2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: cartReceiptController.validate.value && cartReceiptController.client_location.text.isEmpty ?
              Colors.red : Colors.transparent
          )
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(color: AppColors.main3),
        controller: cartReceiptController.client_location,
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5,right: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: App_Localization.of(context)!.translate("client_location"),
          hintStyle: TextStyle(color: AppColors.main3,fontSize: 15),
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: AppColors.turquoise,
          )
        ),
      ),
    );
  }
  _code_emirate_plate(BuildContext context) {
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
                width: MediaQuery.of(context).size.width *0.28,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: !cartReceiptController.code_validate.value ?
                        Colors.red : Colors.black87
                    )
                ),
                child: Center(
                  child:
                  Text(
                    Global.language_code == "en" ?
                    cartReceiptController.code[cartReceiptController.codeValue.value] :
                    cartReceiptController.code2[cartReceiptController.codeValue.value],
                    textAlign: TextAlign.center,
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
                width: MediaQuery.of(context).size.width * 0.25,
                height: 40,
                child: Center(
                  child:
                  SvgPicture.asset(
                    cartReceiptController.emirate[cartReceiptController.select_value.value],
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.28,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: cartReceiptController.validate.value && cartReceiptController.plate_number.text.isEmpty ?
                      Colors.red : Colors.black87
                  )
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black87),
                controller: cartReceiptController.plate_number,
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
                    itemCount: cartReceiptController.code.length,
                    itemBuilder: (context,index) {
                      return Obx(()=> GestureDetector(
                        onTap: () {
                          cartReceiptController.codeValue.value = index;
                          Get.back();
                          cartReceiptController.code_validate.value = true;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(),
                                  Text(
                                    Global.language_code == "en" ?
                                        cartReceiptController.code[index] :
                                    cartReceiptController.code2[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nawar',
                                        fontSize: 15
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: cartReceiptController.codeValue.value == index ?
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
                    itemCount: cartReceiptController.emirate.length,
                    itemBuilder: (context,index) {
                      return Obx(()=> GestureDetector(
                        onTap: () {
                          cartReceiptController.select_value.value = index;
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
                                    cartReceiptController.emirate[index],
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: cartReceiptController.select_value.value == index ?
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
  _images_videos(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              //todo something
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: Colors.white,
              strokeWidth: 1,
              dashPattern: [3,3],
              radius: Radius.circular(5),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.11,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined,color: Colors.white, size:34),
                    SizedBox(height: 4),
                    Text(
                      App_Localization.of(context)!.translate("upload_photos"),
                      style: TextStyle(
                          color: AppColors.main3,
                        fontSize: 12
                      ),),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo something
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: Colors.white,
              strokeWidth: 1,
              dashPattern: [3,3],
              radius: Radius.circular(5),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.11,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.videocam_rounded,color: Colors.white,size: 34),
                    SizedBox(height: 4),
                    Text(
                      App_Localization.of(context)!.translate("upload_video"),
                      style: TextStyle(
                          color: AppColors.main3,
                        fontSize: 12
                      ),),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  _signature_body(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.turquoise,width: 2)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14,bottom: 5),
                child: SvgPicture.asset("assets/icons/signature.svg",width: 30,height: 30,),
              ),
              SizedBox(width: 10,),
              Text(
               App_Localization.of(context)!.translate("signature_of_the_client"),
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 18
               ),)
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: AppColors.main2,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              WhiteBoard(
                controller: cartReceiptController.whiteBoardController,
                strokeColor: AppColors.main3,
                backgroundColor: Colors.transparent,
                strokeWidth: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        cartReceiptController.whiteBoardController.clear();
                      },
                      child: Icon(
                        Icons.refresh,
                        color: AppColors.main3,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ),
        SizedBox(height: 20),
      ],
    );
  }
}


