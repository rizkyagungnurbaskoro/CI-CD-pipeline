//RIZKY AGUNG NURBASKORO
//213925

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'custom_gauge.dart';
import 'main.dart';

// Define your custom colors
const Color customBeige = Color(0xFFF1E5D1);
const Color customPink = Color(0xFFDBB5B5);
const Color customLightBrown = Color(0xFFC39898);
const Color customBrown = Color(0xFF987070);

void main() {
  runApp(MyApp());
}

// Our main widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ActivationPage(),
        '/factoryApp': (context) => MyHomePage(title: 'Factory App'),
      },
    );
  }
}

// Activation Page
class ActivationPage extends StatefulWidget {
  const ActivationPage({super.key});

  @override
  State<ActivationPage> createState() => _ActivationState();
}

class _ActivationState extends State<ActivationPage> {
  bool accountActivation = true;

  void toggleContainer() {
    setState(() {
      accountActivation = !accountActivation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activation Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              // UPM Logo
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 200,
                height: 100,
                child: Image.network(
                    'https://upm.edu.my/assets/images23/20170406143426UPM-New_FINAL.jpg'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0), // for better alignment
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              // Containers
              child: SizedBox(
                width: 500,
                height: 500,
                child: accountActivation
                    ? AccountActivationContainer(toggleContainer)
                    : CodeActivationContainer(() {
                        Navigator.pushReplacementNamed(
                            context, '/factoryApp');
                      }),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Disclaimer | Privacy Statement',
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              child: Text(
                  'Copyright UPM & Kejuruteraan Minyak Sawit CCS Sdn. Bhd.',
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountActivationContainer extends StatefulWidget {
  final VoidCallback onButtonPressed;

  AccountActivationContainer(this.onButtonPressed);

  @override
  State<AccountActivationContainer> createState() =>
      _AccountActivationContainerState();
}

class _AccountActivationContainerState
    extends State<AccountActivationContainer> {
  bool isChecked = false;
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: customPink,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          SizedBox(
            height: 100,
            width: 300,
            child: Text(
              'Enter your mobile number to activate your account',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/malaysia.png',
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(
                '+60',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 40,
                width: 180,
                child: TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text('I agree to the terms and conditions'),
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              onPressed: isChecked
                  ? () {
                      // Navigate to code activation container
                      widget.onButtonPressed();
                    }
                  : null,
              child: Text(
                'Get Activation Code',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CodeActivationContainer extends StatelessWidget {
  final VoidCallback onButtonPressed;

  CodeActivationContainer(this.onButtonPressed);

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: customBeige,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          SizedBox(
            height: 100,
            width: 300,
            child: Text(
              'Enter the activation code you received via SMS',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 60,
            width: 240,
            child: TextField(
              controller: _otpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to factory app main screen
                onButtonPressed();
              },
              child: Text(
                'Activate',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
