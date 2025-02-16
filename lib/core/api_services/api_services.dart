import 'package:dio/dio.dart';
import 'package:e_commerce/core/api_services/sensitive_data.dart';
// import 'package:e_commerce/core/api_services/sensitive_data.dart';

class ApiServices {

  final Dio dio = Dio(BaseOptions(
      baseUrl: "https://vcavegqzgqjyitygssps.supabase.co/rest/v1/",
      headers: {
        "apikey":
            SensitiveData.anon
      }
      ));
  Future<Response>getData(String path)async{
     return await dio.get(path);
  }
  Future<Response>postData(String path,Map<String,dynamic>data)async{
    return await dio.post(path,data: data);
  }
  Future<Response>patchData(String path,Map<String,dynamic>data)async{
    return await dio.patch(path,data: data);
  }
  Future<Response>deleteData(String path)async{
    return await dio.delete(path);
  }
}
