import 'package:flutter/material.dart';
import 'package:state_management/calculator.dart';
import 'package:state_management/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    // home: BlocProvider(
    //   create: (context) => CounterCubit(),
    //   child: const HomePage(),
    // ),
    initialRoute: "/",
    onGenerateRoute: (settings) {
      switch(settings.name){
        case '/':
          return MaterialPageRoute(
              builder: (context) => BlocProvider(
                  create: (context) => CounterCubit(),
                  child: const HomePage())
          );
      }
    },
  )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late CounterCubit cubit;
  TextEditingController numController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("counter"),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<CounterCubit, int>(
            bloc: cubit,
            listener: (context, state) {
                final snackBar = SnackBar(content: Text("State is reached"));
                if (state == 5){
                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
             builder: (context, state) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: numController,
                        ),
                        Text("$state", textScaleFactor: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                cubit.increment();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent,
                                onPrimary: Colors.black,
                              ),
                              child: Text("Increment",),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                cubit.decrement();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                onPrimary: Colors.black,
                              ),
                              child: Text("Decrement"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                cubit.reset();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.yellowAccent,
                                onPrimary: Colors.black,
                              ),
                              child: Text("Reset"),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => Calculator(
                                          strValue: numController.text,
                                          counter: state,
                                          calculate: "multiply",
                                        )
                                    )
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.yellowAccent,
                                onPrimary: Colors.black,
                              ),
                              child: Text("X"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => Calculator(
                                          strValue: numController.text,
                                          counter: state,
                                          calculate: "divide",
                                        )
                                    )
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.yellowAccent,
                                onPrimary: Colors.black,
                              ),
                              child: Text("/"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
          ),
        ],
      )

      // /*
      //   "BlocConsumer" include both "BlocListener" and "BlocBuilder"
      // */
      // BlocConsumer<CounterCubit, int>(
      //   bloc: cubit,
      //   listener: (context, state) {
      //       final snackBar = SnackBar(content: Text("State is reached"));
      //       if (state == 5){
      //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //       }
      //     },
      //     /*
      //       ""
      //     */
      //   builder: (context, state) {
      //         return Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text("$state", textScaleFactor: 10,),
      //               ElevatedButton(
      //                   onPressed: () {
      //                     cubit.increment();
      //                   },
      //                   child: Text("Increment")
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     ),


      // /*
      //   "BlocListener" does not rebuild the page
      //   Use case: show notification/alert when a condition
      //   is met
      // */
      // BlocListener<CounterCubit, int>(
      //   bloc: cubit,
      //   listener: (context, state) {
      //     final snackBar = SnackBar(content: Text("State is reached"));
      //     if (state == 5){
      //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //     }
      //
      //   },
      //   /*
      //     "BlocBuilder" rebuilds the page
      //      Use case: changing a value in the page
      //   */
      //   child: BlocBuilder<CounterCubit, int>(
      //     bloc: cubit,
      //     builder: (context, state) {
      //       return Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text("$state", textScaleFactor: 10,),
      //             ElevatedButton(
      //                 onPressed: () {
      //                   cubit.increment();
      //                 },
      //                 child: Text("Increment")
      //             ),
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}



