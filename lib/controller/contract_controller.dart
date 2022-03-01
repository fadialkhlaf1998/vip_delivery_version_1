import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vip_delivery_version_1/model/contract_image.dart';

class ContractController extends GetxController {

  String media_url='https://phplaravel-548447-2195842.cloudwaysapps.com/storage/images/';
  List<ContractImage> deliver_image =<ContractImage>[];
  List<ContractImage> receipt_image =<ContractImage>[];
  VideoPlayerController? videoPlayerController;
  var is_play = false.obs;
}