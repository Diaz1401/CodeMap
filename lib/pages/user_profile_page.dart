import 'package:codemap/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:codemap/services/userdata_service.dart';
import 'package:codemap/l10n/app_localizations.dart';

import '../services/google_signin_service.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  Future<int> _getLimitLeft() async {
    final data = await UserdataService().getUserRequestData();
    final count = data['count'] ?? 0;
    return 10 - (count as int);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.txtUserProfile)),
      body: user == null
          ? Center(child: Text(AppLocalizations.of(context)!.msgSignInRequired))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (user.photoURL != null)
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        user.photoURL!,
                                      ),
                                      radius: 48,
                                    )
                                  else
                                    const CircleAvatar(
                                      radius: 48,
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 48,
                                      ),
                                    ),
                                  const SizedBox(height: 16),
                                  Text(
                                    user.displayName ?? '-',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    user.email ?? '-',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        FutureBuilder<int>(
                          future: _getLimitLeft(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.txtReqLeft,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${snapshot.data}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          },
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.logout),
                              label: Text(
                                AppLocalizations.of(context)!.btnSignOut,
                              ),
                              onPressed: () async {
                                await GoogleSignInService().signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => SignInPage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
