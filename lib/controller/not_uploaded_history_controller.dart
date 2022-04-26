import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/const/top_bar.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/controller/new_api.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';
import 'package:vip_delivery_version_1/view/no_internet.dart';

class NotUploadedHistController extends GetxController {

  VideoPlayerController? videoPlayerController;
  var is_play = false.obs;
  var is_loading = false.obs;

  submit(BuildContext context,OfflineHistory offlineHistory){
    try{
      NewApi.internet().then((internet) {
        if(internet){
          is_loading.value = true;
          NewApi.upload_offLine_history(offlineHistory).then((value) {
            if(value){
                TopBar().success_top_bar(context,
                    App_Localization.of(context)!.translate("uploaded_successfully"));
                Get.back();
            }else {
                TopBar().error_top_bar(context,
                    App_Localization.of(context)!.translate("upload_failed"));
                Get.back();
            }
          });
        }
        else{
          Get.to(() => NoInternet())!.then((value) {
            submit(context,offlineHistory);
          });
        }
      });
    }catch(e){
      TopBar().error_top_bar(
          context,"error");
    }
  }

}