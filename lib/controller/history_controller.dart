import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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


  @override
  void onInit() {
    super.onInit();
    getHistory();
  }

  goToContract(History contract) async {
    print(contract.delivered);
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
      histories.forEach((h) {
        if(h.contractNumber.contains(query) || h.carPlate.contains(query) ||
            h.clientPhone.contains(query)) {
          temp.add(h);
          print(temp.length);
        }
      });
    }
  }


}