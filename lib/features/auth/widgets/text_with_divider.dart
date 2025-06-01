import 'package:travel_ease/common/utils/imports.dart';

class TextWithDivider extends StatelessWidget {
  const TextWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.kGrey60,
          ),
        ),
        SizedBox(width: 20),
        Text(
          'Or Sign In with',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.kGrey60,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Divider(color: AppColors.kGrey60),
        ),
      ],
    );
  }
}
