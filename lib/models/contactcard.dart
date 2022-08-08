import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wseen/main.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/services/firestore.dart';

class ContactCard extends StatefulWidget {
  final bool isFreeTrialOver;
  final bool isPremium;
  const ContactCard({Key? key, required this.isPremium, required this.isFreeTrialOver}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('webcontacts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (auth.currentUser == null) {
            return Space.emptySpace;
            //return const LoadingThreeDots();
          } else {
            if (snapshot.hasData) {
              final doc = snapshot.data!.docs.where((element) => element.get('users').keys.contains(auth.currentUser!.uid));
              return Column(
                children: doc.map((document) {
                Color colorState() => document['is_online'] == null ? ProjectColors.greyColor : document['is_online'] ? ProjectColors.onlineColor : ProjectColors.offlineColor;
                String onlineState() => document['is_online'] == null ? 'Waiting for first login' : document['is_online'] ? 'Online' : 'Offline';
                String name = document['users'][auth.currentUser!.uid]['name'];
                String documentId = document['document_id'];
                return GestureDetector(
                  onTap: () {
                    if(widget.isPremium) {
                      Navigator.of(context).pushNamed('/monitor/details', arguments: document.id);
                    } else{
                      Navigator.of(context).pushNamed('/payment', arguments: widget.isFreeTrialOver);
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Stack(
                      children: [
                        Container(
                          height: Values.contactCardHeight,
                          width: SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 : 500,
                          padding: ProjectPadding.horizontalPadding(value: 20),
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(color: ProjectColors.transparent,borderRadius: BorderRadius.circular(40),border: Border.all(color: widget.isPremium ? colorState() : widget.isFreeTrialOver ? Colors.grey : colorState(), width: 1)),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Row(
                              children: [
                                Image(image: ImageEnums.denemepersonicon.assetImage, color: ProjectColors.themeColorMOD2, width: 50, height: 50),
                                Space.sWidth,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth!/3), child: FittedBox(child: ProjectText.rText(text: name, fontSize: 18, color: ProjectColors.customColor, fontWeight: FontWeight.bold))),
                                    Space.xXSWidth,
                                    Text('+$documentId', style: GoogleFonts.roboto(fontSize: 14, color: ProjectColors.greyColor))
                                  ],
                                )
                              ],
                            ),
                            GestureDetector(
                                    onTap: () {
                                      showDialog(context: context, builder: (context) => const LoadingThreeDots());
                                      DbService().deleteContactFromDatabase(FirebaseAuth.instance.currentUser!.uid, document.id).whenComplete(() => Navigator.of(context).pop());
                                    },
                                    child: Icon(Icons.delete, color: ProjectColors.offlineColor, size: Values.deleteIconSize))
                                
                          ]),
                        ),
                        Positioned(
                          top: 20,
                          left: (SizeConfig.screenWidth! < 600 ? SizeConfig.screenWidth! * .8 - Values.contactStatusWidth : 500 - Values.contactStatusWidth)/2,
                          child: Container(decoration: BoxDecoration(color: widget.isPremium ? colorState() : widget.isFreeTrialOver ? Colors.grey : colorState(), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Values.contactStatusRadius),bottomRight: Radius.circular(Values.contactStatusRadius))),
                          padding: ProjectPadding.horizontalPadding(value: 10),
                          height: Values.contactStatusHeight,
                          width: Values.contactStatusWidth,
                          child: Center(child: FittedBox(child: ProjectText.rText(text: widget.isPremium ? onlineState() : widget.isFreeTrialOver ? 'Buy premium' : onlineState(), fontSize: Values.xSValue, color: ProjectColors.customColor)))))
                      ],
                    ),
                  ),
                );
              }).toList());
            } else {
              return Space.emptySpace;
            }
          }
        });
  }
}
