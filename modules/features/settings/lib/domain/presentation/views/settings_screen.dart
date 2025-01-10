import 'package:core/styles/strings.dart';
import 'package:core/styles/style.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings/data/models/language_model.dart';
import 'package:settings/settings.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/presentation/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(string.of(context).settings),
      ),
      body: Backdrop(
        child: SafeArea(
          bottom: false,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              _LanguageSection(
                key: ValueKey('language_section'),
              ),
              _ThemeSection(
                key: ValueKey('theme_section'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      decoration: style.defaultDecoration(context),
      header: Text(string.of(context).language),
      children: LanguageModel.values
          .map(
            (language) => RadioListTile<LanguageModel>(
              key: ValueKey(language.name),
              title: Text(
                language.displayName,
                style: theme.textTheme.titleSmall,
              ),
              value: language,
              groupValue: sl<Settings>().language,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => sl<Settings>().language = language,
            ),
          )
          .toList(),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      header: Text(string.of(context).thememode),
      decoration: style.defaultDecoration(context),
      children: ThemeMode.values
          .map(
            (mode) => RadioListTile(
              key: ValueKey(mode.name),
              title: Text(
                mode.name.capitalize,
                style: theme.textTheme.titleSmall,
              ),
              value: mode,
              groupValue: sl<Settings>().theme,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => sl<Settings>().theme = mode,
            ),
          )
          .toList(),
    );
  }
}
