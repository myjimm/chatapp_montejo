import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
// import 'signin.dart';

class CreateAnAccountPage extends StatefulWidget {
  final Function? toggleView;
  CreateAnAccountPage({this.toggleView});

  @override
  _CreateAnAccountPageState createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  String? emailAddress, password, confirmPassword;
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
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => 
            AlertDialog(
              title: Text('Success'),
              content: Text('Sign up succesful. Verification Email is sent.'),
              actions: [
                TextButton(
                  // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(title: 'Chat-App'))),
                  onPressed: (){},
                  child: Text('Yes'),
                )
              ],
            ),
        ),
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