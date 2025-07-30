import 'package:flutter/material.dart';

class ReviewBottomSheet extends StatefulWidget {
  final double bottomPadding;
  const ReviewBottomSheet({super.key, required this.bottomPadding});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50 + widget.bottomPadding,
        decoration: BoxDecoration(
          color: Colors.purple[40],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurple[400]!,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
