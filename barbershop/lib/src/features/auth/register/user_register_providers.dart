import 'package:barbershop/src/core/providers/application_providers.dart';
import 'package:barbershop/src/services/service_register/user_register_adm_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../services/service_register/user_register_adm_service_impl.dart';
part 'user_register_providers.g.dart';

@riverpod
UserRegisterAdmService userRegisterAdmService(UserRegisterAdmServiceRef ref) =>
    UserRegisterAdmServiceImpl(
        userRepository: ref.watch(userRepositoryProvider),
        userLoginService: ref.watch(userLoginServiceProvider));
