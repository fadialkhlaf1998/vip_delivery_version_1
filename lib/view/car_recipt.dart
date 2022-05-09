import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/controller/car_receipt_controller.dart';
import 'package:vip_delivery_version_1/view/edit_contract.dart';


class CartReceipt extends StatelessWidget {
  CartReceipt({Key? key}) : super(key: key);

  CartReceiptController cartReceiptController = Get.put(CartReceiptController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: Obx(() => SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.main,
            child: cartReceiptController.is_loading.value ?
            Center(child: CircularProgressIndicator(color: AppColors.main3,)):
            SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: cartReceiptController.in_progress.isNotEmpty ?
                    Column(
                      children: [
                        _search_history_list(context),
                        SizedBox(height: 30,)
                      ],
                    ) :
                    Column(
                      children: [
                        _body(context),
                        _footer(context),
                      ],
                    )
                  ),
                ],
              ),
            )
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
                    App_Localization.of(context)!.translate("car_receipt"),
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
    return  GestureDetector(
      onTap: () {
        if(cartReceiptController.selected.value == 0) {
          cartReceiptController.phone_submit(context);
        }else if(cartReceiptController.selected.value == 1) {
          cartReceiptController.plate_submit(context);
        }else {
          cartReceiptController.contract_submit(context);
        }
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.turquoise,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child: Text(
                App_Localization.of(context)!.translate("search2"),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
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
                  cartReceiptController.selected.value = 0;
                  cartReceiptController.plate_number.clear();
                  cartReceiptController.contract_number.clear();
                  cartReceiptController.codeValue.value = 0;
                  cartReceiptController.select_value.value = 0;
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      color: AppColors.main2,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: cartReceiptController.selected.value == 0 ?
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
                  cartReceiptController.selected.value = 1;
                  cartReceiptController.client_phone.clear();
                  cartReceiptController.contract_number.clear();

                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      color: AppColors.main2,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: cartReceiptController.selected.value == 1 ?
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
                  cartReceiptController.selected.value = 2;
                  cartReceiptController.client_phone.clear();
                  cartReceiptController.codeValue.value = 0;
                  cartReceiptController.plate_number.clear();
                  cartReceiptController.select_value.value = 0;

                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      color: AppColors.main2,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: cartReceiptController.selected.value == 2 ?
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
        cartReceiptController.selected.value == 0 ? _client_phone(context) :
        cartReceiptController.selected.value == 1 ?
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
            textFieldController: cartReceiptController.client_phone,
            onInputChanged: (PhoneNumber number) {
              cartReceiptController.phone = number.phoneNumber.toString();
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            textStyle: TextStyle(color: AppColors.main3),
            ignoreBlank: true,
            spaceBetweenSelectorAndTextField: 0,
            selectorTextStyle: TextStyle(color: Colors.white),
            initialValue: PhoneNumber(isoCode: "AE"),
            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: AppColors.main2,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                    color: cartReceiptController.client_validate.value &&
                        cartReceiptController.client_phone.text.isEmpty ?
                    Colors.red :Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.transparent
                    // color: cartReceiptController.client_validate.value &&
                    //     cartReceiptController.client_phone.text.isEmpty ?
                    // Colors.red :Colors.transparent
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
                    cartReceiptController.emirate[cartReceiptController.select_value.value].link,
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
                      color: cartReceiptController.plate_validate.value && cartReceiptController.plate_number.text.isEmpty ?
                      Colors.red : Colors.black87
                  )
              ),
              child: TextField(
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
                    physics: const NeverScrollableScrollPhysics(),
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
                                    cartReceiptController.emirate[index].link,
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
                              color: Colors.transparent,
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
  _contract_number(BuildContext context) {
    return  Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: AppColors.main2,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: cartReceiptController.contract_validate.value && cartReceiptController.contract_number.text.isEmpty ?
                  Colors.red : Colors.transparent
              )
          ),
          child: TextField(
            style: TextStyle(color: AppColors.main3),
            controller: cartReceiptController.contract_number,
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
  _search_history_list(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        _in_progress(context)
      ],
    );
  }
  _in_progress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
            ),
            itemCount: cartReceiptController.in_progress.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: (){
                    cartReceiptController.is_loading.value = true;
                    // API.get_contract_image(cartReceiptController.in_progress[index].id.toString()).then((images) {
                    //
                    // });
                    Get.to(() => EditContract(cartReceiptController.in_progress[index]))!.then((value) {
                      cartReceiptController.is_loading.value = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: 2,
                            color:AppColors.yellow
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12,left: 12,right: 12,bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              cartReceiptController.in_progress[index].clientPhone,
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: 18),),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(DateTime.parse(cartReceiptController.in_progress[index].deliverDate.toString())),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18),),
                          Text(
                            cartReceiptController.in_progress[index].contractNumber,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.turquoise,
                                fontSize: 20),),
                          Container(
                            child: Divider(
                                thickness: 2,
                                height: 15,
                                color: AppColors.yellow
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 15,
                                height:  15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.yellow
                                ),
                              ),
                              Text(
                                App_Localization.of(context)!.translate("in_progress"),
                                style: TextStyle(
                                    color: AppColors.yellow,
                                    fontSize: 13
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5)
                        ],
                      ),
                    ),
                  )
              );
            }),
      ),
    );
  }

}