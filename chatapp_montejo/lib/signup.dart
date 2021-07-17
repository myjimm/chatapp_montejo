import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'signin.dart';

class CreateAnAccountPage extends StatefulWidget {
  const CreateAnAccountPage({ Key? key }) : super(key: key);

  @override
  _CreateAnAccountPageState createState() => _CreateAnAccountPageState();
}

class _CreateAnAccountPageState extends State<CreateAnAccountPage> {
  String emailAddress = "", password = "";
  bool isHidden = true;
  IconData pwIcon = Icons.remove_red_eye_sharp;

  Widget _buildLogoColumn(){
    return Container(
      height: 0.4 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image(
        image: AssetImage('assets/montejo_logo.png'),
        fit: BoxFit.fill
      ),
    );
  }

  Widget _buildUsername(){
    return Container(
      child: SizedBox( 
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.grey[400],
            ),
            labelText: 'Username',
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

  Widget _buildEmail(){
    return Container(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
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

  Widget _buildConfirmPassword(){
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
  
  Widget _buildSignUpBtn() {
    return Container(
      child: ElevatedButton(
        child: Text("Sign Up",
          style: TextStyle(color: Colors.white)
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(title: 'Chat-App')));
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

  Widget _buildSignInBtn() {
    return Container(
      child: ElevatedButton(
        child: Text("Sign In",
          style: TextStyle(color: Colors.white)
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(title: 'Chat-App')));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 170)
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
              image: AssetImage('assets/GoogleSignUp.png')
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: 15),
            width: 185,
            child: Image(
              image: AssetImage('assets/FacebookSignUp.png')
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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
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
              ),
            ],
          ),
        ),
      )
    );
  }
}