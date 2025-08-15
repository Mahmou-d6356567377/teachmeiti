import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teachmeiti/utils/consts/const_colors.dart';
import 'package:teachmeiti/utils/consts/const_imgs.dart';


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: ConstColors.darkblue,
            child: Icon(Icons.menu, color: ConstColors.background,)),
        ),
        title: Text('Messages', style: GoogleFonts.cambay(color: ConstColors.darkblue)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: ConstColors.darkblue,
              child: Icon(Icons.notifications, color: ConstColors.background),
            ),
          ),
         
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              ConstImgs.banner2,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder:(context, index) {            
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(color: ConstColors.darkblue.withAlpha(12), width: 1.5),
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                   
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: SvgPicture.asset(
                      fit: BoxFit.cover,
                      ConstImgs.avatar,
                  ),),
                  title: Text('Chat $index', style: GoogleFonts.cambay(color: Colors.black)),
                  subtitle: Text('Last message in chat $index'),
                  trailing: Text('10:00 AM'),
                ),
              );
            }),
          )),
        ],
      ),
    );
  }
}