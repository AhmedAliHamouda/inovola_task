import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inovola_task/models/response_model.dart';
import 'package:inovola_task/repo/data_repository.dart';

final dataRiverPod = ChangeNotifierProvider<DataRiverPod>((ref) => DataRiverPod());

class DataRiverPod extends ChangeNotifier {

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  ResponseModel? responseModel;

  Future<void> getData()async{
    loading=true;
   final response =await DataRepository.getData();
   if(response !=null){
     responseModel=response;
     loading=false;
   }else{
     loading=false;
   }
  }
}
