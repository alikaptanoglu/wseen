import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weloggerweb/main.dart';

import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';
import 'package:weloggerweb/screens/details.dart';
import 'package:weloggerweb/services/firestore.dart';

class ContactCard extends StatefulWidget {

  const ContactCard({Key? key}) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('webcontacts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (auth.currentUser == null) {
            return CircularProgressIndicator(color: ProjectColors.customColor);
          } else {
            if (snapshot.hasData) {
              final doc = snapshot.data!.docs.where((element) => element.get('users').keys.contains(auth.currentUser!.uid));
              return Column(
                  children: doc.map((document) {
                String name = document['users'][auth.currentUser!.uid]['name'];
                String documentId = document['document_id'];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(number: documentId))),
                  child: Stack(
                    children: [
                      Container(
                        height: Values.contactCardHeight,
                        width: SizeConfig.isDesktop!
                            ? 1000
                            : SizeConfig.screenWidth,
                        padding: ProjectPadding.horizontalPadding(value: 20),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color: ProjectColors.transparent,borderRadius: BorderRadius.circular(40),border: Border.all(color: document['is_online'] == null ? Colors.grey : document['is_online'] ? ProjectColors.onlineColor : ProjectColors.offlineColor, width: 1)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Row(
                            children: [
                              Image(image: ImageEnums.denemepersonicon.assetImage, color: ProjectColors.themeColorMOD2, width: 50, height: 50),
                              Space.sWidth,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProjectText.rText(
                                      text: name,
                                      fontSize: Values.fitValue,
                                      color: ProjectColors.customColor,
                                      fontWeight: FontWeight.bold),
                                  Space.xXSWidth,
                                  ProjectText.rText(text: documentId, fontSize: Values.sValue, color: ProjectColors.greyColor)
                                ],
                              )
                            ],
                          ),
                          GestureDetector(
                                  onTap: () {
                                    showDialog(context: context, builder: (context) => const Loading());
                                    DbService().deleteContactFromDatabase(FirebaseAuth.instance.currentUser!.uid, document.id).whenComplete(() => Navigator.of(context).popUntil((route) => route.isFirst));
                                  },
                                  child: Icon(Icons.delete, color: ProjectColors.offlineColor, size: Values.deleteIconSize))
                              
                        ]),
                      ),
                      Positioned(
                        top: 20,
                        left: SizeConfig.isDesktop!
                        ? (1000 - (Values.contactStatusWidth + 40)) / 2
                        : (SizeConfig.screenWidth! - (Values.contactStatusWidth + 40)) / 2,
                        child: Container(decoration: BoxDecoration(color: document['is_online'] == null ? ProjectColors.greyColor : document['is_online'] ? ProjectColors.onlineColor : ProjectColors.offlineColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Values.contactStatusRadius),bottomRight: Radius.circular(Values.contactStatusRadius))),
                        padding: ProjectPadding.horizontalPadding(value: 10),
                        height: Values.contactStatusHeight,
                        width: Values.contactStatusWidth,
                        child: Center(child: FittedBox(child: ProjectText.rText(text: document['is_online'] == null ? 'Waiting for first login' : document['is_online'] ? parsedJson['online'] : parsedJson['offline'], fontSize: Values.xSValue, color: ProjectColors.customColor)))))
                    ],
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
