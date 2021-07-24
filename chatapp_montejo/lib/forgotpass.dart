import 'package:chatapp_montejo/services/backend.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'authenticate/auth.dart';
// import 'signin.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? emailAddress;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SizedBox( 
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (input) => EmailValidator.validate(input.toString()) ? null : "Invalid E-mail Address",
          onSaved: (input) {
            emailAddress = input.toString();
          },
          onChanged: (input) {
            emailAddress = input.toString();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.green[200],
            ),
            labelText: 'E-mail Address',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
            )
          ),
        )
      ),
    );
  }  

  Widget _buildResetPassBtn() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        child: Text("Send Reset Password Email",
          style: TextStyle(color: Colors.white)
        ),
        onPressed: () async {
          final AuthenticationMethods authMethods = AuthenticationMethods();
          if(_formKey.currentState?.validate()==true){
            _formKey.currentState?.save();
            authMethods.resetPassword(emailAddress.toString());
            setState(() {
              isLoading = true;
            });
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Success"
                  ),
                  content: Text(
                    "An email has been sent to your email address."
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        'OKAY',
                      style: TextStyle(
                        color: Colors.green
                      )
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Auth()));
                      },
                    )
                  ]
                );
              }
            );
          }
        }, 
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App Reset Password", 
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.green[200],
        leading: IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      body: Center( 
        child: Container(
          height: 0.5 * MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildEmail(),
                _buildResetPassBtn() 
              ],
            )
          )
        )
      )
    );
  }
}