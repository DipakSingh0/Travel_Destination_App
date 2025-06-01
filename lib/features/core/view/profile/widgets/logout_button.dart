import 'package:travel_ease/common/utils/imports.dart';
class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final signOutProvider =
        Provider.of<SignOutProvider>(context, listen: false);

    return PrimaryButton(
      text: "Logout",
      color: Colors.redAccent,
      textColor: Colors.white,
      width: 200,
      height: 50,
      borderRadius: 30,
      fontSize: 16,
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Confirm Logout"),
            content: const Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop(); // Close dialog first

                  bool success = await signOutProvider.signOutUser(context);
                  if (success) {
                    // Navigate only if sign out was successful
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SignInView()),
                      (route) => false,
                    );
                  }
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
