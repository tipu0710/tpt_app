import 'package:dio/dio.dart';
import 'package:ftp_app/global.dart';
import 'package:ftp_app/model/data_model.dart';
import 'package:ftp_app/model/encrypt_model.dart';

class ApiService {
  static String baseUrl = "https://onecalltest.tfp.com.my";

  static Future<DataModel> getMethod(String endPoints) async {
    Dio dio = new Dio();

    try {
      Response response = await dio.get(_fullUrl(endPoints));
      EncryptModel model = EncryptModel.fromJson(response.data);
      return getDecryptedData(model.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.request);
        print(e.message);
      }
      throw e;
    }
  }

  static String _fullUrl(String endpoint) {
    return baseUrl + ":" + endpoint;
  }
}
