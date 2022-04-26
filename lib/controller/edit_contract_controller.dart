import 'dart:io';
import 'dart:ui' as ui;
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/model/image_type.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';
import 'package:vip_delivery_version_1/view/signature.dart';

class EditContractController extends GetxController {

  String media_url='https://phplaravel-548447-2195842.cloudwaysapps.com/storage/images/';
  TextEditingController verification_code = TextEditingController();
  List<ImageType> imgs=<ImageType>[].obs;
  List<ImageType> vedios=<ImageType>[].obs;
  ImagePicker image_picker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController ;
  var driver_validate = true.obs;
  var verification_validate = false.obs;
  RxString driverNameValue = "non".obs;
  var is_play = false.obs;

  driver_verification_code(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return WillPopScope(
          onWillPop: ()async{
            driverNameValue.value = "non";
            return true;
          },
          child: GestureDetector(
            onTap: () {
             driverNameValue.value = "non";
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
                            App_Localization.of(context)!.translate("driver_verification_code"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),),
                        ),
                        SizedBox(height: 20),
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
                        ),
                        SizedBox(height: 15),
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
                        )
                      ],
                    ),
                  ),
                )
            ),
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
    if(verification_code.text.isEmpty ||
        Global.get_driver_pin_by_id(driverNameValue.value)!=verification_code.text) {
      verification_validate.value = true;
      TopBar().error_top_bar(
          context,App_Localization.of(context)!.translate("please_enter_the_code"));
    }
    else {
      verification_validate.value = false;
      Get.back();
      verification_validate.value = true;
    }
  }
  Future get_image_camera() async {
    image_picker.pickImage(source: ImageSource.camera).then((recordedImage) {
      imgs.add(ImageType(File(recordedImage!.path), false, Global.get_media_type("")));
    });
  }
  Future get_image_gallery() async {
    image_picker.pickImage(source: ImageSource.gallery).then((recordedImage) {
      imgs.add(ImageType(File(recordedImage!.path), false, Global.get_media_type("")));
    });
  }
  Future get_vedio_camera() async {
    image_picker.pickVideo(source: ImageSource.camera).then((recordedVideo) {
      vedios.add(ImageType(File(recordedVideo!.path), false, Global.get_media_type("v")));
      get_vedio_image(vedios.last);
    });
  }
  Future get_vedio_gallery() async {
    image_picker.pickVideo(source: ImageSource.gallery).then((recordedVideo) {
      vedios.add(ImageType(File(recordedVideo!.path), false, Global.get_media_type("v")));
      get_vedio_image(vedios.last);
    });
  }
  get_vedio_image(ImageType imageType) async {
    VideoThumbnail.thumbnailData(
      video: imageType.file.path,
      imageFormat: ImageFormat.PNG,
      quality: 25,
    ).then((value) async{
      ui.Codec codec = await ui.instantiateImageCodec(value!);
      ui.FrameInfo frame = await codec.getNextFrame();
      imageType.thum = RawImage(image:frame.image,fit: BoxFit.cover,);
    });
  }
  submit(History history,BuildContext context){
    try {
      if (driverNameValue == "non") {
        driver_validate.value = false;
      } else {
        driver_validate.value = true;
      }
      if(verification_validate.value){
        List<String> media=<String>[];
        List<int> mediaTypeId=<int>[];
        for(int i=0;i<imgs.length;i++){
          media.add(imgs[i].file.path);
          mediaTypeId.add(imgs[i].mediaType.id);
        }
        for(int i=0;i<vedios.length;i++){
          media.add(vedios[i].file.path);
          mediaTypeId.add(vedios[i].mediaType.id);
        }
        Global.offline_contract.add(OfflineHistory(
            id: history.id,
            clientName: history.clientName,
            clientPhone:history.clientPhone,
            contractNumber: history.contractNumber,
            carPlate: history.carPlate,
            deliveredId: history.deliveredId,
            delivered: history.delivered,
            receiverId: int.parse(driverNameValue.value),
            receiver: Global.get_driver_name_by_id(driverNameValue.toString()),
            statusId: 2,
            status: "Receive",
            deliverDate: history.deliverDate.toString(),
            receiveDate: DateTime.now().toString(),
            media:media,
            mediaTypeId:mediaTypeId
        ));
        Get.to(() => Signature())!.then((value) {
          clear();
        });
      } else {
        TopBar().error_top_bar(
            context,
            App_Localization.of(context)!.translate("please_enter_the_code")
        );
      }
    } catch(e) {
      TopBar().error_top_bar(
          context,
          App_Localization.of(context)!.translate("please_enter_the_code")
      );
    }
  }
  clear() {
    verification_code.clear();
    driverNameValue.value = "non";
    verification_validate.value = true;
    driver_validate.value = true;
    imgs.clear();
    vedios.clear();
  }

}