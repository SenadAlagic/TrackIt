import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'login_screen.dart';

class MasterScreen extends StatefulWidget {
  final Widget? child;
  final String? title;
  const MasterScreen({this.child, this.title, super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  late AuthProvider _authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: _drawProfileIcon())
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 50),
          widget.child ?? const Placeholder()
        ])));
  }

  Widget _drawProfileIcon() {
    return PopupMenuButton(
        icon: const Icon(
          Icons.account_circle_outlined,
          size: 32,
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () {
                  _authProvider.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    ModalRoute.withName('LoginScreen'),
                  );
                },
                child: const Text('Logout'),
              )
            ]);
  }
}
