import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/constant.dart';

class SituationCard extends StatelessWidget {
  final String organIcon;
  final String statusIcon;
  final Function press;
  final Color statusColor;
  const SituationCard({
    Key key,
    this.organIcon,
    this.statusIcon,
    this.press,
    this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 0),
      padding: EdgeInsets.fromLTRB(8.0, 0.0, 7.0, 0.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        color: statusColor,
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          organIcon,
          width: media.width * 0.095,
          color: organIcon.contains('vaccine') ? Colors.white : null,
        ),
        trailing: SvgPicture.asset(statusIcon, width: media.width * 0.09),
      ),
    );
  }
}

// return ClipRRect(
//       borderRadius: BorderRadius.circular(30),
//       child: Container(
//         decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               color: statusColor,
//         ),
//         child: Material(
//           color: statusColor,
//           borderRadius: BorderRadius.circular(30),
//           child: InkWell(
//             splashColor: Colors.white,
//             highlightColor: statusColor,
//             onTap: press,
//             child: Stack(
//               children: [
//                 Positioned(
//                     top: 30,
//                     left: 30,
//                     child: SvgPicture.asset(organIcon),
//                   ),
//                 Positioned(
//                     top: 30,
//                     right: 30,
//                     child: SvgPicture.asset(statusIcon),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

// Container(
//             child: Stack(
//               children: [
//                 Positioned(
//                     top: 30,
//                     left: 30,
//                     child: SvgPicture.asset(organIcon),
//                   ),
//                 Positioned(
//                     top: 30,
//                     right: 30,
//                     child: SvgPicture.asset(statusIcon),
//                   ),
//               ],
//             ),
//             constraints: BoxConstraints.tightForFinite(
//               width: 300,
//               height: 250,
//             ),
//           ),
