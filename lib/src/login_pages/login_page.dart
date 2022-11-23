import 'package:flare_flutter/flare_actor.dart';
import 'package:flights/src/login_pages/platform_expetions.dart';
import 'package:flights/src/login_pages/validators.dart';
import 'package:flights/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class LoginPage extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  bool _submited = false;
  bool _isLoading = false;

  bool isLoadingPage = false;

  String animationType = 'idle';

// @override
//   void initState() { 
//       super.initState();
//     _passwordFocusNode.addListener(() {
//       if(_passwordFocusNode.hasFocus || _emailFocusNode.hasFocus){
//        setState(() {
//          animationType = 'test';
//        });
          
//       }
//       // } else {
//       //    setState(() {
//       //      animationType = 'idle';
//       //    });
          
        
//       // }
//     });
    
    
//   }
  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _submited = true;
      _isLoading = true;
      animationType = 'success';
    });

    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
          
     await  auth.signInWithEmailAndPassword(_email, _password);

      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
    } on PlatformException catch (e) {
      
      PlatformExeptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
        
      ).show(context);
     
    } finally {
      setState(() {
        _isLoading = false;
        animationType = 'fail';
      });
    }
  }

  void _emailEdittingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submited = false;
      // animationType = 'idle';
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context), 
          _loginForm(context)
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';

    final secundaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign In';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;
      
   

    final auth = Provider.of<AuthBase>(context, listen: false);
    final _screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: _screenSize.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _crearEmail(),
                SizedBox(
                  height: 20.0,
                ),
                _crearPassword(),
                SizedBox(
                  height: 20.0,
                ),
                _crearBoton(primaryText, submitEnabled),
                SizedBox(height: 15.0),
                FlatButton(
                  child: Text(secundaryText),
                  onPressed: !_isLoading ? _toggleFormType : null,
                ),
                SizedBox(height: 5.0),
                _crearTextSignInWith(),
                SizedBox(height: 25.0),
                _TiposdeSignIn(auth: auth)
              ],
            ),
          ),
          FlatButton(
            child: Text('¿Forgot your password? '),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _crearEmail() {
    bool showErrorText = _submited && !widget.emailValidator.isValid(_email);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        focusNode: _emailFocusNode,
        onEditingComplete: _emailEdittingComplete,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.blue),
          hintText: 'example@email.com',
          labelText: 'Email',
          // counterText: snapshot.data,
          errorText: showErrorText ? widget.invalidEmailErrorText : null,
          enabled: _isLoading == false,
        ),
        controller: _emailController,
        onChanged: (email) => _updateState(),
      ),
    );
  }

  Widget _crearPassword() {
    bool showErrorText =
        _submited && !widget.passwordValidator.isValid(_password);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.blue),
          labelText: 'Password',
          // counterText: snapshot.data,
          errorText: showErrorText ? widget.invalidPasswordErrorText : null,
          enabled: _isLoading == false,
        ),
        controller: _passwordController,
        onEditingComplete: _submit,
        onChanged: (password) => _updateState(),
      ),
    );
  }

  Widget _crearBoton(String text, bool submitEnabled) {
    // formValidStream
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      height: 40,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.centerRight,
              colors: [Colors.blueAccent, Colors.grey]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 6), blurRadius: 6),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text(text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: (submitEnabled) ? Colors.white : Colors.grey)),
            onPressed: submitEnabled ? _submit : null,
          ),
        ],
      ),
    );
    // return RaisedButton(
    //     child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
    //     child: Text('Ingresar'),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(5),
    //       color: Colors.orange
    //     ),
    //     ),

    //     // elevation: 8.0,

    //     textColor: Colors.white,
    //     onPressed: () {}
    // );
  }

  Widget _crearFondo(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: _screenSize.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueAccent, Colors.black12])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          bottom: 1200.0,
          right: 20.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          left: -20.0,
          child: circulo,
        ),
        Container(
          height: _screenSize.height * 0.35,
          padding: EdgeInsets.only(top: 30.0),
          child: FlareActor(
            "assets/animations/teddy.flr",
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            shouldClip: false,
          animation: animationType),
          // child: Column(
          //   children: <Widget>[
              // ElasticInDown(
              //     duration: Duration(seconds: 2),
              //     child: Icon(Icons.airplanemode_active,
              //         color: Colors.white, size: 100.0)),
              // SizedBox(
              //   height: 10.0,
              //   width: double.infinity,
              // ),
              // Text('Welcome',
              //     style: TextStyle(color: Colors.white, fontSize: 25.0)),
            // ],
          // ),
        )
      ],
    );
  }

  void _updateState() {
    setState(() {
      if(_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
        animationType = 'test';
      } else {
        animationType = 'idle';
      }
    });
  }
}

class _crearTextSignInWith extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70),
      height: 40,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //      BoxShadow(
      //       color: Colors.black,
      //        offset: Offset(0, 6),
      //        blurRadius: 6),
      //   ]
      // ),
      child: Center(
          child: Text(
        'Sign In With',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      )),
    );
  }
}

class _TiposdeSignIn extends StatelessWidget {
  final AuthBase auth;

  _TiposdeSignIn({@required this.auth});

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExeptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWiFacebook(BuildContext context) async {
    try {
      await auth.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Column(
                children: <Widget>[
                  Icon(FontAwesomeIcons.google, size: 30, color: Colors.red),
                  SizedBox(height: 10),
                  Text('Google', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              onPressed: () => _signInWithGoogle(context),
            ),
            FlatButton(
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.facebook,
                    size: 35,
                    color: Color(0xFF334D92),
                  ),
                  SizedBox(height: 10),
                  Text('Facebook',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              onPressed: () => _signInWiFacebook(context),
            ),
            FlatButton(
              child: Column(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.twitter,
                    size: 35,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 10),
                  Text('Twitter', style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.mask,
                    size: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15),
                  Text('Anonymous',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              onPressed: () => _signInAnonymously(context),
            ),
          ],
        )
      ],
    );
  }
}
