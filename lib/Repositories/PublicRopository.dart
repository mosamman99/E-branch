import 'package:ebranch/Helpers/Config.dart';
import 'package:ebranch/Helpers/HelperFunctions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PublicRopository{
  static Future<Map> repo(String endPoint,String type,{formData})async{
    print(Config.setApi("$endPoint"));
    String jwt = await getSavedString("jwt", "");
    print("hjbhjbh   $jwt");
    http.Response response = type=="post"?await http.post(Config.setApi("$endPoint"),body: formData,headers: {"Authorization": "Bearer $jwt"}):await http.get(Config.setApi("$endPoint"),headers: {"Authorization": "Bearer $jwt"});
    print(response.body);
    Map mapResponse = jsonDecode(response.body);
    return mapResponse;
  }


}