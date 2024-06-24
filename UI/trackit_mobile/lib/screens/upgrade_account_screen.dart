import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';

import '../providers/general_user_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/user_info.dart';
import 'master_screen.dart';

class UpgradeAccountScreen extends StatefulWidget {
  const UpgradeAccountScreen({super.key});

  @override
  State<UpgradeAccountScreen> createState() => _UpgradeAccountScreenState();
}

class _UpgradeAccountScreenState extends State<UpgradeAccountScreen> {
  late GeneralUserProvider _generalUserProvider;
  bool isDisabled = UserInfo.user!.isUserPremium ?? false;

  @override
  void initState() {
    _generalUserProvider = context.read<GeneralUserProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(child: _buildScreen());
  }

  Widget _buildScreen() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text("Upgrade your account",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "With the purchase of the upgraded premium account you will receive benefits and access to features only accessible through the premium version. The upgrade is a one-time purchase for the price of \$4.99",
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: !isDisabled
                  ? () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId:
                              "AYWC9eKExMBEBU5QPEoehe33m-fUPWuKnYp1dWhSDLMfSWB7ErG0b97r7YxkvUfaqfU1T0rhBFZ4FEe4",
                          secretKey:
                              "ELTHySTRqTv8O94AMPVNaqy0LRa-LjiW-TIMTAzvdg2Bg2IMpdDahTDr-j2mkFI9Q3UVB9edCG3sPLnm",
                          returnURL: "success.snippetcoder.com",
                          cancelURL: "cancel.snippetcoder.com",
                          transactions: const [
                            {
                              "amount": {
                                "total": 4.99,
                                "currency": "USD",
                              },
                              "description":
                                  "Purchase to upgrade an account to premium level.",
                              "item_list": {
                                "items": [
                                  {
                                    "name": "Account upgrade",
                                    "quantity": 1,
                                    "price": 4.99,
                                    "currency": "USD"
                                  },
                                ],
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            try {
                              await _generalUserProvider.upgradeToPremium(
                                  UserInfo.user!.generalUserId!);
                              UserInfo.user!.isUserPremium = true;
                              setState(() {
                                isDisabled = true;
                              });
                            } on Exception catch (e) {
                              AlertHelpers.showAlert(
                                  context, "Error", e.toString());
                            }
                          },
                          onError: (error) {
                            print("An error occured: $error");
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            print('The payment is cancelled:');
                          },
                        ),
                      ));
                    }
                  : null,
              child: Text(isDisabled
                  ? "You've already upgraded your account"
                  : "Proceed to upgrade"))
        ],
      ),
    );
  }
}
