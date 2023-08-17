import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:barbershop/src/core/exceptions/service_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/auth/login/login_state.dart';
import 'package:barbershop/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);
    switch (result) {
      case Success():
        //buscar dados do usuario logado
        //fazer uma analise para qual o tipo do login
        ref.invalidate(getMeProvider);
        //!invalidando os caches para evitar o login com o usuario errado
        ref.invalidate(getMyBarbershopProvider);

        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case UserModelADM():
            state = state.copyWith(status: LoginStateStatus.admLogin);

          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandler.close();
  }
}
