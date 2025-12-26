import 'package:flutter/material.dart';
import 'package:myapp/app/app_provider.dart';
import 'package:myapp/common/app_extension.dart';
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _langToggle(context, currentLangCode == 'en'),
                      const SizedBox(width: 8),
                      _langToggle(context, currentLangCode == 'vi'),
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

            // Corrected implementation of RadioListTile
            ...ThemeMode.values.map((themeMode) => RadioListTile<ThemeMode>(
                  title: Text(_getThemeText(context, themeMode)),
                  value: themeMode,
                  groupValue: currentThemeMode,
                  onChanged: (value) {
                    if (value != null) {
                      appProvider.setThemeMode(value);
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  // Updated language toggle widget from remote
  Widget _langToggle(BuildContext mCtx, bool isSelected) {
    final appProvider = mCtx.read<AppProvider>();
    final locale = isSelected ? const Locale('en') : const Locale('vi');

    // This is a simplified toggle logic, assuming only 'en' and 'vi'.
    // It might need adjustment if more languages are added.
    return Expanded(
      flex: 1,
      child: Switch(
        thumbIcon:
            WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(Icons.check);
          }
          return const Icon(Icons.close);
        }),
        activeThumbImage: AssetImage(isSelected ? 'en'.flag : 'vi'.flag),
        inactiveThumbImage: AssetImage(isSelected ? 'vi'.flag : 'en'.flag),
        value: isSelected,
        activeColor: Colors.red,
        onChanged: (toggle) {
          // When the 'en' switch is tapped, toggle is true, set 'en'.
          // When the 'vi' switch is tapped, toggle is true, set 'vi'.
          // This logic seems a bit complex. A simpler approach would be
          // to have one switch, or two buttons.
          // For now, let's make it work as intended.
          if (isSelected) { // This is the 'en' switch
             appProvider.setLocale(const Locale('en'));
          } else { // This is the 'vi' switch
             appProvider.setLocale(const Locale('vi'));
          }
        },
      ),
    );
  }
}
