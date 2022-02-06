import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/app_colors.dart';
import 'package:vip_delivery_version_1/const/app_localization.dart';
import 'package:vip_delivery_version_1/controller/car_receipt_controller.dart';
import 'package:vip_delivery_version_1/controller/contract_controller.dart';
import 'package:vip_delivery_version_1/controller/history_controller.dart';
import 'package:whiteboard/whiteboard.dart';

class Contract extends StatelessWidget {
  Contract({Key? key}) : super(key: key);

  ContractController contractController = Get.put(ContractController());
  HistoryController historyController = Get.find();
  CartReceiptController cartReceiptController = Get.put(CartReceiptController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> SafeArea(
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
  _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        _code_emirate_plate(context),
        SizedBox(height: 20,),
        _driver_name(context),
        SizedBox(height: 15,),
        _client_name(context),
        SizedBox(height: 15,),
        _client_phone(context),
        SizedBox(height: 15,),
        _contract_number(context),
        SizedBox(height: 15,),
        _client_location(context),
        SizedBox(height: 20,),
        _list_images(context),
        SizedBox(height: 20,),
        _signature(context),
        SizedBox(height: 30,),
      ],
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
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black87
                  )
              ),
              child: Center(
                  child:
                  Text(
                    cartReceiptController.code[4],
                    style: TextStyle(
                        fontSize: 20
                    ),)),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 40,
              child: Center(
                child:
                SvgPicture.asset(
                  cartReceiptController.emirate[2],
                  color: Colors.black,
                ),),
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
                child: Center(
                    child:
                    Text("54886",
                      style: TextStyle(
                          fontSize: 20
                      ),))
            ),
          ],
        ),
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
                  Text("Lama",
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
                  Text("+971" + " " +"56 565 455",
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
                  Text("1236842",
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
  _client_location(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            App_Localization.of(context)!.translate("client_location"),
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
                  Text("abu dhabi",
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
  _list_images(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return _images(context);
          }),
    );
  }
  _images(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/home/history.png"),
                  fit: BoxFit.cover
              )
          ),
        ),
        SizedBox(width: 10)
      ],
    );
  }
  _signature(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.43,
              decoration: BoxDecoration(
                  color: AppColors.main2,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: WhiteBoard(
                strokeColor: AppColors.main3,
                backgroundColor: Colors.transparent,
                strokeWidth: 3,
              )
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.43,
              decoration: BoxDecoration(
                  color: AppColors.main2,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: WhiteBoard(
                strokeColor: AppColors.main3,
                backgroundColor: Colors.transparent,
                strokeWidth: 3,
              )
          )
        ],
      ),
    );
  }

}
