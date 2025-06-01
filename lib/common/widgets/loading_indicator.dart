import 'package:travel_ease/imports.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingIndicator({super.key, 
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
