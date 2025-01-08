import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BiometricSwitcher extends StatefulWidget {
  const BiometricSwitcher({super.key});

  @override
  State<BiometricSwitcher> createState() => _BiometricSwitcherState();
}

class _BiometricSwitcherState extends State<BiometricSwitcher> {
  late bool isBiometricActive;

  @override
  void initState() {
    super.initState();
    isBiometricActive = Security.instance.isSafeActive;
  }

  void updateBiometricStatus({required bool value}) {
    setState(() {
      isBiometricActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var paddingBottom = MediaQuery.of(context).padding.bottom;
    if (paddingBottom == 0) {
      paddingBottom = UISpacing.space4x;
    }

    final colorsProvider = Theme.of(context).colors;
    final buttonsProvider = Theme.of(context).buttonStyles;
    final textsProvider = Theme.of(context).textStyles;

    final l10n = context.l10n;

    final width = MediaQuery.of(context).size.width;

    return Switch(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      value: isBiometricActive,
      activeColor: colorsProvider.surfaceDim,
      onChanged: (bool value) async {
        updateBiometricStatus(value: value);

        try {
          if (value) {
            final accept = await CustomDialog.instance.confirm(
              title: Text(l10n.biometricSwitcher_activate),
              content: Text(l10n.biometricSwitcher_activateConfirmation),
              actions: [
                TextButton(
                  style: buttonsProvider.primaryText,
                  onPressed: () => context.pop(false),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  style: buttonsProvider.primaryFilled,
                  onPressed: () => context.pop(true),
                  child: Text(l10n.yes),
                ),
              ],
            );

            if (!context.mounted) return;

            if (!accept) throw CancelOperation();

            final isSupported = await SecurityHelper.instance.unlockSupported();

            if (!isSupported) {
              CustomSnackbar.instance.error(
                text: l10n.biometricSwitcher_notSupported,
              );
              return;
            }

            final frequency = await CustomBottomModal.instance.show<int>(
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: UISpacing.space2x),
                  Container(
                    height: UISpacing.space1x,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: colorsProvider.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(UISpacing.space1x),
                    ),
                  ),
                  const SizedBox(height: UISpacing.space3x),
                  for (final option in [
                    {
                      'label': l10n.always,
                      'value': 0,
                    },
                    {
                      'label': l10n.biometricSwitcher_every15Seconds,
                      'value': 15,
                    },
                    {
                      'label': l10n.biometricSwitcher_every30Seconds,
                      'value': 30,
                    },
                    {
                      'label': l10n.biometricSwitcher_everyMinute,
                      'value': 60,
                    },
                    {
                      'label': l10n.biometricSwitcher_every2Minutes,
                      'value': 120,
                    },
                    {
                      'label': l10n.biometricSwitcher_every5Minutes,
                      'value': 300,
                    },
                    {
                      'label': l10n.biometricSwitcher_every15Minutes,
                      'value': 900,
                    },
                    {
                      'label': l10n.biometricSwitcher_everyHour,
                      'value': 3600,
                    },
                    {
                      'label': l10n.biometricSwitcher_everyDay,
                      'value': 86400,
                    },
                  ])
                    ListTile(
                      title: Text(
                        option['label']! as String,
                        style: textsProvider.bodyLarge,
                      ),
                      onTap: () => context.pop(option['value']),
                    ),
                  SizedBox(height: paddingBottom),
                ],
              ),
              isScrollControlled: true,
            );

            if (frequency == null) throw CancelOperation();

            final isAuthenticated = await SecurityHelper.instance.authenticate(
              localizedReason: l10n.biometricSwitcher_activateAuthReason,
            );

            if (!isAuthenticated) throw CancelOperation();

            await Security.instance.setSecurity(
              frequencyLocked: Parameter(frequency),
              lastUnlockAt: DateTime.now(),
              wasUnlocked: true,
            );
          } else {
            final accept = await CustomDialog.instance.confirm(
              title: Text(l10n.biometricSwitcher_deactivate),
              content: Text(l10n.biometricSwitcher_deactivateConfirmation),
              actions: [
                TextButton(
                  style: buttonsProvider.primaryText,
                  onPressed: () => context.pop(false),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  style: buttonsProvider.primaryFilled,
                  onPressed: () => context.pop(true),
                  child: Text(l10n.yes),
                ),
              ],
            );

            if (!context.mounted) return;

            if (!accept) throw CancelOperation();

            final isAuthenticated = await SecurityHelper.instance.authenticate(
              localizedReason: l10n.biometricSwitcher_deactivateAuthReason,
            );

            if (!isAuthenticated) throw CancelOperation();

            await Security.instance.removeSecurity();
          }
        } on CancelOperation {
          updateBiometricStatus(value: !value);
        } catch (e, s) {
          CustomSnackbar.instance.error(
            text: l10n.generalError,
          );
          if (context.mounted) {
            updateBiometricStatus(value: !value);
          }
          AppLogger.error(e.toString(), stackTrace: s);
        }
      },
    );
  }
}
