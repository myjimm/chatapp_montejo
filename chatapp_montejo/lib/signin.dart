import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'forgotpass.dart';
import 'services/backend.dart';
import 'wrapper.dart';

class LoginPage extends StatefulWidget {
  final Function? toggleView;
  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? emailAddress, password;
  bool isHidden = true;
  IconData pwIcon = Icons.remove_red_eye_sharp;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildLogoColumn(){
    return Container(
      height: 0.5 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image(
        image: AssetImage('assets/montejo_logo.png'),
        fit: BoxFit.contain
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
            if(input.toString().length < 1){ 
              return "This field is required";
            }else{
              return null;
            }
          },
          onSaved: (input) => password = input.toString(), 
          // onChanged: (value){
          //   setState(() {
          //     password = value;
          //   });
          // },
          onChanged: (input) {
            password = input.toString();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green[200],
            ),
            labelText: 'Password',
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
              icon: Icon(pwIcon, color: Colors.green[200])
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Sign In",
          style: TextStyle(color: Colors.white)
        ),
        onPressed: () async {
          if(_formKey.currentState?.validate() == true){
            _formKey.currentState?.save();
          }
          final AuthenticationMethods authMethods = AuthenticationMethods();
          dynamic result = await authMethods.signinWithEmailandPassword(emailAddress.toString(), password.toString());
          if(result == null){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Error"
                  ),
                  content: Text(
                    "No account exists"
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        'OKAY',
                        style: TextStyle(
                          color: Colors.red
                        )
                      ),
                      onPressed: () {
                        // if(error == "verified"){
                        //   Navigator.of(context)
                        //         .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
                        //   authMethods.verifyEmail();
                        // }else if (error == "connected"){
                        //   Navigator.of(context)
                        //         .pushReplacement(MaterialPageRoute(builder: (context)=>MainPage()));
                        // }
                        Navigator.of(context).pop();
                      },
                    )
                  ]
                );
              }
            );
          }else{
            Navigator.of(context)
                     .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper()));
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 100)
        ),
      ),
    );
  }

  Widget _buildCreateAcc() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Create an Account",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          widget.toggleView!();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
      ),
    );
  }

  Widget _buildSocials(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('assets/GoogleSignIn.png'),
          ),
          Expanded(
            child: Image.asset('assets/FacebookSignIn.png')
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
                child: Form(
                  // autovalidateMode: AutovalidateMode.always, 
                  key: _formKey,
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
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}