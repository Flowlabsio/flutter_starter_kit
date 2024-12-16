import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/features/sign_up/bloc/bloc.dart';
import 'package:app_initial/src/widgets/widgets.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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

    final form = context.read<SignUpBloc>().form;

    final buttonsProvider = Theme.of(context).buttonStyles;
    final iconProvider = Theme.of(context).icons;
    final inputsProvider = Theme.of(context).inputStyles;

    final isSigningUp = context.select(
      (SignUpBloc bloc) => bloc.state.isSigningUp,
    );

    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signUp),
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
                  const SizedBox(height: UISpacing.space8x),
                  Hero(
                    tag: 'logo',
                    child: iconProvider.logo(size: UISpacing.space34x),
                  ),
                  const SizedBox(height: UISpacing.space8x),
                  ReactiveFormBuilder(
                    form: () => form,
                    builder: (context, form, child) {
                      return Column(
                        children: [
                          ReactiveTextField<String>(
                            formControlName: 'firstName',
                            textInputAction: TextInputAction.next,
                            decoration: inputsProvider.primary.copyWith(
                              labelText: l10n.firstName,
                            ),
                          ),
                          const SizedBox(height: UISpacing.space4x),
                          ReactiveTextField<String>(
                            formControlName: 'lastName',
                            textInputAction: TextInputAction.next,
                            decoration: inputsProvider.primary.copyWith(
                              labelText: l10n.lastName,
                            ),
                          ),
                          const SizedBox(height: UISpacing.space4x),
                          ReactiveTextField<String>(
                            keyboardType: TextInputType.emailAddress,
                            formControlName: 'email',
                            textInputAction: TextInputAction.next,
                            decoration: inputsProvider.primary.copyWith(
                              labelText: l10n.email,
                            ),
                          ),
                          const SizedBox(height: UISpacing.space4x),
                          ReactivePasswordField(
                            formControlName: 'password',
                            textInputAction: TextInputAction.next,
                            decoration: inputsProvider.primary.copyWith(
                              labelText: l10n.password,
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
                      );
                    },
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
                      isLoading: isSigningUp,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<SignUpBloc>()
                            .add(const SignUpWithEmailAndPassword());
                      },
                      style: buttonsProvider.primaryFilled,
                      child: Text(l10n.signUp),
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
