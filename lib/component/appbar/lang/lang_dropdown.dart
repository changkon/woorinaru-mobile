import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woorinaru/service/auth/token_service.dart';
import 'package:woorinaru/service/storage/localstorage_service.dart';
import 'package:woorinaru/theme/localization/app_localizations.dart';
import 'package:woorinaru/theme/localization/localization_model.dart';

class LangDropDown extends StatelessWidget {
  void _showLanguageDropdown(BuildContext context) {
    Map<String, dynamic> locales = AppLocalizations.SUPPORTED_LOCALES_DISPLAY;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView.builder(
          itemCount: locales.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                // Retrieve locale
                Locale selectedLocale = AppLocalizations.SUPPORTED_LOCALES[index];
                Provider.of<LocalizationModel>(context, listen: false)
                    .setLocale(selectedLocale);
                Provider.of<TokenService>(context, listen: false).localStorageService.saveLocale(selectedLocale.languageCode);
                Navigator.of(context).pop();
              },
              leading: SvgPicture.asset(
                'assets/icons/${locales.entries.elementAt(index).value}',
                height: 30,
                width: 30,
              ),
              title: Text(locales.entries.elementAt(index).key),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/bx-world.svg',
        color: Colors.white,
      ),
      onPressed: () => _showLanguageDropdown(context),
    );
  }
}
