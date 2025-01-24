// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// class PhoneNumberInputWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final PhoneNumber initialNumber;
//   final void Function(PhoneNumber) onInputChanged;
//   final void Function(bool) onInputValidated;
//   final void Function(PhoneNumber) onSaved;

//   const PhoneNumberInputWidget({
//     Key? key,
//     required this.controller,
//     required this.initialNumber,
//     required this.onInputChanged,
//     required this.onInputValidated,
//     required this.onSaved,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               spreadRadius: 2,
//               blurRadius: 4,
//               offset: const Offset(0, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: InternationalPhoneNumberInput(
//           inputDecoration: const InputDecoration(
//             hintText: '123 45 67',
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding:
//                 EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//             border: InputBorder
//                 .none, // No border here, as it's handled by the container
//           ),
//           onInputChanged: onInputChanged,
//           onInputValidated: onInputValidated,
//           selectorConfig: const SelectorConfig(
//             selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//             useBottomSheetSafeArea: true,
//           ),
//           ignoreBlank: false,
//           autoValidateMode: AutovalidateMode.disabled,
//           selectorTextStyle: const TextStyle(color: Colors.black),
//           initialValue: initialNumber,
//           textFieldController: controller,
//           formatInput: true,
//           keyboardType:
//               const TextInputType.numberWithOptions(signed: true, decimal: true),
//           inputBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide:
//                 BorderSide.none, // No border color, use decoration instead
//           ),
//           onSaved: onSaved,
//         ),
//       ),
//     );
//   }
// }
