import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:vip_delivery_version_1/controller/home_controller.dart';
import 'package:vip_delivery_version_1/view/contract.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);

  HistoryController historyController = Get.put(HistoryController());
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() {
          return SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.main,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    _body(context),
                    const SizedBox(height: 40),
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
                    homeController.select_nav_bar.value ++;
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
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
        Padding(
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
                itemCount: historyController.select_history.value == 0 ? 8 :
                    historyController.select_history.value == 1 ? 5 : 4,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => Contract());
                    },
                    child: _card(context),
                  );
                }),
          ),
        )
      ],
    );
  }
  _card( BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              width: 2,
              color: historyController.select_history.value == 0 ?
              AppColors.green : historyController.select_history.value == 1 ?
              AppColors.yellow : AppColors.red)
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text("Title Card",
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 18),),
            ),
            Text("21 FEB 2021",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18),),
            Text("B 54886",
              style: TextStyle(
                  color: AppColors.turquoise,
                  fontSize: 20),),
            Container(
              child: Divider(
                thickness: 2,
                height: 15,
                color: historyController.select_history.value == 0 ?
                AppColors.green : historyController.select_history.value ==1 ?
                AppColors.yellow : AppColors.red,
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
                      color: historyController.select_history.value == 0 ?
                      AppColors.green : historyController.select_history.value ==1 ?
                      AppColors.yellow : AppColors.red
                  ),
                ),
                Text(historyController.select_history.value == 0 ?
                App_Localization.of(context)!.translate("done") :
                historyController.select_history.value ==1 ?
                App_Localization.of(context)!.translate("in_progress") :
                App_Localization.of(context)!.translate("not_uploaded"),
                  style: TextStyle(
                      color: historyController.select_history.value == 0 ?
                      AppColors.green : historyController.select_history.value ==1 ?
                      AppColors.yellow : AppColors.red,
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

}
