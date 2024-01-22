import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? result;
  String? theError;
  bool executing = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              children: [
                if (result == null && theError == null)
                  Text(!executing ? 'Please Press to process' : 'Waiting')
                else if (result != null)
                  Text('Result:$result')
                else if (theError != null)
                  Text('Error:$theError'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = null;
                      theError = null;
                      executing = true;
                    });
                    getData().then((value) {
                      setState(() {
                        executing = false;
                        result = value;
                      });
                    }).catchError((catchedError) {
                      setState(() {
                        executing = false;
                        theError = catchedError;
                      });
                    });
                  },
                  child: Text('Action'),
                )
              ],
            ),
          ),
        ),
      );

  Future<String> getData() => Future<String>.delayed(
        const Duration(seconds: 3),
        () {
          throw 'Backend Error';
          return 'Data';
        },
      );
}
