import 'package:flutter/material.dart';
import 'package:myapp/app/app_provider.dart';
import 'package:myapp/common/app_images.dart';
import 'package:myapp/generated/l10n.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final currentLangCode = appProvider.locale.languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).setting)),
      body: Row(
        children: [
          Expanded(flex: 3, child: Text(S.of(context).language)),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _langToggle(context, currentLangCode == 'en', AppImages.us),
                _langToggle(context, currentLangCode == 'vi', AppImages.vn),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _langToggle(BuildContext mCtx, bool isSelected, String imgPath) {
    final appProvider = mCtx.read<AppProvider>();
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          appProvider.toggleLocale();
        },
        child: AnimatedContainer(
          height: 40,
          width: 80,
          padding: const EdgeInsets.all(10),
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isSelected ? Colors.grey : Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: Image.asset(imgPath),
        ),
      ),
    );
  }
}
