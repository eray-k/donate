import 'package:donate/apps/auth/domain/model/account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../dependency_injection.dart';
import '../../domain/repository/auth_repository.dart';

part 'account_controller.g.dart';

@riverpod
class AccountRiv extends _$AccountRiv {
  @override
  FutureOr<Account> build() {
    return sl<AuthRepository>().getCurrentAccount();
  }
}
