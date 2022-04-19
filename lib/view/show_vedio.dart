import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/controller/car_delivery_controller.dart';
import 'package:vip_delivery_version_1/controller/edit_contract_controller.dart';

class ShowVideo extends StatelessWidget {

  File file;
  String tag;
  CarDeliveryController carDeliveryController = Get.find();
  EditContractController editContractController = Get.find();

  ShowVideo(this.file,this.tag);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Hero(
            tag: this.tag,
            child: Material(
              child: Chewie(
                controller: tag == "video_tag_1" ?
                carDeliveryController.chewieController! :
                editContractController.chewieController!,
              ),
            )
        ),
      ),
    );
  }
}

