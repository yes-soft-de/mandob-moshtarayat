import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/manager/upload_manager/upload_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/response/imgbb/imgbb_response.dart';

@injectable
class ImageUploadService {
  final UploadManager _manager;

  ImageUploadService(this._manager);

  Future<String?> uploadImage(String? filePath) async {
    if (filePath != null && filePath != '') {
      ImgBBResponse? response = await _manager.upload(filePath);
      if (response == null) {
        return null;
      } else {
        return response.url;
      }
    }
    return null;
  }
}
