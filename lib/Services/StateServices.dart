import 'dart:convert';

import 'package:covid_tracker_app_flutter/Services/Utils/app_url.dart';
import 'package:http/http.dart'as http;
import 'package:covid_tracker_app_flutter/Model/world_states_model.dart';
class StateServices{

  Future<WorldStatesModel> fetchworkedStatesRecord()async{
      final response=await http.get(Uri.parse(AppUrl.worldStatesApi));

      if(response.statusCode==200){
        var data =jsonDecode(response.body.toString());
        return WorldStatesModel.fromJson(data);

      }
      else{
        throw Exception("not fetching data");
      }
  }
  Future<List<dynamic>> countriesListApi()async{
    final response=await http.get(Uri.parse(AppUrl.countryList));

    if(response.statusCode==200){
      var data =jsonDecode(response.body.toString());
      return data;

    }
    else{
      throw Exception("error");
    }
  }
}