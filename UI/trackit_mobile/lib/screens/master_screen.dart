import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'login_screen.dart';

class MasterScreen extends StatefulWidget {
  final Widget? child;
  final String? title;
  const MasterScreen({super.key, this.title, this.child});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  late AuthProvider _authProvider;
  int currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      // Navigator.pushNamed(context, ProductListScreen.routeName);
    } else if (currentIndex == 1) {
      // Navigator.pushNamed(context, CartScreen.routeName);
    }
  }

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
      body: SafeArea(child: widget.child!),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
        ],
        selectedItemColor: Colors.yellow[600],
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
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
