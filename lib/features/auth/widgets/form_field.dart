import 'package:travel_ease/common/utils/imports.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final VoidCallback onSubmit;
  final String submitLabel;

  const CustomForm({
    required this.formKey,
    required this.children,
    required this.onSubmit,
    required this.submitLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text(submitLabel),
          ),
        ],
      ),
    );
  }
}
