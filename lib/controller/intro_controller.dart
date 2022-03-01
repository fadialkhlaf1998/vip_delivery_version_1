import 'package:get/get.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/controller/api.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/view/login.dart';
import 'package:vip_delivery_version_1/view/no_internet.dart';

class IntroController extends GetxController {

  @override
  Future<void> onInit() async {
    super.onInit();
    move_to_home();
    get_hirstories_data();
  }

  List<History> histories = <History>[];
  List<History> temp = <History>[];
  List<History> done = <History>[];
  List<History> in_progress = <History>[];
  var is_loading = true.obs;

  move_to_home(){
    API.internet().then((internet) {
      if(internet) {
        API.get_chauffer().then((value) {
          Global.chauffeur.addAll(value);
          //print(Global.chauffeur.length);
          API.get_media("sign").then((signatures) {
            Global.signature.addAll(signatures);
            Get.off(()=>Login());
          });
          API.get_media("video").then((videos) {
            Global.video.addAll(videos);
            print(Global.video.length);
          });
          API.get_media("img").then((images) {
            Global.media.addAll(images);
            print(Global.media.length);
          });
        });
      } else {
        Get.to(()=> NoInternet())!.then((value) {
          move_to_home();
        });
      }
    });
  }
  get_hirstories_data(){
    API.internet().then((intenet) {
      if(intenet){
        API.get_history("").then((value) {
          histories.addAll(value);
          print(histories.length);
          is_loading.value = false;
          done = histories.where((i) => i.status=="Received").toList();
          in_progress = histories.where((i) => i.status!="Received").toList();
          print(done.length);
          print(in_progress.length);
        });
        Global.load_offline_contract();
      } else {
        Get.to(()=> NoInternet())!.then((value) {
          get_hirstories_data();
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