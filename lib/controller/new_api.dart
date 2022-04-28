import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:vip_delivery_version_1/const/global.dart';
import 'package:vip_delivery_version_1/model/car-deliver.dart';
import 'package:vip_delivery_version_1/model/chauffer.dart';
import 'package:vip_delivery_version_1/model/history.dart';
import 'package:vip_delivery_version_1/model/mediatype.dart';
import 'package:vip_delivery_version_1/model/offline_history.dart';

class NewApi {
  static String cookie="";

  static String url = "https://phpstack-548447-2577144.cloudwaysapps.com";

  static Future<List<Media>> getMedia() async {
    var headers = {
      'cookie': cookie
    };
    var request = http.Request('GET', Uri.parse(url + '/api/media-type'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      print(jsonString);
      var list = jsonDecode(jsonString) as List;
      List<Media> mediaList = <Media>[];
      for(int i=0;i<list.length;i++){
        mediaList.add(Media.fromMap(list[i]));
      }
      return mediaList;

    }
    else {
     return <Media>[];
    }
  }

  static Future<List<Chauffeur>> getChauffeur() async {
    var headers = {
      'cookie': cookie
    };
    var request = http.Request('GET', Uri.parse(url + '/api/driver'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      print(jsonString);
      var list = jsonDecode(jsonString) as List;
      List<Chauffeur> chefrs = <Chauffeur>[];
      for(int i=0;i<list.length;i++){
        chefrs.add(Chauffeur.fromMap(list[i]));
      }
      return chefrs;
    }
    else {
      return <Chauffeur>[];
    }
  }

  static Future deliverContract(String clientPhone, String carPlate, String contractNumber, String clientName,String deliveredId )async{
    var headers = {
      'Content-Type': 'application/json',
      'cookie': cookie
    };
    var request = http.Request('POST', Uri.parse(url + '/api/contract'));
    request.body = json.encode({
      "client_phone": clientPhone,
      "car_plate": carPlate,
      "contract_number": contractNumber,
      "client_name": clientName,
      "delivered_id" : deliveredId,
      'cookie': cookie
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      // CarDeliver d = CarDeliver.fromJson(json);
      var data = jsonDecode(json);
      print('Success');
      return data['insertId'];
    }
    else {
      print('Field');
      return -1;
    }


  }

  static Future storeMedia(File carImage, String mediaType, String contractId, String state)async{
    print('media type id from storeMedia function : $mediaType');
    var headers = {
      'cookie': cookie
    };
    var request = http.MultipartRequest('POST', Uri.parse(url + '/api/store-media'));
    request.fields.addAll({
      'media_type_id': mediaType,
      'contract_id': contractId,
      'state': state,
      'cookie': cookie
    });

    request.files.add(await http.MultipartFile.fromPath('file', carImage.path));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success upload media');
      return true;
    }
    else {
      return false;
    }

  }

  static Future receiveContract(String receiveId, String id) async {
    var headers = {
      'Content-Type': 'application/json',
      'cookie': cookie
    };
    var request = http.Request('PUT', Uri.parse(url + '/api/contract'));
    request.body = json.encode({
      "receiver_id": receiveId,
      "id": id
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      var json = await response.stream.bytesToString();
      return 1 ;
    }
    else {
      return -1;
    }

  }

  static Future login(String username, String password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + '/api/user-login'));
    request.body = json.encode({
      "username": username,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      cookie=response.headers["set-cookie"].toString();
      var json=await response.stream.bytesToString();
      print(json);
      return true;
    }
    else {
      return false;
    }

  }

  static Future<List<History>> filter(String clientPhone, String carPlate, String contractNumber) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': cookie
    };
    var request = http.Request('POST', Uri.parse(NewApi.url + '/api/contract-filter'));
    request.body = json.encode({
      "client_phone": clientPhone,
      "car_plate": carPlate,
      "contract_number": contractNumber
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      print(jsonString);
      var list = jsonDecode(jsonString) as List;
      List<History> historyList = <History>[];
      for(int i=0;i<list.length;i++){
        historyList.add(History.fromMap(list[i]));
      }
      return historyList;    }
    else {
      return <History>[];
    }
  }

  static Future<List<History>> filterInProgress(String clientPhone, String carPlate, String contractNumber) async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': cookie
    };
    var request = http.Request('POST', Uri.parse(NewApi.url + '/api/contract-in-progress'));
    request.body = json.encode({
      "client_phone": clientPhone,
      "car_plate": carPlate,
      "contract_number": contractNumber
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      print(jsonString);
      var list = jsonDecode(jsonString) as List;
      List<History> historyList = <History>[];
      for(int i=0;i<list.length;i++){
        historyList.add(History.fromMap(list[i]));
      }
      return historyList;    }
    else {
      return <History>[];
    }
  }

  static Future<bool> upload_offLine_history(OfflineHistory offlineHistory) async {
    print('offline history id ---------------- : ${offlineHistory.id}');
    try {
      if (offlineHistory.id == -1) {
        int data_id = await deliverContract(offlineHistory.clientPhone, offlineHistory.carPlate, offlineHistory.contractNumber, offlineHistory.clientName, offlineHistory.deliveredId.toString());
        if (data_id == -1) {
         return false;
        }
        for (int i = 0; i < offlineHistory.media.length; i++) {
          print('upload media -----------------------');
          bool added = await storeMedia(
              File(offlineHistory.media[i]), offlineHistory.mediaTypeId[i].toString(), data_id.toString(),"1");
          print('Added: $added');
          if (!added) {
           // delete_contract(data_id.toString());
            print('Not uploaded');
            return false;
          }
        }
        Global.save_offline_contract();
        Global.offline_contract.remove(offlineHistory);
      } else {
        var result = await receiveContract(offlineHistory.receiverId.toString() ,offlineHistory.id.toString());
        print(result);
        for (int i = 0; i < offlineHistory.media.length; i++) {
          bool added = await storeMedia(
              File(offlineHistory.media[i]),
              offlineHistory.mediaTypeId[i].toString(),
              offlineHistory.id.toString(),
              "2");
          if (!added) {
          //  delete_contract(offlineHistory.id.toString());
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



}