import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';

class DetailsCard extends StatefulWidget {
  final String number;
  const DetailsCard({Key? key, required this.number}) : super(key: key);

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  @override
  Widget build(BuildContext context) {
    var totalActivities = 0;
    SizeConfig.init(context);
    return Consumer<ModelProvider>(
      builder: (context, value, child) {
        return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('webcontacts').doc(widget.number).collection('logs').where('start',isGreaterThanOrEqualTo: value.startDate, isLessThanOrEqualTo: value.endDate).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Duration totalDuration = const Duration(seconds: 0);
          bool isOnline = false;

          if(snapshot.hasData){
            DateTime onStart = DateTime.parse(formattedDate(Timestamp.fromDate(DateTime.now())));
            if(snapshot.data!.docs.isNotEmpty){
              isOnline = snapshot.data!.docs.first.get('end') == null ? true : false;
            }

            var i = 0;
            return Column(
              children: snapshot.data!.docs.map((document) {
                totalActivities = snapshot.data!.docs.length;
                final DateTime start;
                final DateTime end;
                Duration diff;

                start = DateTime.parse(formattedDate(document['start'])).subtract(const Duration(hours: 3));
                end = document['end'] == null
                    ? DateTime.parse(formattedDate(document['start'])).subtract(const Duration(hours: 3))
                    : DateTime.parse(formattedDate(document['end'])).subtract(const Duration(hours: 3));
                diff = end.difference(start);

                totalDuration += diff;
                
                document['end'] == null 
                  ? onStart = start
                  : null;

                i++;

                if(i == snapshot.data!.docs.length){
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    snapshot.data!.docs.isNotEmpty ? 
                    Container(
                        margin: const EdgeInsets.only(right: 10, left: 20, top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Values.contactCardRadius/2),color:Colors.transparent,border: Border.all(color: Colors.grey, width: 1)),
                        width: SizeConfig.screenWidth! < 600 ? (SizeConfig.screenWidth! * .4)-20 : 230,
                        height: 140,
                        child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const Text('Total Online Activities',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),textAlign: TextAlign.center), 
                        const SizedBox(height: 5,),
                        Text(totalActivities.toString(),style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400)),
                        ],
                        )),
                      ) : 
                      Container(),
                      Space.spaceWidth(20),
                      snapshot.data!.docs.isNotEmpty ? Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Values.contactCardRadius/2),color:Colors.transparent,border: Border.all(color: Colors.grey, width: 1),),
                        margin: const EdgeInsets.only(right: 20, left: 10, top: 20),
                        width: SizeConfig.screenWidth! < 600 ? (SizeConfig.screenWidth! * .4)-20 : 230,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 140,
                        child: isOnline ? StreamBuilder(
                                stream: Stream.periodic(const Duration(seconds: 1)),
                                builder: (context, snapshot) {
                                  Timestamp dateTimestamp = Timestamp.fromDate(DateTime.now());
                                  DateTime nowDate = DateTime.parse(formattedDate(dateTimestamp));
                                  final sayac = Duration(seconds: nowDate.difference(onStart).inSeconds);
                                  return Center(
                                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const Text('Total Online Duration',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),textAlign: TextAlign.center,), 
                        const SizedBox(height: 5,),
                        Text(printDuration(sayac + totalDuration),style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w400)),
                        ],
                        ),
                                  );
                                },
                              )
                            : 
                            Center(
                                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const Text('Total Online Duration',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),textAlign: TextAlign.center,), 
                        const SizedBox(height: 5,),
                        Text(printDuration(totalDuration),style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400,)),
                        ],
                        ),
                        ),
                      ) : Container(),
                    ],
                  );
                }else{
                  return Space.emptySpace;
                }
                
              }).toList(),
            );
          }else{
            return Space.emptySpace;
          }
        });
      },
    );
  }
}
