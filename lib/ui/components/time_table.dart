// import 'package:flutter/material.dart';
// import 'package:sky_vacation/helper/font_style.dart';
// import 'package:sky_vacation/helper/localize.dart';
//
// class TimeTable extends StatelessWidget {
//   Function()? increaseMinutes, decreaseMinutes;
//   Function()? increaseHours, decreaseHours;
//   String? minutes, hours, dayTime, header;
//
//   TimeTable({
//       this.increaseMinutes,
//       this.decreaseMinutes,
//       this.increaseHours,
//       this.decreaseHours,
//       this.minutes,
//       this.hours,
//
//       this.header
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         color: AppColor.whiteColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         margin: EdgeInsets.all(8.0),
//         child: Padding(
//             padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     textDirection: TextDirection.rtl,
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Text(
//                           header ?? "",
//                           style: TS.cardText.copyWith(fontSize:Dim.fontSize14),
//
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Divider(
//                           height: 5.0,
//                           color: AppColor.dividerColor,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               textDirection: TextDirection.rtl,
//                               children: <Widget>[
//                                 Text(
//                                   Trans.of(context).t("minutesText"),
//                                   style: TS.vacationTypeTextStyle,
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: <Widget>[
//                                     IconButton(
//                                       icon: Icon(
//                                           Icons.keyboard_arrow_up,
//                                           color: AppColor.waitingColor,
//                                           size: 18.0,
//                                       ),
//                                       onPressed: increaseMinutes,
//                                     ),
//                                     Text(
//                                       minutes ?? "",
//                                       style: TS.vacationTypeTextStyle,
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         Icons.keyboard_arrow_down,
//                                         color: AppColor.waitingColor,
//                                         size: 18.0,
//                                       ),
//                                       onPressed: decreaseMinutes,
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               textDirection: TextDirection.rtl,
//                               children: <Widget>[
//                                 Text(
//                                   Trans.of(context).t("hoursText"),
//                                   style: TS.vacationTypeTextStyle,
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: <Widget>[
//                                     IconButton(
//                                       icon: Icon(
//                                           Icons.keyboard_arrow_up,
//                                           color: AppColor.waitingColor,
//                                           size: 18.0,
//                                       ),
//                                       onPressed: increaseHours,
//                                     ),
//                                     Text(
//                                       hours ?? "",
//                                       style: TS.vacationTypeTextStyle,
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         Icons.keyboard_arrow_down,
//                                         color: AppColor.waitingColor,
//                                         size: 18.0,
//                                       ),
//                                       onPressed: decreaseHours,
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//
//                           ],
//                         )
//                       ),
//
//                     ]
//                 )
//             )
//         // )
//     );
//   }
// }
