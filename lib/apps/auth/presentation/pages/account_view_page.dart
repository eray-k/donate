import 'package:donate/apps/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../../../dependency_injection.dart';
import '../../domain/model/account.dart';

class AccountViewPage extends StatefulWidget {
  const AccountViewPage({super.key});

  @override
  State<AccountViewPage> createState() => _AccountViewPageState();
}

class _AccountViewPageState extends State<AccountViewPage> {
  final repository = sl<AuthRepository>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future(repository.getCurrentAccount),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildAccountView(snapshot.data!);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Scaffold _buildAccountView(Account account) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    setState(() {});
                  },
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  repository.logout();
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
