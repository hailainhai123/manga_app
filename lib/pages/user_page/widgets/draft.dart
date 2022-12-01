// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:manga_app/constant/theme.dart';
// import 'package:manga_app/stl_widget/title_widget.dart';
//
// class Draft extends StatelessWidget {
//   const Draft({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChildHomeWidget(
//       title: 'Gửi bản thảo',
//       showRight: false,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//             itemDraft('assets/svg/fairytale.svg','Tiểu thuyết'),
//             itemDraft('assets/svg/voice-search.svg','Ghi Âm'),
//             itemDraft('assets/svg/translation.svg','Phiên dịch'),
//             itemDraft('assets/svg/story.svg','Truyện ngắn'),
//         ],
//       ),
//     );
//   }
//
//   Widget itemDraft (String assetName, String text){
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.black26,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       height: 65,
//       width: 80,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(assetName),
//           SizedBox(height: 8,),
//           Text(text, style: GoogleFonts.notoSans(
//             fontSize: 12, fontWeight: FontWeight.w600,),),        ],
//       ),
//     );
//   }
// }
