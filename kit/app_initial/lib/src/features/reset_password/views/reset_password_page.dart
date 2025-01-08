import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/reset_password/bloc/bloc.dart';
import 'package:app_initial/src/widgets/widgets.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    if (bottomPadding == 0) {
      bottomPadding = UISpacing.space4x;
    }

    final form = context.read<ResetPasswordBloc>().form;

    final buttonsProvider = Theme.of(context).buttonStyles;
    final inputsProvider = Theme.of(context).inputStyles;

    final isResetPassword = context.select(
      (ResetPasswordBloc bloc) => bloc.state.isResetPassword,
    );

    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.forgotPassword_title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UISpacing.space4x,
              ),
              child: Column(
                children: [
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveForm(
                    formGroup: form,
                    child: Column(
                      children: [
                        ReactivePasswordField(
                          formControlName: 'password',
                          textInputAction: TextInputAction.next,
                          decoration: inputsProvider.primary.copyWith(
                            labelText: l10n.password,
                          ),
                        ),
                        const SizedBox(height: UISpacing.space4x),
                        ReactivePasswordField(
                          formControlName: 'newPassword',
                          textInputAction: TextInputAction.next,
                          decoration: inputsProvider.primary.copyWith(
                            labelText: l10n.settings_newPassword,
                          ),
                        ),
                        const SizedBox(height: UISpacing.space4x),
                        ReactivePasswordField(
                          formControlName: 'repeatPassword',
                          textInputAction: TextInputAction.done,
                          decoration: inputsProvider.primary.copyWith(
                            labelText: l10n.repeatPassword,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  SizedBox(
                    width: UISpacing.infinity,
                    child: LoadingButton(
                      type: ButtonType.filled,
                      isLoading: isResetPassword,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<ResetPasswordBloc>()
                            .add(SubmitResetPassword());
                      },
                      style: buttonsProvider.primaryFilled,
                      child: Text(l10n.save),
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
