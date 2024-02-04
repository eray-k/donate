import 'package:donate/apps/auth/domain/repository/auth_repository.dart';
import 'package:donate/apps/auth/presentation/widgets/my_circle_avatar.dart';
import 'package:donate/apps/auth/presentation/controller/account_controller.dart';
import 'package:donate/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/account.dart';

class AccountViewPage extends ConsumerWidget {
  const AccountViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountRivProvider);
    return account.when(
        data: (data) => _buildAccountView(context, data, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())));
  }

  Scaffold _buildAccountView(
      BuildContext context, Account account, WidgetRef ref) {
    final repository = sl<AuthRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyCircleAvatar(
              bloodType: account.bloodType,
              size: 120,
            ),
            Text('Display Name: ${account.displayName}'),
            Text('Email: ${account.email}'),
            Text(
                'Position: ${account.position?.latitude}/${account.position?.longitude}'),
            Text('Blood Type: ${account.bloodType}'),
            const Divider(),
            Row(
              children: [
                const Text('change blood type: '),
                DropdownButton<String>(
                  value: account.bloodType,
                  items: const [
                    DropdownMenuItem(value: 'A+', child: Text('A+')),
                    DropdownMenuItem(value: 'A-', child: Text('A-')),
                    DropdownMenuItem(value: 'B+', child: Text('B+')),
                    DropdownMenuItem(value: 'B-', child: Text('B-')),
                    DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                    DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                    DropdownMenuItem(value: '0+', child: Text('0+')),
                    DropdownMenuItem(value: '0-', child: Text('0-')),
                  ],
                  onChanged: (String? newValue) async {
                    repository.currentAccount!.bloodType = newValue!;
                    await repository.updateCurrentAccount();
                    ref.invalidate(accountRivProvider);
                  },
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  repository.logout();
                  ref.invalidate(accountRivProvider);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: const Text('Sign Out'))
          ],
        ),
      )),
    );
  }
}
