// import 'package:ai_profanity_textfield/gemini_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class ProfanityTextfield extends ConsumerStatefulWidget {
//   final GlobalKey<FormState> formkey;
//   final String? hintText;
//   final TextInputType? keyboardType;
//   final TextEditingController controller;
//   final int? maxLength;
//   const ProfanityTextfield(
//       {this.hintText,
//       this.keyboardType = TextInputType.text,
//       required this.controller,
//       this.maxLength,
//       super.key,
//       required this.formkey});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _ProfanityTextfieldState();
// }

// class _ProfanityTextfieldState extends ConsumerState<ProfanityTextfield> {
//   bool _containsProfanity = false;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     widget.controller.dispose();
//     super.dispose();
//   }

//   Future<void> _checkProfanity() async {
//     final response =
//         await GeminiService().checkProfanity(widget.controller.text);
//     setState(() {
//       _containsProfanity = response;
//     });
//   }

//   String? _validateText(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter some text';
//     }
//     if (_containsProfanity) {
//       return 'Text contains profanity!';
//     }
//     return null;
//   }

//   Future<void> validate() async {
//     // close the keyboard when tapped outside
//     FocusScope.of(context).unfocus();
//     if (widget.controller.text.isEmpty) return;
//     changeStatus();
//     await _checkProfanity();
//     changeStatus();
//     widget.formkey.currentState!.validate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextFormField(
//           textAlign: TextAlign.start,
//           style: const TextStyle(color: Colors.white),
//           controller: widget.controller,
//           validator: _validateText,
//           onEditingComplete: validate,
//           onTapOutside: (event) async => validate(),
//           decoration: InputDecoration(
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: 2.w,
//               ),
//               filled: true,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(18.0),
//               ),
//               hintText: widget.hintText,
//               hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith()),
//         ),
//         Gap(1.h),
//         _isLoading
//             ? Row(
//                 children: [
//                   Gap(4.w),
//                   SizedBox(
//                       height: 13.sp,
//                       width: 13.sp,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 4.sp,
//                       )),
//                   Gap(2.w),
//                   Text('Checking for profanity...',
//                       style: TextStyle(fontSize: 13.sp)),
//                 ],
//               )
//             : const SizedBox.shrink(),
//       ],
//     );
//   }

//   void changeStatus() {
//     setState(() {
//       _isLoading = !_isLoading;
//     });
//   }
// }
