import 'package:chewie/chewie.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/car_delivery_controller.dart';
import 'package:vip_delivery_version_1/controller/edit_contract_controller.dart';
import 'package:vip_delivery_version_1/model/contract_image.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/view/show_vedio.dart';

class EditContract extends StatefulWidget {
  History history;
  List<ContractImage> contract_image;
  EditContract(this.history,this.contract_image);

  @override
  State<EditContract> createState() => _EditContractState(this.history,this.contract_image);
}

class _EditContractState extends State<EditContract> {
  History history;
  List<ContractImage> contract_image;
  EditContractController editContractController = Get.put(EditContractController());
  CarDeliveryController carDeliveryController = Get.put(CarDeliveryController());

  _EditContractState(this.history,this.contract_image) {
    editContractController.clear();
  }

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  _body(context)
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
                    editContractController.clear();
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,),
                ),
                Text(
                  App_Localization.of(context)!.translate("edit_contract"),
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
                      color: AppColors.yellow
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
        editContractController.submit(history, context);
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
        SizedBox(height: 20,),
        _driver_name(context),
        SizedBox(height: 10,),
        contract_image.length > 0 ?
        _old_media(context) : Center(),
        SizedBox(height: 10,),
        _images_videos(context),
        SizedBox(height:
        editContractController.imgs.length ==0 ||
            editContractController.vedios.length ==0 ? 10 : 10
        ),
        editContractController.imgs.length == 0 ? Center() :
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
        SizedBox(height: editContractController.imgs.length ==0 ? 0 : 5),
        editContractController.imgs.length == 0 ? Center() :
        _add_photo(context),
        SizedBox(height: editContractController.imgs.length == 0 ? 0: 10),
        editContractController.vedios.length == 0 ? Center() :
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
        SizedBox(height: editContractController.vedios.length == 0 ? 0 : 5),
        editContractController.vedios.length == 0 ? Center() :
        _add_vedio(context),
        SizedBox(height: 20),
        _footer(context),
        SizedBox(height: 30,),
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
  //                   history.deliveredId.toString(),
  //                   //history.status,
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
  //                   history.carPlate,
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
  //                     widget.history.contractNumber,
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
                    history.carPlate,
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
      decoration: BoxDecoration(
          color: AppColors.main2,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: !editContractController.driver_validate.value ?
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
        value: editContractController.driverNameValue.value =="non" ? null: editContractController.driverNameValue.value,
        icon: Icon(Icons.arrow_drop_down , size: 25,color: AppColors.main3),
        items: Global.chauffeur.map((newvalue) {
          return DropdownMenuItem(
            value: newvalue.id.toString(),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.all(5),
              child: Text(
                newvalue.name.toString(),
                style: TextStyle(
                    color: AppColors.main3
                ),),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          editContractController.driverNameValue.value = newValue.toString();
          editContractController.driver_validate.value = true;
          editContractController.driver_verification_code(context);
        },
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
                  Text(history.clientPhone,
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
                  Text(widget.history.contractNumber,
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
  _old_media(BuildContext context){
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width*0.9,
        child: ListView.builder(
            itemCount: widget.contract_image.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    if(widget.contract_image[index].mediaUrl!.endsWith(".mp4")){
                      editContractController.videoPlayerController =
                      VideoPlayerController.network(
                          editContractController.media_url + widget.contract_image[index].mediaUrl.toString())
                        ..initialize().then((_) {
                          editContractController.videoPlayerController!.play();
                          Get.back();
                          _show_old_video(context);
                        });
                      _laoding_video(context);
                    }else {
                      _show_old_image(context, widget.contract_image[index].mediaUrl.toString());
                    }
                  },
                  child: widget.contract_image[index].mediaUrl!.endsWith(".mp4") ?
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
                              image: NetworkImage(
                                  editContractController.media_url+widget.contract_image[index].mediaUrl.toString()),
                              fit: BoxFit.cover
                          )
                      )
                  ),
                ),
              );
            })
    );
  }
  _show_old_image(BuildContext context,String path) {
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
                              child: Image.network(editContractController.media_url+path,fit: BoxFit.cover),
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
  _show_old_video(BuildContext context) {
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
                            child:VideoPlayer(editContractController.videoPlayerController!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() => GestureDetector(
                                  onTap: () {
                                    editContractController.is_play.value = !editContractController.is_play.value;
                                    if(editContractController.videoPlayerController!.value.isPlaying || editContractController.is_play.value){
                                      editContractController.videoPlayerController!.pause();
                                    }
                                    else {
                                      editContractController.videoPlayerController!.play();
                                    }
                                  },
                                  child: !editContractController.is_play.value ?
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
          itemCount: editContractController.imgs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: GestureDetector(
                onTap: () {
                 setState(() {
                   _show_image_uploaded(context,index);
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
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: FileImage(editContractController.imgs[index].file),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              editContractController.imgs.removeAt(index);
                            });
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
          itemCount: editContractController.vedios.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Container(
                child: Hero(
                  tag: "video_tag_2",
                  child: GestureDetector(
                      onTap: (){
                        setState(() {
                          editContractController.videoPlayerController =
                          VideoPlayerController.file(
                              editContractController.vedios[index].file)
                            ..initialize().then((_) {
                              editContractController.chewieController = ChewieController(
                                videoPlayerController: editContractController.videoPlayerController!,
                                aspectRatio: 3 / 2,
                                autoPlay: true,
                                looping: false,
                                allowFullScreen: true,
                                optionsTranslation: OptionsTranslation(
                                  cancelButtonText: "close",
                                ),
                                optionsBuilder: (context, defaultOptions) async {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.off(() => EditContract(widget.history, widget.contract_image));
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
                                                Text("Close",
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
                              Get.to(()=>ShowVideo(editContractController.vedios[index].file,"video_tag_2"));
                            });
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
                                child:Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.video_call_outlined,size: 40,color: AppColors.main),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    editContractController.vedios.removeAt(index);
                                  });
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
  _show_image_uploaded(BuildContext context,int index) {
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
                            child: Image.file(editContractController.imgs[index].file,fit: BoxFit.cover,),

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
                                  editContractController.get_image_camera();
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
                                  editContractController.get_image_gallery();
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
                                  editContractController.get_vedio_camera();
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
                                  editContractController.get_vedio_gallery();
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
}
