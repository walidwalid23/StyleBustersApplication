import 'package:flutter/material.dart';

class LogosScreen extends StatelessWidget {
   LogosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Logos"
              ),
            ),
          ),
          body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (){},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        "Submit",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
            ),
          ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: (){},
              child:Icon(
                  Icons.add
              ),
          ),
        )
    );
}
}
