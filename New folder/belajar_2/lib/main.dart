import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffe3d5ca),
        appBar: AppBar(
          backgroundColor: Color(0xFFDDBEA9),
          title: Text("LOGIN PAGE"),
          titleTextStyle: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "MASUKAN E-ID SSRI",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "E-Mail Terdaftar",
                          hintText: "Masukkan Email Terdaftar",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Tolong Masukkan Email'
                              : null;
                        },
                      ),
                    ),

                    SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "NIS Terdaftar",
                          hintText: "Masukkan NIS Terdaftar",
                          prefixIcon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          return value!.isEmpty ? 'Tolong Masukkan NIS' : null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),

                    //Tombol Masuk
                    MaterialButton(
                      onPressed: () {},
                      minWidth: 200,
                      child: Text('Masuk'),
                      color: Color(0xff2B2C28),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),

                    //Teks Informasi
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Masukkan Email dan NIS yang Di Berikan Operator Sekolah',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
