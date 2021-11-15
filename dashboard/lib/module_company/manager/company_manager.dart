import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/response/response.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/repository/company_repository.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/create_company_profile.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/delivery_company_financial.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/request/financial_compensation_request.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/company_delivery_price_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/company_profile_response.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/response/financial_compensations_response.dart';

@injectable
class CompanyManager {
  final CompanyRepository _companyRepository;

  CompanyManager(this._companyRepository);

  Future<CompanyProfileResponse?> getCompanyProfile() =>
      _companyRepository.getProfileCompany();

  Future<FinancialCompensationsResponse?> getFinancialCompany() =>
      _companyRepository.getFinancialCompensations();

  Future<CompanyDeliveryPriceResponse?> getDeliveryPrice() =>
      _companyRepository.getDeliveryPrice();

  Future<ActionResponse?> createCompanyProfile(CreateCompanyProfile request) =>
      _companyRepository.createCompanyProfile(request);

  Future<ActionResponse?> updateCompanyProfile(CreateCompanyProfile request) =>
      _companyRepository.updateCompanyProfile(request);

  Future<ActionResponse?> createFinancialCompany(
          FinancialCompensationRequest request) =>
      _companyRepository.updateFinancialCompany(request, true);

  Future<ActionResponse?> updateFinancialCompany(
          FinancialCompensationRequest request) =>
      _companyRepository.updateFinancialCompany(request, false);

  Future<ActionResponse?> createDeliveryPrice(
          DeliveryCompanyFinancialRequest request) =>
      _companyRepository.updateFinancialDeliveryPriceCompany(request, true);

  Future<ActionResponse?> updateDeliveryPrice(
          DeliveryCompanyFinancialRequest request) =>
      _companyRepository.updateFinancialDeliveryPriceCompany(request, false);
}
