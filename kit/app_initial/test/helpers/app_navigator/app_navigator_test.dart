import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/forgot_password/views/views.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_navigator_test.mocks.dart';

@GenerateMocks([GoRouter])
void main() {
  late MockGoRouter mockGoRouter;
  late AppNavigator appNavigator;

  setUp(() {
    mockGoRouter = MockGoRouter();
    appNavigator = AppNavigator.instance;

    Router.instance.goRouter = mockGoRouter;
  });

  test('pushForgotPassword should call pushNamed with correct parameters',
      () async {
    const email = 'test@example.com';
    when(
      mockGoRouter.pushNamed<String>(
        any,
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer((_) async => null);

    await appNavigator.pushForgotPassword(email: email);

    verify(
      mockGoRouter.pushNamed<String>(
        ForgotPasswordScreen.path,
        queryParameters: {'email': email},
      ),
    ).called(1);
  });

  test(
      'pushForgotPassword should call pushNamed '
      'with an empty email if none is provided', () async {
    when(
      mockGoRouter.pushNamed<String>(
        any,
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer((_) async => null);

    await appNavigator.pushForgotPassword();

    verify(
      mockGoRouter.pushNamed<String>(
        ForgotPasswordScreen.path,
        queryParameters: {'email': ''},
      ),
    ).called(1);
  });
}
