import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:vip_delivery_version_1/controller/not_uploaded_history_controller.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';


class NotUploadedHistory extends StatefulWidget {
  OfflineHistory offlineHistory;

  NotUploadedHistory(this.offlineHistory);

  @override
  State<NotUploadedHistory> createState() => _NotUploadedHistoryState(this.offlineHistory);
}

class _NotUploadedHistoryState extends State<NotUploadedHistory> with SingleTickerProviderStateMixin{
  OfflineHistory offlineHistory;
  NotUploadedHistController notUploadedHistController = Get.put(NotUploadedHistController());
  HistoryController historyController = Get.find();
  _NotUploadedHistoryState(this.offlineHistory) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(()=> SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.main,
            child: SingleChildScrollView(
              child: !notUploadedHistController.is_loading.value ?
              Column(
                children: [
                  _header(context),
                  _body(context),
                  _footer(context),
                  SizedBox(height: 30)
                ],
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
                  image: AssetImage("assets/home/history.png"),
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
                Text(
                  App_Localization.of(context)!.translate("contract"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: historyController.select_history.value == 0 ?
                      AppColors.green : historyController.select_history.value ==1 ?
                      AppColors.yellow : AppColors.red
                  ),
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
        notUploadedHistController.submit(context, offlineHistory);
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
  _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        _plate(context),
        SizedBox(height: 15,),
        _contract_number(context),
        // SizedBox(height: 15,),
        // _client_name(context),
        SizedBox(height: 15,),
        _client_phone(context),
        SizedBox(height: 15,),
        _driver_name(context),
        SizedBox(height: 10,),
        _images_video_list(),
        SizedBox(height: 15,),
      ],
    );
  }
  // _code_emirate_plate(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.9,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(5)
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(5),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //             height: 40,
  //             width: MediaQuery.of(context).size.width * 0.28,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5),
  //                 border: Border.all(
  //                     color: Colors.black87
  //                 )
  //             ),
  //             child: Center(
  //                 child:
  //                 Text(
  //                   offlineHistory.status,
  //                   //cartReceiptController.code[4],
  //                   style: TextStyle(
  //                       fontSize: 20
  //                   ),)),
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width * 0.25,
  //             //height: 50,
  //             child: Center(
  //                 child: Text(
  //                   offlineHistory.carPlate,
  //                   //cartReceiptController.code[4],
  //                   style: TextStyle(fontSize: 20),
  //                 )),
  //             // Center(
  //             //   child:
  //             //   SvgPicture.asset(
  //             //     cartReceiptController.emirate[2],
  //             //     color: Colors.black,
  //             //   ),),
  //           ),
  //           Container(
  //               height: 40,
  //               width: MediaQuery.of(context).size.width * 0.28,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(5),
  //                   border: Border.all(
  //                       color: Colors.black87
  //                   )
  //               ),
  //               child: Center(
  //                   child:
  //                   Text(
  //                     offlineHistory.contractNumber,
  //                     style: TextStyle(
  //                         fontSize: 20
  //                     ),))
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  _plate(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("code_emirate_plate"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(
                    offlineHistory.carPlate,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _driver_name(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("driver's_name"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(
                    offlineHistory.delivered,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _client_name(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("client_name"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text("Feras Feras",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _client_phone(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("client_phone"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(
                    offlineHistory.clientPhone,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _contract_number(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("contract_number"),
            style: TextStyle(
                color: AppColors.main3,
                fontSize: 16
            ),),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.main2,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Text(offlineHistory.contractNumber,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  _images_video_list(){
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView.builder(
            itemCount: offlineHistory.media.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      if(offlineHistory.media[index].endsWith(".mp4")){
                        notUploadedHistController.videoPlayerController =
                        VideoPlayerController.file(
                            File(offlineHistory.media[index].toString()))
                          ..initialize().then((_) {
                            notUploadedHistController.videoPlayerController !.play();
                            Get.back();
                            _show_video(context);
                          });
                        _laoding_video(context);
                      }else{
                        _show_image(context, offlineHistory.media[index]);
                      }
                    },
                    child: offlineHistory.media[index].toString().endsWith('.mp4') ?
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2,color: AppColors.main3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                          child: Icon(
                            Icons.video_call_outlined,
                            color: Colors.white,size: 50,)),
                    ) :
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2,color: AppColors.main3),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: FileImage(File(offlineHistory.media[index])),
                          fit: BoxFit.cover
                        )
                      )
                    ),
                  ),
              );
            })
    );
  }
  _show_image(BuildContext context,String path) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return  GestureDetector(
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
                              child: Image.file(File(path),fit: BoxFit.cover,),
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
  _show_video(BuildContext context) {
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
                  child:  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width,
                            child: VideoPlayer(notUploadedHistController.videoPlayerController!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() => GestureDetector(
                                  onTap: () {
                                   setState(() {
                                     notUploadedHistController.is_play.value = !notUploadedHistController.is_play.value;
                                     if(notUploadedHistController.videoPlayerController!.value.isPlaying || notUploadedHistController.is_play.value){
                                       notUploadedHistController.videoPlayerController!.pause();
                                          }
                                     else {
                                       notUploadedHistController.videoPlayerController!.play();
                                     }
                                   });
                                  },
                                  child: !notUploadedHistController.is_play.value?
                                  Icon(Icons.pause,color: Colors.white, size: 30,):
                                  Icon(Icons.play_arrow,color: Colors.white, size: 30),
                                ))
                              ],
                            ),
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
  _laoding_video(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___){
        return Container(
          color: AppColors.main.withOpacity(0.5),
          child: Column(
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

}
