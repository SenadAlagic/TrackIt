import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class MasterScreen extends StatefulWidget {
  final Widget? child;
  final String? title;
  const MasterScreen({super.key, this.title, this.child});

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
        drawer: Drawer(
          child: ListView(children: [
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text("Logout"),
              onTap: () => {_authProvider.logout(context)},
            )
          ]),
        ),
        body: SafeArea(child: widget.child!));
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
                  _authProvider.logout(context);
                },
                child: const ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout_rounded),
                ),
              )
            ]);
  }
}
