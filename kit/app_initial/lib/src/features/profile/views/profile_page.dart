import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/l10n/l10n.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/profile/bloc/bloc.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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

    final form = context.read<ProfileBloc>().form;

    final buttonsProvider = Theme.of(context).buttonStyles;
    final inputsProvider = Theme.of(context).inputStyles;
    final textsProvider = Theme.of(context).textStyles;
    final colorsProvider = Theme.of(context).colors;

    final isUpdatingData = context.select(
      (ProfileBloc bloc) => bloc.state.isUpdatingData,
    );

    final isUpdatingPhoto = context.select(
      (ProfileBloc bloc) => bloc.state.isUpdatingPhoto,
    );

    final photoBytes = context.select(
      (ProfileBloc bloc) => bloc.state.photoBytes,
    );

    final isFetchingPhoto = context.select(
      (ProfileBloc bloc) => bloc.state.isFetchingPhoto,
    );

    final l10n = context.l10n;

    final user = Auth.instance.user()!;

    final firstName = user.firstName;
    final lastName = user.lastName;

    final nameWasSet = firstName.isNotEmpty && lastName.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
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
                  Stack(
                    children: [
                      Container(
                        width: UISpacing.space30x,
                        height: UISpacing.space30x,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorsProvider.primaryContainer,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (
                            Widget child,
                            Animation<double> animation,
                          ) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                          child: isFetchingPhoto
                              ? const SizedBox(
                                  width: UISpacing.space15x,
                                  height: UISpacing.space15x,
                                  child: CircularProgressIndicator(
                                    strokeWidth: UISpacing.px2,
                                  ),
                                )
                              : photoBytes.isNotEmpty
                                  ? ClipOval(
                                      child: Image.memory(
                                        photoBytes,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    )
                                  : nameWasSet
                                      ? Center(
                                          child: Text(
                                            '${firstName[0]}${lastName[0]}'
                                                .toUpperCase(),
                                            style: textsProvider.headlineLarge,
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: UISpacing.space15x,
                                          ),
                                        ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: PopupMenuButton(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(
                            UISpacing.space10x,
                          ),
                          color: colorsProvider.surface,
                          padding: EdgeInsets.zero,
                          menuPadding: EdgeInsets.zero,
                          offset: const Offset(
                            -UISpacing.space2x,
                            UISpacing.space2x,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: ImageSource.gallery,
                              child: Text(l10n.gallery),
                            ),
                            PopupMenuItem(
                              value: ImageSource.camera,
                              child: Text(l10n.takePicture),
                            ),
                            if (photoBytes.isNotEmpty)
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(l10n.deletePicture),
                              ),
                          ],
                          onSelected: (value) async {
                            if (value is ImageSource) {
                              context
                                  .read<ProfileBloc>()
                                  .add(UpdateUserProfilePhoto(source: value));
                            }

                            if (value == 'delete') {
                              context
                                  .read<ProfileBloc>()
                                  .add(DeleteUserProfilePhoto());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorsProvider.onPrimary,
                                width: UISpacing.px2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: UISpacing.space5x,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (
                                  Widget child,
                                  Animation<double> animation,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                child: isUpdatingPhoto
                                    ? const SizedBox(
                                        height: UISpacing.space5x,
                                        width: UISpacing.space5x,
                                        child: CircularProgressIndicator(
                                          strokeWidth: UISpacing.px2,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.edit,
                                        size: UISpacing.space5x,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: UISpacing.space4x),
                  ReactiveForm(
                    formGroup: form,
                    child: Column(
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
                      isLoading: isUpdatingData,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<ProfileBloc>().add(ProfileUpdate());
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
