import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  Country _selectedCountry = Country(
    phoneCode: "90",
    countryCode: 'TR',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Turkey',
    example: '5050917463',
    displayName: 'Turkey',
    displayNameNoCountryCode: 'TR',
    e164Key: '',
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset("assets/lottie/login_logo.json"),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Welcome to Chatee",
                      style: GoogleFonts.montserrat(
                        color: Colors.deepPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          _controller.text = value;
                        });
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                        hintText: "Phone number",
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () => showCountryPicker(
                              countryListTheme: const CountryListThemeData(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                setState(
                                  () {
                                    _selectedCountry = country;
                                  },
                                );
                              },
                            ),
                            child: Text(
                                '${_selectedCountry.flagEmoji} +${_selectedCountry.phoneCode}'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _controller.text.length < 10 ? null : () {},
                        style: ElevatedButton.styleFrom(),
                        child: const Text('Send code'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
