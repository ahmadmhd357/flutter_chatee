import 'package:chatee/constants.dart';
import 'package:chatee/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? otpCode;
  final _pinController = TextEditingController();
  final _foucsNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _foucsNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final verificationId = args['verificationId'] as String;
    final phoneNumber = args['phoneNumber'] as String;
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: const Color.fromRGBO(70, 69, 66, 1),
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(24),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
            offset: Offset(0, 3),
            blurRadius: 16,
          ),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Text(
                  'Verfication',
                  style: GoogleFonts.openSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Please enter the code we sent to the number',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  phoneNumber,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  controller: _pinController,
                  focusNode: _foucsNode,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                  onCompleted: (pin) {
                    setState(() {
                      otpCode = pin;
                    });
                    verifyCode(verificationId: verificationId, code: otpCode!);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Didn’t receive code?',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Resend',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromRGBO(62, 116, 165, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyCode({
    required String verificationId,
    required String code,
  }) {
    final authProvider = context.read<AuthProvider>();
    authProvider.verifyOTPCode(
        context: context,
        code: code,
        verificationId: verificationId,
        onSuccess: () async {
          bool userExists = await authProvider.checkUserExists();
          if (userExists) {
            await authProvider.getUserData();
            await authProvider.saveUserToSharedPreferences();
            navigate(userExists = true);
          } else {
            navigate(userExists = false);
          }
        });
  }

  void navigate(bool userExists) {
    userExists
        ? Navigator.of(context)
            .pushNamedAndRemoveUntil(Constants.home, (route) => false)
        : Navigator.of(context)
            .pushNamedAndRemoveUntil(Constants.userInfoScreen, (route) => false);
  }
}
