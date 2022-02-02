import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';

abstract class InitAccountState {
  final InitAccountScreenState screen;
  InitAccountState(this.screen);

  Widget getUI(BuildContext context);
}
//
// class initAccountStateInit extends InitAccountState {
//   initAccountStateInit(InitAccountScreenState screen) : super(screen);
//
//   @override
//   Widget getUI(BuildContext context) {
//     return Text(S.of(context).initData);
//   }
// }

// class InitAccountStateLoading extends InitAccountState {
//   InitAccountStateLoading(screen) : super(screen);
//
//   @override
//   Widget getUI(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 32.0),
//               child: Container(
//                 width: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? Colors.grey[900]
//                       : Color.fromRGBO(236, 239, 241, 1),
//                 ),
//                 child: Flex(
//                   direction: Axis.vertical,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: 35,
//                         height: 35,
//                         child: Center(child: CircularProgressIndicator()),
//                       ),
//                     ),
//                     Container(
//                       height: 8,
//                     ),
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           S.of(context).loading,
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }

// class InitAccountStateError extends InitAccountState {
//   final String errorMsg;
//
//   InitAccountStateError(
//     this.errorMsg,
//     InitAccountScreenState screen,
//   ) : super(screen);
//
//   @override
//   Widget getUI(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.maxFinite,
//         height: double.maxFinite,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(50.0),
//             child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.red,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: Text(
//                           errorMsg,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: Center(
//                             child: RaisedButton(
//                           elevation: 3,
//                           onPressed: () {
//
//                           },
//                           color: Colors.red[600],
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Text(
//                             '${S.of(context).refresh}',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         )),
//                       )
//                     ],
//                   ),
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class InitAccountStateSubscribeSuccess extends InitAccountState {
//   InitAccountStateSubscribeSuccess(InitAccountScreenState screen)
//       : super(screen);
//   @override
//   Widget getUI(BuildContext context) {
//     return Scaffold();
//   }
// }
