import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback? onCancelPressed;
  final VoidCallback? onSubmitPressed;

  const ActionButtons({
    super.key,
    this.onCancelPressed,
    this.onSubmitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onCancelPressed,
          child: Text(
            '취소',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: -0.025,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 35),
        TextButton(
          onPressed: onSubmitPressed,
          child: Text(
            '등록',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: -0.025,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
} 