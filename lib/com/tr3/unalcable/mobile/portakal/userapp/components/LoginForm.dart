import 'package:flutter/material.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/components/Home.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/conf/Configuration.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/FirebaseService.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/RestApiService.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/TokenService.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.controller, required this.title});
  final PageController controller;

  final String title;
  @override
  State<LoginForm> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginForm> {
  final _service = FirebaseNotificationservice();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

 
  @override
  void initState() {
    super.initState();
    _service.connectNotification();
  }

  Color baseColor = Color(0xFFFF6600);
  Color inputColor = Colors.black54;

  String _username = "";
  String _password = "";
  String? fcmtoken = "";
  

  void _postDataAndSaveToken(username, password, BuildContext context) async {
     RestApiService restApiService = RestApiService();

    TokenService tokenService = await TokenService.getInstance();

    await _service.messaging.getToken().then((value) {
      fcmtoken = value;
    });

    var resp = await restApiService.post(
        "/mobile/user-app/login?username=$username&password=$password&token=$fcmtoken",
        {});

    // Get the value of the "data" field
    String data = resp["data"];

    print(resp);
    // Access token
    RegExp regex = RegExp(r'(?<=token\s:\s).*?(?=\s})');
    String token = regex.firstMatch(data)?.group(0) ?? '';

    await tokenService.saveToken(token);

    int respCode = resp['code'];
    print(respCode);
    if (respCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Home(title: "Anasayfa")));
    }


    // var response = await restApiService.get("/mobile/user-app/notifications");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Image.asset(
              "assets/images/mobil-login-page.png",
              width: 413,
              height: 350,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 27,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _usernameController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    labelStyle: TextStyle(
                      color: inputColor,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: inputColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: inputColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passController,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: inputColor,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: TextStyle(
                      color: inputColor,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: inputColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: inputColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 329,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        _postDataAndSaveToken(_username, _password, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseColor,
                      ),
                      child: const Text(
                        'Giriş',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Kayıtlı hesabınız yok mu?',
                      style: TextStyle(
                        color: inputColor,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 2.5,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Text(
                        'Kaydol',
                        style: TextStyle(
                          color: inputColor,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Şifreninizi mi unuttunuz?',
                  style: TextStyle(
                    color: inputColor,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
      
        onPressed: () => _showUrlDialog(context),
          tooltip: 'Set URL',
          child: Icon(Icons.edit),
       
      
      ),
    );
  }
      void _showUrlDialog(BuildContext context) {
    final urlController = TextEditingController();
    String urlChanged = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter New URL'),
          content: TextField(
            controller: urlController,
            decoration: InputDecoration(hintText: "192.168.111.9:8080"),
            onChanged: (value) {
                    setState(() {
                      urlChanged ="http://"+ value + "/unierp";
                    });
                  },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
               
                Configuration.setBaseUrl(urlChanged);
                 print(Configuration.baseUrl);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


 