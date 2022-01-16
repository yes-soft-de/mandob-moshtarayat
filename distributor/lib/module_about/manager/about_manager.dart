import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_about/repository/about_repository.dart';

@injectable
class AboutManager {
  final AboutRepository _aboutRepository;
  AboutManager(this._aboutRepository);
}