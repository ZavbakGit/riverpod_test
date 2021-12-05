// final valueProvider = Provider<int>((ref) {
//   return 56;
// });

// final counterStateProvider = StateProvider<int>((ref) {
//   return 0;
// });


// class MyhomePage extends ConsumerWidget {
//   const MyhomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final counter = ref.watch(counterStateProvider);

//     ref.listen<int>(counterStateProvider, (previous, current) {
//       // note: this callback executes when the provider value changes,
//       // not when the build method is called
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Value is $current')),
//       );
//     });

//     return Scaffold(
//       body: Center(
//         child: Consumer(
//           builder: (context, ref, child) {
//             return Text('Value: $counter');
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           ref.read(counterStateProvider.state).state++;
//         },
//       ),
//     );
//   }
// }

// final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
//   return Clock();
// });

// class Clock extends StateNotifier<DateTime> {
//   // 1. initialize with current time
//   Clock() : super(DateTime.now()) {
//     // 2. create a timer that fires every second
//     _timer = Timer.periodic(Duration(seconds: 1), (_) {
//       // 3. update the state with the current time
//       state = DateTime.now();
//     });
//   }

//   late final Timer _timer;

//   // 4. cancel the timer when finished
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
// }

// class MyHomePageClock extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // this line is used to watch the provider's *state*
//     // to get an instance of the clock itself,
//     // call `ref.watch(clockProvider.notifier)`
//     final currentTime = ref.watch(clockProvider);
//     // format the time as `hh:mm:ss`
//     final timeFormatted = DateFormat.Hms().format(currentTime);
//     return Scaffold(
//       body: Center(
//         child: Text(
//           timeFormatted,
//           style: Theme.of(context).textTheme.headline4,
//         ),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.1
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Test riverpod',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: MyHomePageClock(),
//     );
//   }
// }


// class MyhomePageStl extends StatelessWidget {
//   const MyhomePageStl({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Consumer(
//           builder: (context, ref, child) {
//             final value = ref.watch(valueProvider);
//             return Text('Value: $value');
//           },
//         ),
//       ),
//     );
//   }
// }
