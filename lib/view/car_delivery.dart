import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:video_player/video_player.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/car_delivery_controller.dart';
import 'package:vip_delivery_version_1/controller/edit_contract_controller.dart';
import 'package:vip_delivery_version_1/controller/login_controller.dart';
import 'package:vip_delivery_version_1/view/home.dart';
import 'package:vip_delivery_version_1/view/show_vedio.dart';

class CarDelivery extends StatelessWidget {
  CarDelivery({Key? key}) : super(key: key);

  CarDeliveryController carDeliveryController = Get.put(CarDeliveryController());
  EditContractController editContractController = Get.put(EditContractController());


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                  _car_delivery_body(context),
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
                    Get.off(() => Home());
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
            )
          ),
        ),
      ],
    );
  }
  _footer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();

        carDeliveryController.driver_verification_submit(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
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
  _car_delivery_body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        _client_name(context),
        SizedBox(height: 10,),
        _phone_number(context),
        SizedBox(height: 10,),
        _driver_name(context),
        SizedBox(height: 10,),
        _contract_number(context),
        SizedBox(height: 20,),
        _code_emirate_plate(context),
        SizedBox(height: 20,),
        _images_videos(context),
        SizedBox(height:
        carDeliveryController.imgs.isEmpty ||
            carDeliveryController.videos.isEmpty ? 10 : 10
        ),
        carDeliveryController.imgs.isEmpty ? const Center() :
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Text(
                App_Localization.of(context)!.translate("photos"),
                style: TextStyle(
                    color: AppColors.main3,
                    fontSize: 15
                ),),
            ],
          ),
        ),
        SizedBox(height: carDeliveryController.imgs.isEmpty ? 0 : 5),
        carDeliveryController.imgs.isEmpty ? const Center() :
        _add_photo(context),
        const SizedBox(height: 10),
        carDeliveryController.videos.isEmpty ? Center() :
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Text(
                App_Localization.of(context)!.translate("videos"),
                style: TextStyle(
                    color: AppColors.main3,
                    fontSize: 15
                ),),
            ],
          ),
        ),
        SizedBox(height: carDeliveryController.videos.length ==0 ? 0 : 5),
        carDeliveryController.videos.length == 0 ? Center() :
        _add_vedio(context),
        SizedBox(height: 20),
      ],
    );
  }
  _client_name(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.main2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: carDeliveryController.validate.value && carDeliveryController.client_name.text.isEmpty ?
              Colors.red : Colors.transparent
          )
      ),
      child: TextField(
        style: TextStyle(color: AppColors.main3),
        controller: carDeliveryController.client_name,
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
        height: 51,
        decoration: BoxDecoration(
            color: AppColors.main2,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: carDeliveryController.validate.value && carDeliveryController.phone_number.text.isEmpty ?
                Colors.red : Colors.transparent
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              carDeliveryController.phone= number.phoneNumber.toString();
            },
            initialValue: PhoneNumber(isoCode: "AE"),
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            spaceBetweenSelectorAndTextField: 1,
            selectorTextStyle: TextStyle(color: Colors.white),
            textFieldController: carDeliveryController.phone_number,
            cursorColor: AppColors.main3,
            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            inputDecoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.transparent),
              hintText: App_Localization.of(context)!.translate("phone_number"),
              hintStyle: TextStyle(color: AppColors.main3,fontSize: 15),
              enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.main2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.main2),
            ),
          ),
          textStyle: TextStyle(color: AppColors.main3),
          ),
        ),
    );
  }
  _driver_name(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.main2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: !carDeliveryController.driver_validate.value ?
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
        value: carDeliveryController.driverNameValue.value =="non" ? null: carDeliveryController.driverNameValue.value,
        icon: Icon(Icons.arrow_drop_down , size: 25,color: AppColors.main3),
        items: Global.chauffeur.map((newvalue) {
          return DropdownMenuItem(
            value: newvalue.id.toString(),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.all(5),
              child: Text(
                newvalue.title.toString(),
                style: TextStyle(
                    color: AppColors.main3
                ),),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          carDeliveryController.driverNameValue.value = newValue.toString();
          carDeliveryController.driver_validate.value = true;
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
              color: carDeliveryController.validate.value && carDeliveryController.contract_number.text.isEmpty ?
              Colors.red : Colors.transparent
          )
      ),
      child: TextField(
        style: TextStyle(color: AppColors.main3),
        controller: carDeliveryController.contract_number,
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
                FocusManager.instance.primaryFocus?.unfocus();
                _btm_sheet_code(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width *0.28,
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
                    carDeliveryController.emirate[carDeliveryController.select_value.value].link,
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
                      color: carDeliveryController.validate.value && carDeliveryController.plate_number.text.isEmpty ?
                      Colors.red : Colors.black87
                  )
              ),
              child: TextField(
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
                                    carDeliveryController.emirate[index].link,
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
  _images_videos(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              _pick_image(context);
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
            onTap: () async {
              _pick_vedio(context);
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
  _add_photo(BuildContext context){
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView.builder(
          itemCount: carDeliveryController.imgs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: GestureDetector(
                onTap: () {
                  _show_image(context, index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 70,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: FileImage(carDeliveryController.imgs[index].file),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            carDeliveryController.imgs.removeAt(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Icon(Icons.delete,color: AppColors.main,size: 18,),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
  _add_vedio(BuildContext context){
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ListView.builder(
          itemCount: carDeliveryController.videos.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Hero(
                tag: "video_tag_1",
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: (){
                        carDeliveryController.videoPlayerController =
                        VideoPlayerController.file(
                            carDeliveryController.videos[index].file)
                          ..initialize().then((_) {
                            carDeliveryController.chewieController =
                                ChewieController(
                                  videoPlayerController: carDeliveryController.videoPlayerController!,
                                  aspectRatio: 3 / 2,
                                  autoPlay: true,
                                  looping: false,
                                  allowFullScreen: true,
                                  optionsTranslation: OptionsTranslation(
                                    cancelButtonText: App_Localization.of(context)!.translate("close"),

                                  ),
                                  optionsBuilder: (context, defaultOptions) async {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.off(() => CarDelivery());
                                            },
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              color: Colors.white10,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.close,size: 25,color: AppColors.main,),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    App_Localization.of(context)!.translate("close"),
                                                    style: TextStyle(
                                                        color: AppColors.main,
                                                        fontSize: 18
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  materialProgressColors: ChewieProgressColors(
                                    backgroundColor: AppColors.main,
                                    playedColor: Colors.blue,
                                  ),
                                );

                            //    Get.to(()=>ShowVideo(carDeliveryController.videos[index].file,"video_tag_1"));
                          });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Icon(Icons.video_call_outlined,size: 40,color: AppColors.main),
                              ),
                              GestureDetector(
                                onTap: () {
                                  carDeliveryController.videos.removeAt(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Icon(Icons.delete,color: AppColors.main,size: 18,),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
  _show_image(BuildContext context,int index) {
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
            child: Stack(
              children: [
                Container(
                  color: AppColors.main.withOpacity(0.95),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.red,
                            child: Image.file(carDeliveryController.imgs[index].file,fit: BoxFit.cover,)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height - 80,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.arrow_back_ios,
                      color: AppColors.main,
                      size: 25,
                    ),
                  ),
                ),
              ],
            )
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
  _pick_image(BuildContext context) {
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
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  carDeliveryController.get_image_camera();
                                  Get.back();
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
                                      App_Localization.of(context)!.translate("camera"),
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
                                  carDeliveryController.get_image_gallery();
                                  Get.back();
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
                                        App_Localization.of(context)!.translate("gallery"),
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
  _pick_vedio(BuildContext context) {
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
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  carDeliveryController.get_vedio_camera();
                                  Get.back();
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
                                      App_Localization.of(context)!.translate("camera"),
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
                                  carDeliveryController.get_vedio_gallery();
                                  Get.back();
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
                                      App_Localization.of(context)!.translate("gallery"),
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

  bottomSheetImagePositionList(context){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )
        ),
        builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    print(Global.media[index].title);

                    print(carDeliveryController.imgs[0].mediaType.id);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                        child: Text(
                            'The car photo from ' + Global.media[index].title,
                          style: TextStyle(fontSize: 16),
                        )
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }

}
