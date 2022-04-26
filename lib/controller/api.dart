import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:vip_delivery_version_1/archive/chauffer.dart';
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/model/car-deliver.dart';
import 'package:vip_delivery_version_1/model/contract_image.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/model/mediatype.dart';
import 'package:http/http.dart' as http;
import 'package:vip_delivery_version_1/model/offline_history.dart';

class API {
  static String url='https://phplaravel-548447-2195842.cloudwaysapps.com';

  // static Future<List<Media>> get_media(String state)async{
  //   var headers = {
  //     'Accept': 'application/json'
  //   };
  //   var request = http.Request('GET', Uri.parse('https://phplaravel-548447-2195842.cloudwaysapps.com/api/getMediaTypesList?state='+state));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     return  MediaTypeList.fromJson(await response.stream.bytesToString()).data;
  //   }
  //   else {
  //     return <Media>[];
  //   }
  // }
  static Future<List<Chauffeur>> get_chauffer()async{
    var headers = {
      'Accept': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url+'/api/getChauffeursList'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var list=await response.stream.bytesToString();
      return ChauffeursList.fromJson(list).data;
    }
    else {
      return <Chauffeur>[];
    }
  }
  static Future<int> deliver_car(String client_phone,String car_plate,String contract_number ,String driver_id)async{
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'/api/deliverCar'));
    request.body = json.encode({
      "client_phone": client_phone,
      "car_plate": car_plate,
      "contract_number": contract_number,
      "delivered_id": driver_id
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json=await response.stream.bytesToString();
      //print(json);
      CarDeliver d=CarDeliver.fromJson(json);
      // print('*********************************');
      //print(d.code);
      return d.data;
    }
    else {
      var json=await response.stream.bytesToString();
      // print('****************----*************');
      //print(json);
      return -1;
    }
  }
  static Future<bool> store_media(File file,String contact_id,String type_id,String status)async{
    //status: 2 recive | 1 deliver
    var request = http.MultipartRequest('POST', Uri.parse(url+'/api/storeMedia'));
    request.fields.addAll({
      'contact_id': contact_id,
      'type_id': type_id,
      'status': status
    });
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json=await response.stream.bytesToString();
      return true;
    }
    else {
      var json=await response.stream.bytesToString();
      return false;
    }
  }
  static Future<dynamic> receive_car(String contract_id,String receiver_id)async{
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'/api/receiveCar'));
    request.body = json.encode({
      "contract_id": contract_id,
      "receiver_id": receiver_id
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json=await response.stream.bytesToString();
      //print(json);
      return CarDeliver.fromJson(json).data;
    }
    else {
      return -1;
    }
  }
  // static Future<List<History>> get_history(String filter)async{
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //   };
  //   var request = http.Request('POST', Uri.parse(url+'/api/getHistory'));
  //   request.body = json.encode({
  //     "filter": filter
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var json=await response.stream.bytesToString();
  //     return HistoryList.fromJson(json).data;
  //   }
  //   else {
  //     return <History>[];
  //   }
  // }
  static Future<List<ContractImage>> get_contract_image(String contract_id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'/api/getContractImages'));
    request.body = json.encode({
      "contact_id": contract_id
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json=await response.stream.bytesToString();
      return ContractImageList.fromJson(json).data;
    }
    else {
      return <ContractImage>[];
    }
  }
  static Future<bool> delete_contract(String id)async{
    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/deleteContractWithImages'));
    request.fields.addAll({
      'id': id
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return true;
    }
    else {
    // print(response.reasonPhrase);
    return false;
    }
  }
  static Future<bool> internet()async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }else{
      return false;
    }
  }
  static Future<bool> upload_offLine_history(OfflineHistory offlineHistory) async {
    try {
      if (offlineHistory.id == -1) {
        int data_id = await deliver_car(offlineHistory.clientPhone, offlineHistory.carPlate, offlineHistory.contractNumber, offlineHistory.deliveredId.toString());
        //print(data_id);
        if (data_id == -1) {
          return false;
        }
        for (int i = 0; i < offlineHistory.media.length; i++) {
          bool added = await store_media(
              File(offlineHistory.media[i]), data_id.toString(), offlineHistory.mediaTypeId[i].toString(), "1");
          if (!added) {
            delete_contract(data_id.toString());
            return false;
          }
        }
        Global.offline_contract.remove(offlineHistory);
        Global.save_offline_contract();
      } else {
        await receive_car(
            offlineHistory.id.toString(), offlineHistory.receiverId.toString());
        for (int i = 0; i < offlineHistory.media.length; i++) {
          bool added = await store_media(
              File(offlineHistory.media[i]),
              offlineHistory.id.toString(),
              offlineHistory.mediaTypeId[i].toString(), "2");
          if (!added) {
            delete_contract(offlineHistory.id.toString());
            return false;
          }
        }
        Global.offline_contract.remove(offlineHistory);
        Global.save_offline_contract();
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}