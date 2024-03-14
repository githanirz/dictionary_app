import 'package:dictionary_apps/model/model_login.dart';
import 'package:dictionary_apps/screen_page/page_list_kamus.dart';
import 'package:dictionary_apps/screen_page/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(
          Uri.parse("http://10.126.243.55/dictionaryDb/login.php"),
          body: {
            "username": username.text,
            "password": password.text,
          });
      ModelLogin data = modelLoginFromJson(res.body);

      if (data.value == 1) {
        setState(() {
          // session.saveSession(
          //     data.value ?? 0, data.id ?? "", data.username ?? "");

          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageListKamus()),
              (route) => false);
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Login To App Dictionary",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: username,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      hintText: "USERNAME",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blueAccent.withOpacity(0.2)),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      hintText: "PASSWORD",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.blueAccent.withOpacity(0.2)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : MaterialButton(
                            minWidth: 150,
                            height: 45,
                            color: Colors.blueAccent,
                            onPressed: () {
                              if (keyForm.currentState?.validate() == true) {
                                loginAccount();
                              }
                            },
                            child: Text("LOGIN"),
                          )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(width: 1, color: Colors.blue)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
                (route) => false);
          },
          child: const Text("Anda belum punya akun silahkan daftar"),
        ),
      ),
    );
  }
}
