import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatefulWidget {
    CustomFormField({
    Key? key,
    required this.hintText,
    required this.errorText,
    this.onChanged,
    this.validator,
    required this.prefixicon,
    required this.obscureText,
  }) : super(key: key);
  final String hintText;
  final String? errorText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Icon? prefixicon;
  bool obscureText = false;


  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 8.0),
      child: SizedBox(
       
        child: TextFormField(
          obscureText: widget.obscureText,
        
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
              focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 255, 157, 157)),
              ),
              prefixIcon: widget.prefixicon,
              suffixIcon: widget.hintText  == "Password"?
              GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  child: Icon(widget.obscureText?Icons.visibility_off:Icons.visibility, color: Colors.grey,)
                  
                  ): null ,
          
             
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:   BorderSide(
                    color: Color.fromARGB(255, 255, 154, 154), width: 2.0),
              ),
              border: OutlineInputBorder(),
              hintText: widget.hintText,
              errorText: widget.errorText
              ),
        ),
      ),
    );
  }
}
