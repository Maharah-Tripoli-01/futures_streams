import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://google.com'));

  return response.body;
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    print('Rebuilding');
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<String>(
              future: getData(),
              builder: (context, snapshot) {
                print('Rebuilding: Child');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Waiting');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    return Text('Data: ${snapshot.data}');
                  }
                }
                return const Text('Anything else');
              }),
        ),
      ),
    );
  }

  Future<String> getData() {
    return Future.delayed(
      const Duration(seconds: 3),
      () {
        print('excecuting Future');
        // throw 'Backend Error';
        return 'Data';
      },
    );
  }
}
