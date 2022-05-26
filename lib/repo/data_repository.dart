import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:inovola_task/models/response_model.dart';
import 'package:http/http.dart' as http;

class DataRepository{

  static Map<String, String> headers() {
    Map<String, String> headerMap = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    return headerMap;
  }



  static Future<ResponseModel?> getData()async{
    try {
      String basUrl = 'https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34';
      final response = await http.get(Uri.parse(basUrl), headers: headers());
      if (response.statusCode >= 200 && response.statusCode < 300){
        final finalResponse = jsonDecode(response.body) as Map<String, dynamic>;
        log(finalResponse.toString());
        return ResponseModel.fromJson(finalResponse);
    }else{
        print('response code${response.statusCode}');
        return null;
      }
    }catch(error){
      print('error ${error.toString()}');
      return null;
    }

  }


}
