// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../resources/color-manager.dart';
//
// class TextFieldEdit extends StatefulWidget {
//   final IconData icon;
//   final String label;
//   final String hint;
//   final TextEditingController controller;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? Function(String?)? validator;
//   final void Function(String?)? onChange;
//
//   const TextFieldEdit({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.hint,
//     required this.controller,
//     this.inputFormatters,
//     this.validator,
//     this.onChange,
//   }) : super(key: key);
//
//   @override
//   _TextFieldEditState createState() => _TextFieldEditState();
// }
//
// class _TextFieldEditState extends State<TextFieldEdit> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.hint);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: TextFormField(
//         controller: _controller,
//         inputFormatters: widget.inputFormatters,
//         validator: widget.validator,
//         onChanged: widget.onChange,
//         obscureText: widget.hint == "inter your password",
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.white,
//             ),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: ColorManager.secondBase,
//             ),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: ColorManager.secondBase,
//             ),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           filled: true,
//           fillColor: ColorManager.textFieldPanicAttack,
//           prefixIcon: Icon(
//             widget.icon,
//             color: ColorManager.textFielTextBase,
//           ),
//           labelText: widget.label,
//           hintText: "",
//           hintStyle: TextStyle(color: ColorManager.secondPanicAttack),
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//         ),
//         cursorColor: ColorManager.secondPanicAttack,
//         onTap: () {
//           if (_controller.text == widget.hint) {
//             _controller.clear();
//           }
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color-manager.dart';

class TextFieldEdit extends StatefulWidget {
  final IconData icon;
  final String label;
  final String hint;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;

  const TextFieldEdit({
    Key? key,
    required this.icon,
    required this.label,
    required this.hint,
    required this.controller,
    this.inputFormatters,
    this.validator,
    this.onChange,
  }) : super(key: key);

  @override
  _TextFieldEditState createState() => _TextFieldEditState();
}

class _TextFieldEditState extends State<TextFieldEdit> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.hint;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        onChanged: widget.onChange,
        obscureText: widget.hint == "inter your password",
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.secondBase,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.secondBase,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          filled: true,
          fillColor: ColorManager.textFieldPanicAttack,
          prefixIcon: Icon(
            widget.icon,
            color: ColorManager.textFielTextBase,
          ),
          labelText: widget.label,
          hintText: "",
          hintStyle: TextStyle(color: ColorManager.secondPanicAttack),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        cursorColor: ColorManager.secondPanicAttack,
        onTap: () {
          if (widget.controller.text == widget.hint) {
            widget.controller.clear();
          }
        },
      ),
    );
  }
}
