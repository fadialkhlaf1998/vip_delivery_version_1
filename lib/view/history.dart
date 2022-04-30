import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vip_delivery_version_1/archive/mediatype.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:vip_delivery_version_1/controller/home_controller.dart';
import 'package:vip_delivery_version_1/controller/intro_controller.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';
import 'package:vip_delivery_version_1/view/not_uploaded_history.dart';

class HistoryView extends StatelessWidget {
  HistoryView({Key? key}) : super(key: key);

  HistoryController historyController = Get.put(HistoryController());
  IntroController introController = Get.find();
  HomeController homeController = Get.find();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: Obx(() {
          return SafeArea(
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.main,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _header(context),
                          historyController.temp.isNotEmpty || historyController.search.text.isNotEmpty || historyController.viewSearchOption.isTrue ?
                          Column(
                            children: [
                              historyController.phoneSearchOption.isFalse && historyController.plateNumberOption.isFalse && historyController.contractSearchOption.isFalse
                              ? Column(
                                children: [
                                  SizedBox(height: 40),
                                  Icon(Icons.info_outline,color: AppColors.main3,),
                                  SizedBox(height: 5,),
                                  Text(
                                    App_Localization.of(context)!.translate("choose_search_option"),
                                    style: TextStyle(
                                        color: AppColors.main3,
                                      fontSize: 15
                                    ),
                                  ),
                                ],
                              )
                                  : historyController.temp.isEmpty && historyController.search.text.isNotEmpty ?
                                  Column(
                                    children: [
                                      SizedBox(height: 40),
                                      Icon(Icons.info_outline,color: AppColors.main3,),
                                      SizedBox(height: 5,),
                                      Text(
                                        App_Localization.of(context)!.translate("search_not_match"),
                                        style: TextStyle(
                                          color: AppColors.main3
                                        ),
                                      ),
                                    ],
                                  ) :
                             Column(
                               children: [
                                 AnimatedContainer(
                                   duration: Duration(milliseconds: 400),
                                   width: MediaQuery.of(context).size.width * 0.9,
                                   height: historyController.plateNumberOption.value ? 75 : 0,
                                   child:  AnimatedSwitcher(
                                     duration: Duration(milliseconds: 350),
                                     child:  historyController.plateNumberOption.value ? _plate_number(context) : Center(),
                                   ),
                                 ),
                                 historyController.temp.isNotEmpty
                                     ? _search_list(context)
                                     : historyController.plate_number.text.isNotEmpty
                                     ? Container(
                                     width: MediaQuery.of(context).size.width,
                                     height: 50,
                                     child:  Center(
                                       child: Text(
                                         App_Localization.of(context)!.translate("search_not_match"),
                                         style: TextStyle(
                                             color: AppColors.main3
                                         ),
                                       ),
                                     )
                                 )
                                     : Container(
                                   width: MediaQuery.of(context).size.width,
                                   height: 50,
                                   child:  Center(
                                     child: Text(
                                       App_Localization.of(context)!.translate("please_enter_the_value_you_went_to_search_for"),
                                       style: TextStyle(
                                           color: AppColors.main3
                                       ),
                                     ),
                                   )
                                 ),
                                 Container(
                                   width: MediaQuery.of(context).size.width * 0.85,
                                   child: Divider(
                                       thickness: 2,
                                       height: 15,
                                       color: AppColors.main3
                                   ),
                                 ),
                                 _not_uploaded(context)
                               ],
                             )
                            ],
                          ) :
                          _body(context),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                    Positioned(
                        child: historyController.is_loading.value?Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: AppColors.main.withOpacity(0.6),
                          child: Center(
                            child: CircularProgressIndicator(color: AppColors.main3),
                          ),
                        ):Container(
                          width: MediaQuery.of(context).size.width,
                          height: 0,
                          color: Colors.blue,
                        ))
                  ],
                ),
                ),
            ),
          );
        })
    );
  }

  _header(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.28,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              image: DecorationImage(
                  image: AssetImage("assets/home/history.png"),
                  fit: BoxFit.fitWidth
              )
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 15,left: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(historyController.viewSearchOption.isTrue && historyController.plateNumberOption.isFalse){
                          historyController.viewSearchOption.value = false;
                          FocusManager.instance.primaryFocus?.unfocus();
                          historyController.phoneSearchOption.value = false;
                          historyController.contractSearchOption.value = false;
                          historyController.plateNumberOption.value = false;
                          historyController.plate_number.clear();
                        }else{
                          homeController.select_nav_bar.value = 1;
                          historyController.search.clear();
                          historyController.temp.clear();
                        }

                        //historyController.histories.addAll(historyController.temp);
                      },
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,),
                      )
                    ),
                    Container(
                       width: MediaQuery.of(context).size.width * 0.8,
                       child: TextField(
                         style: const TextStyle(color: Colors.white),
                         controller: historyController.search,
                         cursorColor: AppColors.main3,
                         textAlignVertical: TextAlignVertical.center,
                         decoration: InputDecoration(
                           filled: true,
                           fillColor: AppColors.main3.withOpacity(0.4),
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(25),
                             borderSide: BorderSide(color: Colors.transparent),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(25),
                             borderSide: BorderSide(color: Colors.transparent),
                           ),
                           contentPadding: EdgeInsets.all(5),
                           prefixIcon: Icon(Icons.search,color: AppColors.main3),
                           hintText: App_Localization.of(context)!.translate("search"),
                           hintStyle: TextStyle(color: AppColors.main3,fontSize: 15),
                         ),
                         onChanged: historyController.plateNumberOption.value ? null : historyController.search_on_history,
                         onTap:(){
                           historyController.viewSearchOption.value = true;
                         },
                       ),
                     ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.12,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child:  historyController.viewSearchOption.value
                    ? Container(
                  width: MediaQuery.of(context).size.width *  0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){
                          historyController.choosePhoneSearchOption();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            color: historyController.phoneSearchOption.value ? AppColors.main2 : AppColors.main2.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: historyController.phoneSearchOption.value ? AppColors.turquoise : Colors.transparent,
                                width: 1)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/phone.svg",width: 25,height: 25),
                              SizedBox(height: 7),
                              Text(
                                App_Localization.of(context)!.translate("client_phone"),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          historyController.choosePlateNumberSearchOption();
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: historyController.plateNumberOption.value ? AppColors.main2 : AppColors.main2.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: historyController.plateNumberOption.value ? AppColors.turquoise : Colors.transparent,
                                  width: 1)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/plate.svg",width: 20,height: 20),
                              SizedBox(height: 10),
                              Text(
                                App_Localization.of(context)!.translate("plate_number"),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          historyController.chooseContractSearchOption();
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              color: historyController.contractSearchOption.value ? AppColors.main2 : AppColors.main2.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: historyController.contractSearchOption.value ? AppColors.turquoise : Colors.transparent,
                                  width: 1)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/contract.svg",width: 25,height: 25),
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
                )
                    : Center(),
              ),
            )
          ],
        ),

      ],
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  historyController.select_history.value = 0;
                },
                child: Column(
                  children: [
                    Text(
                      App_Localization.of(context)!.translate("done"),
                      style: TextStyle(
                          color: historyController.select_history.value == 0 ?
                          AppColors.green : Colors.white,
                          fontSize: 15),),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Divider(
                        thickness: 2,
                        height: 15,
                        color: historyController.select_history.value == 0 ?
                         Colors.white : Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  historyController.select_history.value = 1;
                },
                child: Column(
                  children: [
                    Text(
                      App_Localization.of(context)!.translate("in_progress"),
                      style: TextStyle(
                          color: historyController.select_history.value == 1 ?
                          AppColors.yellow : Colors.white,
                          fontSize: 15),),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Divider(
                        thickness: 2,
                        height: 15,
                        color: historyController.select_history.value == 1 ?
                        Colors.white : Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  historyController.select_history.value = 2;
                },
                child: Column(
                  children: [
                    Text(
                      App_Localization.of(context)!.translate("not_uploaded"),
                      style: TextStyle(
                          color: historyController.select_history.value == 2 ?
                          AppColors.red : Colors.white,
                          fontSize: 15),),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.34,
                      child: Divider(
                        thickness: 2,
                        height: 15,
                        color: historyController.select_history.value == 2 ?
                        Colors.white : Colors.transparent,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        historyController.select_history.value == 0 ?
        _done(context) : historyController.select_history.value == 1 ?
        _in_progress(context) :
        Global.offline_contract.isNotEmpty ?
        _not_uploaded(context) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Icon(Icons.info_outline,color: AppColors.main3),
            SizedBox(height: 5),
            Text(
              App_Localization.of(context)!.translate("no_data"),
              style: TextStyle(
                  color: AppColors.main3
              ),),
          ],
        ),
      ],
    );
  }
  _done(BuildContext context) {
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
            itemCount: historyController.done.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: () {
                    historyController.goToContract(historyController.done[index]);
                  },
                  child: _done_body(historyController.done[index],context)
              );
            }),
      ),
    );
  }
  _done_body(History history,BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width: 2,
              color:AppColors.green
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
                // TODO
                history.clientName,
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 18),),
            ),
            Text(
              DateFormat('yyyy-MM-dd').format(DateTime.parse(history.reciveDate.toString())),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18),),
            Text(
              history.contractNumber,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.turquoise,
                  fontSize: 20),),
            Container(
              child: Divider(
                  thickness: 2,
                  height: 15,
                  color: AppColors.green
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
                      color: AppColors.green
                  ),
                ),
                Text(
                  App_Localization.of(context)!.translate("done"),
                  style: TextStyle(
                      color: AppColors.green,
                      fontSize: 13
                  ),
                ),
              ],
            ),
            SizedBox(height: 5)
          ],
        ),
      ),
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
            itemCount: historyController.in_progress.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: () {
                    historyController.goToContract(historyController.in_progress[index]);
                  },
                  child: _in_progress_body(historyController.in_progress[index],context)
              );
            }),
      ),
    );
  }
  _in_progress_body(History history,BuildContext context) {
    return Container(
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
                history.clientName,
              //history.status,
                maxLines: 1,
                style: TextStyle(
                    //overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 18),),
            ),
            Text(
              DateFormat('yyyy-MM-dd').format(DateTime.parse(history.deliverDate.toString())),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18),),
            Text(
              history.contractNumber,
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
                Text(App_Localization.of(context)!.translate("in_progress"),
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
    );
  }
  _not_uploaded(BuildContext context) {
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
            itemCount: Global.offline_contract.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                  onTap: () {
                    historyController.is_loading.value = true;
                    print('-----------------');
                    print(Global.offline_contract.last.clientName);
                    print('-----------------');
                    Get.to(()=> NotUploadedHistory(Global.offline_contract[index]))
                    !.then((value) {
                      historyController.getHistory();
                      historyController.is_loading.value = false;
                    });
                  },
                  child: _not_unploaded_body(Global.offline_contract[index],context)
              );
            }),
      ),
    );
  }
  _not_unploaded_body(OfflineHistory offlineHistory,BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width: 2,
              color:AppColors.red
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
                offlineHistory.status,
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 18),),
            ),
            Text(
              DateFormat('yyyy-MM-dd').format(DateTime.parse(offlineHistory.deliverDate)),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18),),
            Text(
              offlineHistory.contractNumber,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                  color: AppColors.turquoise,
                  fontSize: 20),),
            Container(
              child: Divider(
                  thickness: 2,
                  height: 15,
                  color: AppColors.red
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
                      color: AppColors.red
                  ),
                ),
                Text(App_Localization.of(context)!.translate("not_uploaded"),
                  style: TextStyle(
                      color: AppColors.red,
                      fontSize: 13
                  ),
                ),
              ],
            ),
            SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
  _search_list(BuildContext context) {
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
            itemCount: historyController.temp.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                   //historyController.get_contract_images(introController.temp[index]);
                  FocusManager.instance.primaryFocus?.unfocus();
                  historyController.goToContract(historyController.temp[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          width: 2,
                          color: historyController.temp[index].receiver != "" ?
                          AppColors.green : AppColors.yellow
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
                            historyController.temp[index].receiver != "" ? "Received" : "Delivered",
                            maxLines: 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                                fontSize: 18),),
                        ),
                        Text(
                          historyController.temp[index].contractNumber,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.turquoise,
                              fontSize: 20),),
                        Text(
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(
                              historyController.temp[index].receiver != "" ?
                              historyController.temp[index].reciveDate.toString() :
                              historyController.temp[index].deliverDate.toString()
                          )),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18),),
                        Container(
                          child: Divider(
                              thickness: 2,
                              height: 15,
                              color: historyController.temp[index].receiver != "" ?
                              AppColors.green : AppColors.yellow
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
                                  color: historyController.temp[index].receiver != ""  ?
                                  AppColors.green : AppColors.yellow
                              ),
                            ),
                            // Text(App_Localization.of(context)!.translate("done"),
                            //   style: TextStyle(
                            //       color: AppColors.green,
                            //       fontSize: 13
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 5)
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
  
  _plate_number(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
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
                        color: Colors.black87
                    )
                ),
                child: Center(
                  child:
                  Text(
                    Global.language_code == "en" ?
                    historyController.code[historyController.codeValue.value] :
                    historyController.code2[historyController.codeValue.value],
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
                    historyController.emirate[historyController.select_value.value].link,
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
                      color: Colors.black87
                  )
              ),
              child: TextField(
                style: TextStyle(color: Colors.black87),
                controller: historyController.plate_number,
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
                onChanged: historyController.searchPlateNumber,
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
                    itemCount: historyController.emirate.length,
                    itemBuilder: (context,index) {
                      return Obx(()=> GestureDetector(
                        onTap: () {
                          historyController.select_value.value = index;
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
                                    historyController.emirate[index].link,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: historyController.select_value.value == index ?
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
                    itemCount: historyController.code.length,
                    itemBuilder: (context,index) {
                      return Obx(()=> GestureDetector(
                        onTap: () {
                          historyController.codeValue.value = index;
                          Get.back();
                          historyController.code_validate.value = true;
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
                                    historyController.code[index] :
                                    historyController.code2[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nawar',
                                        fontSize: 15
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: historyController.codeValue.value == index ?
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



}
