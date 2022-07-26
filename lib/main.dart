import 'package:flutter/material.dart';


import 'model/user_model.dart';
import 'service/user_service.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();
  bool? isLoading;
  List<UsersModelData?> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _service.fetchUsers().then((value) => {
        if(value != null && value.data != null){
        setState(() {
users = value.data!;
isLoading = true;
    }),
        } else{
        setState((){
          isLoading = false;
        })
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: isLoading == null ? const Center(
          child: CircularProgressIndicator(),
        )
            : isLoading == true ? ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index){
          return ListTile(
            title: Text("${users[index]!.firstName! + users[index]!.lastName!}"),
            subtitle: Text("${users[index]!.email}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(users[index]!.avatar!),
            ),
          );
        },
        ) : const Center(
          child: Text("Bir sorun oluştu"),
        ),
      ),
    );
  }
}

