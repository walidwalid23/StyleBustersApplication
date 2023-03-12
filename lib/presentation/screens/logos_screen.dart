import 'package:flutter/material.dart';
import 'package:stylebusters/presentation/reusable_widgets/DefaultFormField.dart';

class LogosScreen extends StatefulWidget {
   LogosScreen({Key? key}) : super(key: key);

  @override
  State<LogosScreen> createState() => _LogosScreenState();
}
class _LogosScreenState extends State<LogosScreen> {
  @override
  var key =GlobalKey<ScaffoldState>();
  var Formkey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  bool isBottomSheetShown = false;
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: key,
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
          ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(isBottomSheetShown){
                    Navigator.pop(context);
                    isBottomSheetShown=false;
                }
                else{
                    key.currentState!.showBottomSheet((context) => Container(
                      width: double.infinity,
                      height: 300.0,
                      color: Colors.grey[100],
                      child: Form(
                        key: Formkey,
                        child: Column(
                          children: [
                            // DefaultTextFormField(
                            //     Controller: titleController,
                            //     type: TextInputType.text,
                            //     hintText: 'Task title',
                            //     validate: (String value) {
                            //       if (value.isEmpty) {
                            //         return 'title must not be empty';
                            //       }
                            //     },
                            //     prefix: Icons.title
                            // ),
                            SizedBox(
                              height: 40.0,
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
                      ),
                    ));
                    isBottomSheetShown=true;
                }
              },
              child:Icon(
                  Icons.add
              ),
          ),
        )
    );
}
}
