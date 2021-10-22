import 'package:desafio/features/home/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  bool _validateEmail = false;
  bool _validatePassword = false;

  var snackBar;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    Future(() {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
    super.initState();
  }

  void signIn() async {
    setState(() {
      _loading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.value.text, password: _password.value.text);
      if (auth.currentUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          _showMessage('No user found for that email.'),
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          _showMessage('Wrong password provided for that user.'),
        );
        print('Wrong password provided for that user.');
      }
    }
    setState(() {
      _loading = false;
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    setState(() {
      _loading = true;
    });
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    setState(() {
      _loading = false;
    });
    return FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .whenComplete(
          () => {
            if (auth.currentUser != null)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: _buildContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size size) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.7,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(100.0),
            ),
            child: Image.asset(
              'assets/login_logo.jpeg',
              height: size.height * 0.35,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 20,
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Image.asset(
              'assets/logo.png',
              width: 100,
            ),
          ),
        ),
        Positioned(
          top: 100,
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'Welcome Back!',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(Size size) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please login to continue.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          _buildLoginFields(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildLoginFields() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Container(
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                errorText: _validateEmail ? 'Value Can\'t Be Empty' : null,
                labelText: "Email address",
                labelStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Stack(
            children: [
              TextField(
                controller: _password,
                decoration: InputDecoration(
                  errorText: _validatePassword ? 'Value Can\'t Be Empty' : null,
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isPasswordVisible ? false : true,
              ),
              Positioned(
                right: 0.0,
                top: 25,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                  child: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(size),
          _buildBody(size),
          _buildFooter(size),
        ],
      ),
    );
  }

  Widget _buildFooter(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'New to Scratch?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          Text(
            'Create Account Here',
            style: TextStyle(
              color: Color(0xFF30BE76),
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 55,
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF30BE76),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  _email.text.isEmpty
                      ? _validateEmail = true
                      : _validateEmail = false;
                  _password.text.isEmpty
                      ? _validatePassword = true
                      : _validatePassword = false;
                });
                if (_email.text.isNotEmpty &&
                    _password.text.isNotEmpty &&
                    !_loading) signIn();
              },
              child: !_loading
                  ? Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  : CircularProgressIndicator(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue.shade700,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                signInWithFacebook();
              },
              child: !_loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 35,
                          color: Colors.white,
                        ),
                        Text(
                          'Continue with Facebook',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  SnackBar _showMessage(String message) {
    return SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }
}
