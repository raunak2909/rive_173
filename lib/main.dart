import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateMachineController? controller;
  Artboard? mainArtBoard;
  SMIInput<bool>? inputON;


  @override
  void initState() {
    super.initState();

    //initializing RIVE
    rootBundle.load("assets/rive/fire.riv").then((riveByteData){
      
      var riveFile = RiveFile.import(riveByteData);
      
      var artboard = riveFile.mainArtboard;
      
      controller = StateMachineController.fromArtboard(artboard, "State Machine 1");

      if(controller!=null){
        artboard.addController(controller!);

        mainArtBoard = artboard;
        
        inputON = controller!.findInput("ON");

        setState(() {

        });

      }
      
      
      
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rive'),
      ),
      body: mainArtBoard!=null ? Center(
        child: InkWell(
          onTap: (){
            print("${inputON!.value}");
            inputON!.value = !inputON!.value;
          },
          child: Rive(
            artboard: mainArtBoard!,
            fit: BoxFit.cover,
          ),
        ),
      ) : Container(
        child: Center(
          child: Text('Loading..'),
        ),
      )
    );
  }
}
