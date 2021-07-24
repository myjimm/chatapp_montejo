import 'package:chatapp_montejo/services/backend.dart';
import 'package:chatapp_montejo/verify.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// import 'authenticate/auth.dart';
import 'controller/userController.dart';
// import 'signin.dart';

class CreateAnAccountPage extends StatefulWidget {
  final Function? toggleView;
  CreateAnAccountPage({this.toggleView});

  @override
  _CreateAnAccountPageState createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  String? username, emailAddress, password, confirmPassword;
  bool isHidden = true;
  IconData pwIcon = Icons.remove_red_eye_sharp;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildLogoColumn(){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      height: 0.42 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image(
        image: AssetImage('assets/montejo_logo.png'),
        fit: BoxFit.contain
      ),
    );
  }

  Widget _buildUsername(){
    return Container(
      child: SizedBox( 
        height: 45,
        child: TextFormField(
          keyboardType: TextInputType.text,
          validator: (input){
            if(input.toString().length < 1){ 
              return "This field is required";
            }else{
              return null;
            }
          },
          onSaved: (input) {
            username = input.toString();
          },
          onChanged: (input) {
            username = input.toString();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.green[200],
            ),
            labelText: 'Username',
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

  Widget _buildEmail(){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: SizedBox( 
        height: 45,
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
        height: 45,
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

  Widget _buildConfirmPassword(){
    return Container(  
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: SizedBox(
        height: 45,
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
          onSaved: (input) => confirmPassword = input.toString(), 
          // onChanged: (value){
          //   setState(() {
          //     password = value;
          //   });
          // },
          onChanged: (input) {
            confirmPassword = input.toString();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green[200],
            ),
            labelText: 'Confirm Password',
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

  Widget _buildSignUpBtn() {
    return  SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Sign Up",
          style: TextStyle(color: Colors.white)
        ),
        onPressed: () async {
          String uid;
          String photo = "https://res.cloudinary.com/jerrick/image/upload/f_jpg,q_auto,w_720/wi7mvdmpmtqkfuqymqqt.jpg";
          AuthenticationMethods authMethods = new AuthenticationMethods();
          if(_formKey.currentState?.validate() == true){
            _formKey.currentState?.save();
            try{
              dynamic result = await authMethods.signupWithEmailAndPassword(emailAddress.toString(), password.toString());
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
                        "This e-mail address is already in use. Try another one.",
                        style: TextStyle(
                          fontFamily: "Montserrat"
                        )
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'OKAY',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Montserrat"
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ]
                    );
                  }
                );
              }else{
                uid = "${result.uid}";
                await authMethods.updateProfile(username.toString(), photo);
                UserController().createUser(uid, emailAddress, username);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Success',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat"
                        )
                      ),
                      content: Text(
                        "Sign up successful. Verification email sent."
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'OKAY',
                            style: TextStyle(
                              color: Colors.red,
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (context)=>VerifyPage()));
                          },
                        )
                      ]
                    );
                  }
                );
              }
            }catch(e){
              print(e.toString());
            }
          }else{
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Error",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat"
                    )
                  ),
                  content: Text(
                    "Missing Fields."
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
                        Navigator.of(context).pop();
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
          )
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return  SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Sign In",
          style: TextStyle(color: Colors.white)
        ),
        onPressed: () {
          widget.toggleView!();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          )
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
            child: Image.asset('assets/GoogleSignUp.png'),
          ),
          Expanded(
            child: Image.asset('assets/FacebookSignUp.png')
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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildUsername(),
                      _buildEmail(),
                      _buildPassword(),
                      _buildConfirmPassword(),
                      _buildSignUpBtn(),
                      _buildSignInBtn(),
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