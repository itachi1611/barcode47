import 'package:flutter/material.dart';
import 'package:myapp/app/app_provider.dart';
import 'package:myapp/common/app_extension.dart';
import 'package:myapp/common/app_images.dart';
import 'package:myapp/generated/l10n.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  // Helper method to build the theme selection text
  String _getThemeText(BuildContext context, ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return S.of(context).light_mode;
      case ThemeMode.dark:
        return S.of(context).dark_mode;
      default:
        return S.of(context).system_default;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final currentLangCode = appProvider.locale.languageCode;
    final currentThemeMode = appProvider.themeMode;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).setting)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Language Setting ---
            Row(
              children: [
                Expanded(flex: 3, child: Text(S.of(context).language)),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      _langToggle(
                        context,
                        currentLangCode == 'en',
                      ),
                      const SizedBox(width: 8),
                      _langToggle(
                        context,
                        currentLangCode == 'vi',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24), // Spacer
            // --- Theme Setting ---
            Text(
              S.of(context).appearance,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            RadioGroup<ThemeMode>(
              groupValue: currentThemeMode,
              onChanged: (value) {
                if (value != null) {
                  appProvider.setThemeMode(value);
                }
              },
              child: Column(
                children: ThemeMode.values
                    .map(
                      (themeMode) => RadioListTile<ThemeMode>(
                        title: Text(_getThemeText(context, themeMode)),
                        value: themeMode,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _langToggle(BuildContext mCtx, bool isSelected) {
    final appProvider = mCtx.read<AppProvider>();
    return Expanded(
      flex: 1,
      child: Switch(
        thumbIcon:
            WidgetStateProperty<Icon>.fromMap(<WidgetStatesConstraint, Icon>{
              WidgetState.selected: Icon(Icons.check),
              WidgetState.any: Icon(Icons.close),
            }),
        activeThumbImage: AssetImage('vi'.flag),
        inactiveThumbImage: AssetImage('en'.flag),
        value: isSelected,
        activeColor: Colors.red,
        onChanged: (toggle) {
          appProvider.setLocale(
            toggle ? const Locale('vi') : const Locale('en'),
          );
        },
      ),
    );

    // return Expanded(
    //   flex: 1,
    //   child: InkWell(
    //     onTap: () {
    //       // Update to set locale directly instead of toggling
    //       if (imgPath == AppImages.us) {
    //         appProvider.setLocale(const Locale('en'));
    //       } else {
    //         appProvider.setLocale(const Locale('vi'));
    //       }
    //     },
    //     child: AnimatedContainer(
    //       height: 40,
    //       padding: const EdgeInsets.all(8),
    //       duration: const Duration(milliseconds: 350),
    //       curve: Curves.easeInOut,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8),
    //         color: isSelected
    //             ? Theme.of(context).colorScheme.primaryContainer
    //             : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
    //         border: Border.all(
    //           color: isSelected
    //               ? Theme.of(context).colorScheme.primary
    //               : Colors.grey,
    //           width: isSelected ? 2.0 : 1.0,
    //         ),
    //       ),
    //       child: Image.asset(imgPath),
    //     ),
    //   ),
    // );
  }
}
