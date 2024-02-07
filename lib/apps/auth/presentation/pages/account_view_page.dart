import 'package:donate/apps/auth/presentation/widgets/my_circle_avatar.dart';
import 'package:donate/apps/auth/presentation/controller/account_controller.dart';
import 'package:donate/core/toolset/ui/ui_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/account.dart';

class AccountViewPage extends ConsumerWidget {
  const AccountViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountRivProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: account.when(
            data: (data) => _buildAccountView(context, data, ref),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text(error.toString()))),
      ),
    );
  }

  Widget _buildAccountView(
      BuildContext context, Account account, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          verticalSpacer(32),
          MyCircleAvatar(
            bloodType: account.bloodType,
            size: 120,
          ),
          verticalSpacer(32),
          Text(
            account.displayName,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
            ),
          ),
          verticalSpacer(4),
          Text(
            "${account.email}\n${account.bloodType}",
            style: const TextStyle(fontSize: 15, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          verticalSpacer(32),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/edit');
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile")),
        ],
      ),
    );
  }
}
