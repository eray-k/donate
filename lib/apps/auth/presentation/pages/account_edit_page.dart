import 'package:donate/core/toolset/ui/ui_tools.dart';
import 'package:donate/core/ui/widgets/blood_type_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../dependency_injection.dart';
import '../../domain/repository/auth_repository.dart';
import '../controller/account_controller.dart';

class AccountEditPage extends ConsumerWidget {
  const AccountEditPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountData = ref.watch(accountRivProvider);
    final repository = sl<AuthRepository>();
    return Scaffold(
        appBar: AppBar(),
        body: accountData.when(
          data: (account) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Change blood type: '),
                    BloodTypeDropdown(
                      value: account.bloodType,
                      onChanged: (String? newValue) async {
                        repository.currentAccount!.bloodType = newValue!;
                        await repository.updateCurrentAccount();
                        ref.invalidate(accountRivProvider);
                      },
                    ),
                  ],
                ),
                verticalSpacer(32),
                ElevatedButton.icon(
                    onPressed: () {
                      repository.logout();
                      ref.invalidate(accountRivProvider);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'))
              ],
            ),
          ),
          error: (error, stackTrace) => Text('Error: ${error.toString()}'),
          loading: () => const CircularProgressIndicator(),
        ));
  }
}
