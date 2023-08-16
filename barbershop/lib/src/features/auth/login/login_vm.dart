import 'package:asyncstate/class/async_loader_handler.dart';
import 'package:barbershop/src/core/exceptions/service_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/features/auth/login/login_state.dart';
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
        break;
      case Failure(exception : ServiceException(: final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,  
        );
    }
    loaderHandler.close();
  }
}
