import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';

class Details extends StatefulWidget {
  final String number;
  const Details({Key? key, required this.number}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            const CustomBar(),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight! - 60,
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 22, 22, 25), Colors.black, Color.fromARGB(255, 15, 17, 19)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    contactCard(),
                    const DateWidget(),
                    DetailsCard(number: widget.number),
                    LogCard(number: widget.number)
                ]),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget contactCard(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('webcontacts').doc(widget.number).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot>snapshot){
        if(snapshot.hasData){
          final String name = snapshot.data!.get('users')[FirebaseAuth.instance.currentUser!.uid]['name'];
          final bool? isOnline = snapshot.data!.get('is_online');
          final Timestamp? lastSeenTimestamp = snapshot.data!.get('last_seen');
          DateTime? lastSeen = lastSeenTimestamp != null ? DateTime.parse(formattedDate(lastSeenTimestamp)) : null;
          return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! < 350 ? 10 : 20),
           width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
          height: 80,
          decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: ProjectColors.greyColor, width: 1), borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(image: ImageEnums.denemepersonicon.assetImage, color: ProjectColors.themeColorMOD2, width: 50, height: 50),
                  Space.spaceWidth(SizeConfig.screenWidth! < 350 ? 5 : 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth!/3), child: FittedBox(child: ProjectText.rText(text: name, fontSize: 18, color: ProjectColors.customColor, fontWeight: FontWeight.bold))),
                      Container(constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth!/4) , child: FittedBox(child: Text('+${widget.number}', style: GoogleFonts.roboto(fontSize: 14, color: ProjectColors.greyColor)))),
                    ],
                  )
                ],
              ),
              isOnline == null ? ProjectText.rText(text: 'No Data', fontSize: SizeConfig.screenWidth! < 350 ? 16 : 20) : isOnline ? onlineState : offlineState(lastSeen!)
            ],
          ),
        );
        }
        else{
          return const LoadingThreeDots();
        }
      },
    );
  }

  Widget offlineState(DateTime lastSeen) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProjectText.rText(text: 'Last Seen', fontSize: 16, color: ProjectColors.onlineColor),
                Space.xSWidth,
                ProjectText.rText(text: DateFormat().add_MEd().format(lastSeen), fontSize: 14, color: ProjectColors.greyColor),
              ],
            );
  }

  Widget get onlineState => ProjectText.rText(text: 'Online', fontSize: 16, color: ProjectColors.onlineColor);

}



        