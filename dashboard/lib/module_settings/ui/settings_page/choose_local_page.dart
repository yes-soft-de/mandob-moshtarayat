import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_settings/widget/language_button.dart';
import 'package:mandob_moshtarayat_dashboad/module_splash/splash_routes.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/images/images.dart';

@injectable
class ChooseLocalScreen extends StatefulWidget {
  final LocalizationService _localizationService;
  const ChooseLocalScreen(
    this._localizationService,
  );

  @override
  _ChooseLocalScreenState createState() => _ChooseLocalScreenState();
}

class _ChooseLocalScreenState extends State<ChooseLocalScreen> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Scaffold(
        body: FixedContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: Image.asset(
                ImageAsset.LANGUAGE,
                width: 75,
                height: 75,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(S.of(context).preferredLanguage,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(S.of(context).selectLanguage,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //rgb(236,239,241)
                color: const Color.fromRGBO(236, 239, 241, 1),
              ),
              child: Column(
                children: [
                  Container(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
                      widget._localizationService.setLanguage('en');
                    },
                    child: LanguageButton(
                      image: ImageAsset.ENGLISH_LANGUAGE,
                      textLang: 'English',
                      active: myLocale.languageCode == 'en',
                    ),
                  ),
                  Container(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
                      widget._localizationService.setLanguage('ar');
                    },
                    child: LanguageButton(
                      image: ImageAsset.ARAB_LANGUAGE,
                      textLang: 'العربية',
                      active: myLocale.languageCode == 'ar',
                    ),
                  ),
                  Container(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).next,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SplashRoutes.SPLASH_SCREEN, (route) => false);
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
