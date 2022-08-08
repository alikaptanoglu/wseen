import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wseen/products/products.dart';

class Failed extends StatelessWidget {
  const Failed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth! > 600 ? 500 : SizeConfig.screenWidth!/1.2,
                      height: SizeConfig.screenWidth! < 350 ? 300 : 350,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.screenWidth! > 350 ? 198 : 178,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth! < 400 ? 50 : 60,
                                  height: SizeConfig.screenWidth! < 400 ? 50 : 60,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 178, 59, 48)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                                  child: const Icon(Icons.close, color: Colors.white, size: 30),
                                ),
                                Space.spaceHeight(10),
                                GradientText('Payment Failed!', gradient: const LinearGradient(colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 178, 59, 48)], begin: Alignment.centerLeft, end: Alignment.centerRight), style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 18 : SizeConfig.screenWidth! < 400 ? 20 : SizeConfig.screenWidth! < 600 ? 23  : 26, fontWeight: FontWeight.bold)),
                                Space.spaceHeight(10),
                                Text('Transaction Number: 1234534632134', style: GoogleFonts.poppins(fontSize: SizeConfig.screenWidth! < 350 ? 12 : SizeConfig.screenWidth! < 400 ? 13 : SizeConfig.screenWidth! < 600 ? 14  : 16, color: Colors.black26, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          _dottedLine(),
                          SizedBox(
                            height: SizeConfig.screenWidth! > 350 ? 150 : 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: SizeConfig.screenWidth! > 600 ? 380 : SizeConfig.screenWidth!/1.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Amount Paid', style: GoogleFonts.poppins(color: Colors.grey, fontSize: SizeConfig.screenWidth! < 350 ? 12 : SizeConfig.screenWidth! < 400 ? 13 : SizeConfig.screenWidth! < 600 ? 14  : 16)),
                                      Text(r'$12.99', style: GoogleFonts.poppins(color: Colors.grey, fontSize: SizeConfig.screenWidth! < 350 ? 12 : SizeConfig.screenWidth! < 400 ? 13 : SizeConfig.screenWidth! < 600 ? 14  : 16)),
                                    ],
                                  ),
                                ),
                                Space.spaceHeight(10),
                                SizedBox(
                                  width: SizeConfig.screenWidth! > 600 ? 380 : SizeConfig.screenWidth!/1.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Bank', style: GoogleFonts.poppins(color: Colors.grey, fontSize: SizeConfig.screenWidth! < 350 ? 12 : SizeConfig.screenWidth! < 400 ? 13 : SizeConfig.screenWidth! < 600 ? 14  : 16)),
                                      Text('Mellat Bank', style: GoogleFonts.poppins(color: Colors.grey, fontSize: SizeConfig.screenWidth! < 350 ? 12 : SizeConfig.screenWidth! < 400 ? 13 : SizeConfig.screenWidth! < 600 ? 14  : 16)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: SizeConfig.screenWidth! < 350 ? -30 : -25,
                      top: SizeConfig.screenWidth! < 350 ? 160 : 180,
                      child: SizedBox(
                        child: CircleAvatar(backgroundColor: const Color.fromARGB(255, 245, 245, 245), radius: SizeConfig.screenWidth! < 350 ? 20 : 20),
                      )
                    ),
                    Positioned(
                      right: SizeConfig.screenWidth! < 350 ? -30 : -25,
                      top: SizeConfig.screenWidth! < 350 ? 160 : 180,
                      child: SizedBox(
                        child: CircleAvatar(backgroundColor: const Color.fromARGB(255, 245, 245, 245), radius: SizeConfig.screenWidth! < 350 ? 20 : 20),
                      )
                    ),
                  ],
                ),
                Visibility(
                  visible: SizeConfig.screenWidth! > 800 ? true : false,
                  child: Row(
                    children: [
                      Space.spaceWidth(SizeConfig.screenWidth! < 900 ? 40 : SizeConfig.screenWidth! * .1),
                      Image(image: const AssetImage('assets/images/ic_successpayment.png'), width: SizeConfig.screenWidth! * .2 > 250 ? 250 : SizeConfig.screenWidth! * .2),
                    ],
                  ),
                ),
              ],
            ),
            SizeConfig.screenWidth! < 1000 ? Space.spaceHeight(40) : Space.emptySpace,
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/main'),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: SizeConfig.screenWidth! < 400 ? SizeConfig.screenWidth! * .8 : 300,
                  height: 50,
                  decoration: BoxDecoration(color: ProjectColors.themeColorMOD5, borderRadius: BorderRadius.circular(15)),
                  child: Center(child: Text('Back to Home', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16))),
                ),
              ),
            ),
          ],
        )),
    );
  }

         

  Center _dottedLine() {
    return Center(
                  child: SizedBox(
                    height: 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 45,
                      itemBuilder: (BuildContext context, int index) {
                        if(index%2 == 1){
                          return Container(
                            width: SizeConfig.screenWidth! > 600 ? 400/60 : SizeConfig.screenWidth!/90,
                            height: 1,
                            color: Colors.white,
                          );
                        } 
                        return Container(
                          width: SizeConfig.screenWidth! > 600 ? 400/40 : SizeConfig.screenWidth!/60,
                          height: 2,
                          color: const Color.fromARGB(255, 240, 240, 240),
                        );
                      }
                    ),
                  ),
                );
  }
}