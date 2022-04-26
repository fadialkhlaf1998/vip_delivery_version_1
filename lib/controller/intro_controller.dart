import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/controller/new_api.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/view/home.dart';
import 'package:vip_delivery_version_1/view/login.dart';
import 'package:vip_delivery_version_1/view/no_internet.dart';

class IntroController extends GetxController {

  @override
  Future<void> onInit() async {
    super.onInit();
    move_to_home();
    //get_hirstories_data();
  }

  List<History> histories = <History>[];
  List<History> temp = <History>[];
  List<History> done = <History>[];
  List<History> in_progress = <History>[];
  var is_loading = false.obs;

  move_to_home() async {
    API.internet().then((internet) async {
      if(internet) {
        await Global.loadLoginInfo();
        if(Global.email != null && Global.password != null){
          NewApi.login(Global.email!, Global.password!).then((value){
            if(value){
              NewApi.getChauffeur().then((value) {
                Global.chauffeur.addAll(value);
                NewApi.getMedia().then((signatures) {
                  Global.media.addAll(signatures);
                  Get.offAll(()=>Home());
                });
              });
            }else{
              print('Field');
            }
          });
        }else{
          Get.offAll(()=>Login());
        }
      } else {
        Get.to(()=> NoInternet())!.then((value) {
          move_to_home();
        });
      }
    });
  }

  // get_hirstories_data(){
  //   API.internet().then((intenet) {
  //     if(intenet){
  //       NewApi.filter("").then((value) {
  //         histories.addAll(value);
  //         print(histories.length);
  //         is_loading.value = false;
  //         done = histories.where((i) => i.receiver != null).toList();
  //         in_progress = histories.where((i) => i.receiver == null).toList();
  //         print(done.length);
  //         print(in_progress.length);
  //       });
  //       Global.load_offline_contract();
  //     } else {
  //       Get.to(()=> NoInternet())!.then((value) {
  //         //get_hirstories_data();
  //       });
  //     }
  //   });
  // }


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