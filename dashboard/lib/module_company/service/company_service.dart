import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/manager/company_manager.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_finance_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/model/company_price.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/create_company_profile.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/delivery_company_financial.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/financial_compensation_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/company_delivery_price_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/company_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/financial_compensations_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/model/stores_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/response/stores_response.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/status_code_helper.dart';

@injectable
class CompanyService {
  final CompanyManager _companyManager;

  CompanyService(this._companyManager);

  Future<DataModel> getCompanyProfile() async {
    CompanyProfileResponse? _companyResponse =
        await _companyManager.getCompanyProfile();
    if (_companyResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_companyResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_companyResponse.statusCode));
    }
    if (_companyResponse.data == null) return DataModel.empty();
    return CompanyProfileModel.withData(_companyResponse.data!);
  }

  Future<DataModel> getFinancialCompany() async {
    FinancialCompensationsResponse? _companyResponse =
        await _companyManager.getFinancialCompany();
    if (_companyResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_companyResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_companyResponse.statusCode));
    }
    if (_companyResponse.data == null) return DataModel.empty();
    return CompanyFinanceModel.withData(_companyResponse.data![0]);
  }

  Future<DataModel> getDeliveryPrice() async {
    CompanyDeliveryPriceResponse? _companyResponse =
        await _companyManager.getDeliveryPrice();
    if (_companyResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_companyResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_companyResponse.statusCode));
    }
    if (_companyResponse.data == null) return DataModel.empty();
    return CompanyDeliveryPriceModel.withData(_companyResponse.data!);
  }

  Future<DataModel> createCompanyProfile(CreateCompanyProfile request) async {
    ActionResponse? actionResponse =
        await _companyManager.createCompanyProfile(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> UpdateCompanyProfile(CreateCompanyProfile request) async {
    ActionResponse? actionResponse =
        await _companyManager.updateCompanyProfile(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> createCompanyFinancial(
      FinancialCompensationRequest request) async {
    ActionResponse? actionResponse =
        await _companyManager.createFinancialCompany(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCompanyFinancial(
      FinancialCompensationRequest request) async {
    ActionResponse? actionResponse =
        await _companyManager.updateFinancialCompany(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> createDeliveryPrice(
      DeliveryCompanyFinancialRequest request) async {
    ActionResponse? actionResponse =
        await _companyManager.createDeliveryPrice(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateDeliveryPrice(
      DeliveryCompanyFinancialRequest request) async {
    ActionResponse? actionResponse =
        await _companyManager.updateDeliveryPrice(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}
