import 'package:flutter/material.dart';
import 'package:state_management/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: BlocProvider(
      create: (context) => CounterCubit(),
      child: const HomePage(),
    ),
  )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int counter = 2000;
  late CounterCubit cubit;

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
          BlocConsumer(
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



