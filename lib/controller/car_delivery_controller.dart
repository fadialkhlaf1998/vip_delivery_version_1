import 'dart:io';
import 'dart:ui' as ui;
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/model/image_type.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';
import 'package:vip_delivery_version_1/model/plate.dart';
import 'package:vip_delivery_version_1/view/signature.dart';

class CarDeliveryController extends GetxController {

  TextEditingController client_name = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController contract_number = TextEditingController();
  TextEditingController plate_number = TextEditingController();
  TextEditingController verification_code = TextEditingController();
  ChewieController? chewieController ;
  ImagePicker image_picker = ImagePicker();
  VideoPlayerController? videoPlayerController;
  RxString driverNameValue = "non".obs;
  var codeValue = 0.obs;
  RxList code = ["Select Code","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  RxList code2 = ["اختر رمز","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  String phone = "non";
  var select_value = 0.obs;
  var validate = false.obs;
  var code_validate = true.obs;
  var driver_validate = true.obs;
  var verification_validate = false.obs;
  RawImage? imagePath ;
  List <Plate> emirate = [
    Plate("assets/emirate/abu_dhabi.svg","abu dhabi"),
    Plate("assets/emirate/ajman.svg","ajman"),
    Plate("assets/emirate/dubai.svg","dubai"),
    Plate("assets/emirate/fujairah.svg","fujairah"),
    Plate("assets/emirate/ras_al_khaimah.svg","ras al khaimah"),
    Plate("assets/emirate/sharjah.svg","sharjah"),
    Plate("assets/emirate/um_al_quwain.svg","um al quwain"),
  ].obs;
  List<ImageType> imgs=<ImageType>[].obs;
  List<ImageType> videos=<ImageType>[].obs;
  List<String> media=<String>[];
  List<int> mediaTypeId=<int>[];

  Future get_image_camera() async {
    var status = await Permission.camera.status;
    if(status.isDenied & Platform.isIOS){
      print('denied------------------- camera image');
    }
    image_picker.pickImage(source: ImageSource.camera, imageQuality: 85).then((recordedImage) {
      imgs.add(ImageType(File(recordedImage!.path), false, Global.get_media_type("")));

    });
  }
  Future get_image_gallery() async {
    image_picker.pickImage(source: ImageSource.gallery, imageQuality: 85).then((recordedImage) {
      imgs.add(ImageType(File(recordedImage!.path), false, Global.get_media_type("")));
    });
  }
  Future get_vedio_camera() async {
    var status = await Permission.camera.status;
     image_picker.pickVideo(source: ImageSource.camera).then((recordedVideo){
       videos.add(ImageType(File(recordedVideo!.path), false, Global.get_media_type("5")));
      get_vedio_image(videos.last);
    });
  }
  Future get_vedio_gallery() async {
    image_picker.pickVideo(source: ImageSource.gallery).then((recordedVideo) {
      videos.add(ImageType(File(recordedVideo!.path), false, Global.get_media_type("5")));
      get_vedio_image(videos.last);
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
      imagePath = imageType.thum;

    });
  }
  driver_verification_submit(BuildContext context) {
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
        plate_number.text.isEmpty || plate_number.text.length < 5 || driverNameValue.value == false) {
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
      media.clear();
      mediaTypeId.clear();
      verification_validate.value = false;
      for(int i=0;i<imgs.length;i++){
        media.add(imgs[i].file.path);
        mediaTypeId.add(imgs[i].mediaType.id);
      }
      for(int i=0;i<videos.length;i++){
        media.add(videos[i].file.path);
        mediaTypeId.add(videos[i].mediaType.id);
      }
      print(Global.get_driver_name_by_id(driverNameValue.toString()));
      Global.offline_contract.add(OfflineHistory(
          id: -1,
          clientName: client_name.text,
          clientPhone:phone,
          contractNumber: contract_number.text,
          carPlate: code[codeValue.value] + " | " + emirate[select_value.value].id + " | " + plate_number.text,
          deliveredId: int.parse(driverNameValue.value),
          delivered: Global.get_driver_name_by_id(driverNameValue.toString()),
          receiverId: -1,
          receiver: "",
          statusId: 1,
          status: "Deliver",
          deliverDate: DateTime.now().toString(),
          receiveDate: "",
          media:media,
          mediaTypeId:mediaTypeId,
      ));
      Get.back();
      verification_code.clear();
      Get.to(() => Signature());
    }
  }

}