import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'forgotpass.dart';
import 'chat.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailAddress = "", password = "";
  bool isHidden = true;
  IconData pwIcon = Icons.remove_red_eye_sharp;

  Widget _buildLogoColumn(){
    return Container(
      height: 0.5 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image(
        image: AssetImage('assets/montejo_logo.png'),
        fit: BoxFit.fill
      ),
    );
  }

  Widget _buildEmail(){
    return Container(
      child: SizedBox( 
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (input) => EmailValidator.validate(input.toString()) ? null : "Invalid E-mail Address",
          onSaved: (input) {
            emailAddress = input.toString();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.grey[400],
            ),
            labelText: 'E-mail Address',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
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
  Widget _buildPassword(){
    return Container(  
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: isHidden,
          autocorrect: false,
          validator: (input){
            if(input == null){ //not sure about this (old: input.length < 1)
              return "This field is required";
            }else{
              return null;
            }
          },
          onSaved: (input) => password = input.toString(), 
          onChanged: (value){
            setState(() {
              password = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.grey[400],
            ),
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
            ),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  isHidden = !isHidden;
                  if(pwIcon == Icons.visibility_off){
                    pwIcon = Icons.remove_red_eye_sharp;
                  }else{
                    pwIcon = Icons.visibility_off;
                  }
                });
              }, 
              icon: Icon(pwIcon)
            )
          ),
        )
      )
    );
  }  

  Widget _buildForgotPass(){
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          child: TextButton(
            child: Text("Forgot Password", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
            },
          ),
        ),
      ),
    );
  }  

  Widget _buildSignInBtn() {
    return Container(
      child: ElevatedButton(
        child: Text("Sign In",
          style: TextStyle(color: Colors.white)
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 170)
        ),
      ),
    );
  }

  Widget _buildCreateAcc() {
    return Container(
      child: ElevatedButton(
        child: Text("Create an Account",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAnAccountPage()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 130)
        ),
      ),
    );
  }

  Widget _buildSocials(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(end: 15),
            width: 185,
            child: Image(
              image: AssetImage('assets/GoogleSignIn.png')
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: 15),
            width: 185,
            child: Image(
              image: AssetImage('assets/FacebookSignIn.png')
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogoColumn(),
              Container(
                height: 0.5 * MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    _buildEmail(),
                    _buildPassword(),
                    _buildForgotPass(),
                    _buildSignInBtn(),
                    _buildCreateAcc(),
                    _buildSocials()
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}