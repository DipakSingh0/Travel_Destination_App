
import 'package:hero_anim/imports.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;

  const MyAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,  //
    this.actions,
    this.leading,
    this.backgroundColor = AppColors.kBlue,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w500),),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      leading: leading,
      actions: actions,
    );
  }
}
