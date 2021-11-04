import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_our_services/repository/services_repository.dart';
import 'package:mandob_moshtarayat/module_our_services/request/private_order_request.dart';
import 'package:mandob_moshtarayat/module_our_services/request/send_it_request.dart';
import 'package:mandob_moshtarayat/module_our_services/response/sendItResponse.dart';

@injectable
class ServicesManager {
  final ServicesRepository _servicesRepository;

  ServicesManager(this._servicesRepository);

  Future<SendItResponse?> sendItClintOrder(SendItRequest request) =>
      _servicesRepository.sendItClintOrder(request);
  Future<SendItResponse?> postPrivateOrder(PrivateOrderRequest request) =>
      _servicesRepository.postPrivateOrder(request);
}
