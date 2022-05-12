import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vip_delivery_version_1/archive/plate.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/controller/intro_controller.dart';
import 'package:vip_delivery_version_1/controller/new_api.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/view/contract.dart';
import 'package:vip_delivery_version_1/view/no_internet.dart';

class HistoryController extends GetxController {

  var select_history = 0.obs;
  TextEditingController search = TextEditingController();
  IntroController introController = Get.find();

  List<History> histories = <History>[];
  RxList<History> temp = <History>[].obs;
  List<History> done = <History>[];
  List<History> in_progress = <History>[];

  var is_loading = true.obs;

  RxBool viewSearchOption = false.obs;
  RxBool phoneSearchOption = false.obs;
  RxBool plateNumberOption = false.obs;
  RxBool contractSearchOption = false.obs;
  RxList code = ["Select Code","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  RxList code2 = ["اختر رمز","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"].obs;
  var codeValue = 0.obs;
  TextEditingController plate_number = TextEditingController();
  List <Plate> emirate = [
    Plate("assets/emirate/abu_dhabi.svg","ABU DHABI"),
    Plate("assets/emirate/ajman.svg","AJMAN"),
    Plate("assets/emirate/dubai.svg","DUBAI"),
    Plate("assets/emirate/fujairah.svg","FUJAIRAH"),
    Plate("assets/emirate/ras_al_khaimah.svg","RAS AL KHAIMAH"),
    Plate("assets/emirate/sharjah.svg","SHARJAH"),
    Plate("assets/emirate/um_al_quwain.svg","UMM AL QUWAIN"),
  ].obs;
  var select_value = 0.obs;
  var codeValue2 = "A".obs;
  var code_validate = true.obs;


  @override
  void onInit() {
    super.onInit();
    getHistory();
  }

  goToContract(History contract) async {
    Get.to(()=>Contract(contract));
  }

  // get_contract_images(History history){
  //   API.internet().then((internet) {
  //     if(internet){
  //       introController.is_loading.value = true;
  //       API.get_contract_image(history.id.toString()).then((value) {
  //         Get.to(() => Contract(history,value));
  //         introController.is_loading.value = false;
  //       });
  //     } else {
  //       Get.to(()=> NoInternet())!.then((value) {
  //         get_contract_images(history);
  //       });
  //     }
  //   });
  // }

  getHistory(){
    NewApi.internet().then((intenet) {
      if(intenet){
        histories.clear();
        done.clear();
        in_progress.clear();
        is_loading.value = true;
        NewApi.filter("%","%","%").then((value) {
          histories.addAll(value);
          print(histories.length);
          done = histories.where((i) => i.receiver != "").toList();
          in_progress = histories.where((i) => i.receiver == "").toList();
          print('done length : ${done.length}');
          print('in progress length : ${in_progress.length}');
          is_loading.value = false;
          Global.load_offline_contract();
          print('offline contract ${Global.offline_contract.length}');
        });

      } else {
        Get.to(()=> NoInternet())!.then((value) {
          //get_hirstories_data();
        });
      }
    });
  }


  search_on_history(String query) {
    temp.clear();
    if(query.isEmpty){
      return;
    }
    else {
      if (phoneSearchOption.value){
        temp.clear();
        histories.forEach((h) {
          if(h.clientPhone.contains(query)) {
            temp.add(h);
            print(temp.length);
          }
        });
      }else if (plateNumberOption.value){
        temp.clear();
        histories.forEach((h) {
          if(h.carPlate.contains(query)) {
            temp.add(h);
            print(temp.length);
          }
        });
      }else if (contractSearchOption.value){
        temp.clear();
        histories.forEach((h) {
          if(h.contractNumber.contains(query)){
            temp.add(h);
            print(temp.length);
          }
        });
      }
    }
  }

  searchPlateNumber(String query){
    temp.clear();
    String finalResult = code[codeValue.value] + ' | ' +  emirate[select_value.value].id.toLowerCase() + ' | ' + query;
    // print(finalResult);

    histories.forEach((element) {
      if(element.carPlate.contains(finalResult)){
        temp.add(element);
      }
    });
    // print(temp.length);
  }

  choosePhoneSearchOption(){
    search.clear();
    temp.clear();
    phoneSearchOption.value = true;
    plateNumberOption.value = false;
    contractSearchOption.value = false;
    plate_number.clear();
  }

  choosePlateNumberSearchOption(){
    search.clear();
    temp.clear();
    phoneSearchOption.value = false;
    plateNumberOption.value = true;
    contractSearchOption.value = false;
    plate_number.clear();
  }

  chooseContractSearchOption(){
    search.clear();
    temp.clear();
    phoneSearchOption.value = false;
    plateNumberOption.value = false;
    contractSearchOption.value = true;
    plate_number.clear();
  }



}