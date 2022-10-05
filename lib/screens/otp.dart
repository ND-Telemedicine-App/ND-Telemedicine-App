import 'package:flutter/material.dart';
import 'package:nd_telemedicine_app/screens/forgot_password.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String otp = "0000";

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    )
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  color: Color(0xff38B69A),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/otp.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "PoppinsBold",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "PoppinsMedium",
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false, num: 0),
                        _textFieldOTP(first: false, last: false, num: 1),
                        _textFieldOTP(first: false, last: false, num: 2),
                        _textFieldOTP(first: false, last: true, num: 3),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            print(otp);
                          },
                          child: Text('Verify',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 18))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "PoppinsMedium",
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "PoppinsBold",
                  color: Color(0xff2B8D78),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last, required int num}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextFormField(
          autofocus: true,
          onChanged: (value) => {
            setState(() {
              otp = replaceCharAt(otp, num, value);
            }),
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus()
            },
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus()
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Color(0xff38B69A)),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
