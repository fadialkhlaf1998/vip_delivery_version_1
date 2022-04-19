import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/singnature_controller.dart';
import 'package:vip_delivery_version_1/view/home.dart';
import 'package:whiteboard/whiteboard.dart';

class Signature extends StatefulWidget {
  Signature({Key? key}) : super(key: key);

  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {

  SignatureController signatureController = Get.put(SignatureController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: AppColors.main,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.main,
            child: SingleChildScrollView(
                child:
                Column(
                  children: [
                    _header(context),
                    _signature_body(context),
                    _footer(context),
                    SizedBox(height: 30,)
                  ],
                )
            )
          ),
        )
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
                  image: AssetImage("assets/home/signature.png"),
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
                    signatureController.clear_textfields();
                    Get.off(()=> Home());
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,),
                ),
                Center(
                  child: Text(
                    App_Localization.of(context)!.translate("signature"),
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
        signatureController.signature_submit(context);
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
            signatureController.driver == null  ||
                signatureController.client == null ?
            App_Localization.of(context)!.translate("next"):
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
  _signature_body(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.main3 ,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: signatureController.driver == null ?
                          AppColors.main2 : AppColors.main3,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 0.1,
                              blurRadius: 0.1
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    App_Localization.of(context)!.translate("driver"),
                    style: TextStyle(
                        color: AppColors.main3,
                        fontSize: 15
                    ),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Divider(
                        thickness: 2,
                        color: AppColors.main3,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.main3 ,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: signatureController.driver == null ||signatureController.client != null?
                          AppColors.main3 : AppColors.main2,
                          borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0.1,
                                  blurRadius: 0.1
                              )
                            ]
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    App_Localization.of(context)!.translate("client"),
                    style: TextStyle(
                        color: AppColors.main3,
                        fontSize: 15
                    ),),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                      borderRadius:  BorderRadius.circular(15),
                      child: signatureController.client==null||signatureController.driver==null?
                      WhiteBoard(
                        backgroundColor: AppColors.main3,
                        controller: signatureController.whiteBoardController,
                        strokeWidth: 3,
                        strokeColor: Colors.white,
                        isErasing: false,
                        onConvertImage: (list) async {
                          Directory appDocDirectory = await getApplicationDocumentsDirectory();
                          Directory(appDocDirectory.path).create(recursive: true)
                              .then((Directory directory) {
                            if(signatureController.is_driver.value) {
                              String path="";
                              if(Global.offline_contract.last.id == -1) {
                                path=directory.path+'/'+Global.offline_contract.last.contractNumber+'_deliver_driver.png';
                              }else {
                                path=directory.path+'/'+Global.offline_contract.last.contractNumber+'_receipt_driver.png';
                              }
                              File(path).writeAsBytes(list);
                              setState(() {
                                signatureController.driver=File(path);
                                Global.offline_contract.last.media.add(path);
                                Global.offline_contract.last.mediaTypeId.add(Global.get_media_type_by_name("Chauffeur Signature"));
                                signatureController.is_driver.value = false;
                              });
                            }else {
                              String path="";
                              if(Global.offline_contract.last.id==-1) {
                                path=directory.path+'/'+Global.offline_contract.last.contractNumber+'_deliver_client.png';
                              }else {
                                path=directory.path+'/'+Global.offline_contract.last.contractNumber+'_receipt_client.png';
                              }
                              setState(() {
                                signatureController.is_driver.value = true;
                              });
                              File(path).writeAsBytes(list);
                              setState(() {
                                signatureController.client=File(path);
                                Global.offline_contract.last.media.add(path);
                                Global.offline_contract.last.mediaTypeId.add(Global.get_media_type_by_name("Client Signature"));
                              });
                            }
                          });
                        },
                      ) :
                      Center(
                        child:
                        signatureController.client != null ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              App_Localization.of(context)!.translate("click_here"),
                              style: TextStyle(
                                  color: AppColors.main3,
                                  fontSize: 20
                              ),),
                            SizedBox(height: 5,),
                            Icon(Icons.arrow_downward,
                              size: 25,
                              color: AppColors.main3,)
                          ],
                        )
                            : Center(),
                      )
                  ),
                ),
                Positioned(
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          signatureController.whiteBoardController.clear();
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: signatureController.client == null ||
                              signatureController.driver == null
                              ? AppColors.main
                              : Colors.transparent,
                        )))
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
