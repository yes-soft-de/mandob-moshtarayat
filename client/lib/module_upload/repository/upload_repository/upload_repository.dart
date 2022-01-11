import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/module_upload/response/imgbb/imgbb_response.dart';
import 'package:mandob_moshtarayat/utils/logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

@injectable
class UploadRepository {
  Future<ImgBBResponse?> upload(String filePath) async {
    var client = Dio();
    MultipartFile? multi;
    if (kIsWeb) {
      var file = await XFile(filePath).readAsBytes();
      multi = MultipartFile.fromBytes(file,
          filename: DateTime.now().toIso8601String() + '-image');
    }
    FormData data = FormData.fromMap({
      'image':kIsWeb ? multi : await MultipartFile.fromFile(filePath),
    });

    Logger().info('UploadRepo', 'Uploading: ' + filePath);
    try {
      Response? response = await client.post(
        Urls.UPLOAD_API,
        data: data,
      );
      Logger().info('Got a Response', response.toString());
      return ImgBBResponse(url: response.data);
    } catch (e) {
      return null;
    }
  }
}
