import 'package:barbershop/src/core/exceptions/auth_exception.dart';
import 'package:barbershop/src/core/fp/either.dart';
import 'package:barbershop/src/model/user_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/nil.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String name, String email, String password}) userData);
}
