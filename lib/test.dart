// // import 'package:flutter/material.dart';
// // import 'package:just_music/core/utils/app_images.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<String> items = List.generate(1, (index) => 'Item ${index + 1}');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           final double screenHeight = constraints.maxHeight;
//           const double appBarHeight = 200.0; // Height of the SliverAppBar
//           final double listHeight =
//               items.length * 35; // Approximate height of list items

//           return CustomScrollView(
//             slivers: <Widget>[
//               SliverAppBar(
//                 title: const Text('SliverAppBar'),
//                 floating: true,
//                 pinned: true,
//                 expandedHeight: appBarHeight,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Container(color: Colors.blue),
//                 ),
//               ),
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text(items[index]),
//                     );
//                   },
//                   childCount: items.length,
//                 ),
//               ),
//               if (listHeight < screenHeight - appBarHeight)
//                 SliverToBoxAdapter(
//                   child: Container(
//                     height: screenHeight - appBarHeight - listHeight,
//                     color: Colors.transparent,
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
