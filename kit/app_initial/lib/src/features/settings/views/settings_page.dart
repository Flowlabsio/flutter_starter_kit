import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/settings/bloc/bloc.dart';
import 'package:app_initial/src/widgets/widgets.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    if (bottomPadding == 0) {
      bottomPadding = UISpacing.space4x;
    }

    var topPadding = MediaQuery.of(context).padding.top;
    if (topPadding == 0) {
      topPadding = UISpacing.space4x;
    }

    final buttonsProvider = Theme.of(context).buttonStyles;
    final colorsProvider = Theme.of(context).colors;
    final textStylesProvider = Theme.of(context).textStyles;

    final isDeletingAccount = context.select(
      (SettingsBloc bloc) => bloc.state.isDeletingAccount,
    );

    final l10n = context.l10n;

    final width = MediaQuery.of(context).size.width;

    var paddingBottom = MediaQuery.of(context).padding.bottom;

    if (paddingBottom == 0) {
      paddingBottom = UISpacing.space4x;
    }

    final isFetchingProviders = context.select(
      (SettingsBloc bloc) => bloc.state.isFetchingProviders,
    );

    final providers = context.select(
      (SettingsBloc bloc) => bloc.state.userProviders,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: UISpacing.space4x,
              ),
              child: Column(
                children: [
                  SizedBox(height: UISpacing.space4x),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                left: UISpacing.space4x,
                right: UISpacing.space4x,
                top: UISpacing.space4x,
                bottom: bottomPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ToggleButtonTheme(),
                  const SizedBox(height: UISpacing.space4x),
                  SizedBox(
                    width: UISpacing.infinity,
                    child: LoadingButton(
                      type: ButtonType.filled,
                      onPressed: () async {
                        final locale =
                            await CustomBottomModal.instance.show<Locale>(
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: UISpacing.space2x),
                              Container(
                                height: UISpacing.space1x,
                                width: width * 0.1,
                                decoration: BoxDecoration(
                                  color: colorsProvider.onPrimaryContainer,
                                  borderRadius: BorderRadius.circular(
                                    UISpacing.space1x,
                                  ),
                                ),
                              ),
                              const SizedBox(height: UISpacing.space3x),
                              ListTile(
                                title: Text(
                                  l10n.automatic,
                                  style: textStylesProvider.bodyLarge,
                                ),
                                onTap: () {
                                  context.pop(const Locale('none'));
                                },
                              ),
                              ListTile(
                                title: Text(
                                  l10n.settings_languageEnglish,
                                  style: textStylesProvider.bodyLarge,
                                ),
                                onTap: () {
                                  context.pop(const Locale('en'));
                                },
                              ),
                              ListTile(
                                title: Text(
                                  l10n.settings_languageSpanish,
                                  style: textStylesProvider.bodyLarge,
                                ),
                                onTap: () {
                                  context.pop(const Locale('es'));
                                },
                              ),
                              SizedBox(height: paddingBottom),
                            ],
                          ),
                        );

                        if (locale == null) return;

                        if (locale == const Locale('none')) {
                          await Preference.instance.setLocale(null);
                        } else {
                          await Preference.instance.setLocale(locale);
                        }
                      },
                      style: buttonsProvider.primaryFilled,
                      child: Text(l10n.settings_language),
                    ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  SizedBox(
                    width: UISpacing.infinity,
                    child: LoadingButton(
                      type: ButtonType.filled,
                      onPressed: () {
                        context.read<SettingsBloc>().add(SignOutSettings());
                      },
                      style: buttonsProvider.primaryFilled,
                      child: Text(l10n.signOut),
                    ),
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  SizedBox(
                    width: UISpacing.infinity,
                    child: LoadingButton(
                      type: ButtonType.filled,
                      isLoading: isDeletingAccount,
                      onPressed: isFetchingProviders || providers.isEmpty
                          ? null
                          : () async {
                              final bloc = context.read<SettingsBloc>();

                              final form = bloc.formDeleteAccount;

                              final provider = bloc.state.userProviders.first;

                              final wantsToDelete =
                                  await CustomDialog.instance.confirm(
                                title: Text(
                                  l10n.settings_titleConfirmDeleteAccount,
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      l10n.settings_messageConfirmDeleteAccount,
                                    ),
                                    if (provider ==
                                        AuthProvider.emailAndPassword) ...[
                                      const SizedBox(height: UISpacing.space4x),
                                      ReactiveForm(
                                        formGroup: form,
                                        child: Column(
                                          children: [
                                            ReactivePasswordField(
                                              formControlName: 'password',
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: InputDecoration(
                                                labelText: Localization
                                                    .instance.tr.password,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    style: buttonsProvider.primaryText,
                                    onPressed: () => context.pop(false),
                                    child: Text(l10n.cancel),
                                  ),
                                  FilledButton(
                                    style: buttonsProvider.primaryFilled,
                                    onPressed: () {
                                      if (provider ==
                                          AuthProvider.emailAndPassword) {
                                        if (!form.valid) {
                                          form.markAllAsTouched();
                                          return;
                                        }
                                      }

                                      context.pop(true);
                                    },
                                    child: Text(l10n.delete),
                                  ),
                                ],
                              );

                              if (wantsToDelete && context.mounted) {
                                context
                                    .read<SettingsBloc>()
                                    .add(DeleteAccount());
                              }
                            },
                      style: buttonsProvider.primaryFilled,
                      child: Text(l10n.deleteAccount),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
