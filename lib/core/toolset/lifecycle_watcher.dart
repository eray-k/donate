import 'package:donate/apps/auth/domain/repository/auth_repository.dart';
import 'package:flutter/widgets.dart';

import '../../dependency_injection.dart';

class LifecycleWatcher extends StatefulWidget {
  const LifecycleWatcher({super.key, required this.child});
  final Widget child;
  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    sl<AuthRepository>().updateLocation();
    debugPrint('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
