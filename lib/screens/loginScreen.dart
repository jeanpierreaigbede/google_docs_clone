import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/models/error_model.dart';
import 'package:google_docs_clone/repositories/auth_repoistory.dart';
import 'package:google_docs_clone/screens/home_screen.dart';
import 'package:google_docs_clone/utils/appColors.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel =
        await ref.read(authRepositoryProvider).signInWithGoogle();

    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      sMessenger.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                backgroundColor: AppColors.kWhiteColor),
            onPressed: () => signInWithGoogle(ref, context),
            icon: Image.asset(
              "assets/icons/g-logo-2.png",
              height: 25,
            ),
            label: const Text("Sign in with google")),
      ),
    );
  }
}
