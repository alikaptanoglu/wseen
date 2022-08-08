import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/endsection.dart';
import 'package:wseen/models/floatingactionbutton.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';
import '../providers/modelprovider.dart';

class OnlineChecker extends StatefulWidget {
  const OnlineChecker({Key? key}) : super(key: key);

  @override
  State<OnlineChecker> createState() => _OnlineCheckerState();
}

class _OnlineCheckerState extends State<OnlineChecker> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ModelProvider>(context, listen: false).setAnimatedFloatButtonPositionedValue(0);  
    });
    scrollController.addListener(() { 
      if(scrollController.position.pixels > 1000){
        Provider.of<ModelProvider>(context, listen: false).setAnimatedFloatButtonPositionedValue(30);
      }else{
        Provider.of<ModelProvider>(context, listen: false).setAnimatedFloatButtonPositionedValue(0);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          ActionButton(scrollController: scrollController)
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 15, 17, 19),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  buildSection(),
                  const EndSection()
                ],
              ),
            ),
          ),
          const MainBar(),
          const LoadingScreenThreeDots(),
        ],
      ),
    );
  }

  Widget buildSection(){

    List<Widget> imageEndText = [
      Column(
        children: [
          _buildText('Remember that amazing feature on MXit, the legendary chatting service of the early 2000s, that allowed you to check when your friends and contacts were online virtually at all times? You always knew when they were up, when they had been online, and when they were sleeping or otherwise busy and unable to talk. Catching a cheating S.O. or a ghoster was far easier because of that feature, too – but the tightening of virtual security in recent years has done away with this handy mechanic in favor of much stricter privacy controls.'),
          Space.spaceHeight(40),
          const SizedBox(width: double.infinity, child: Image(image: AssetImage('assets/images/ic_whatsapptexting.png'), fit: BoxFit.cover)),
          Space.spaceHeight(40),
          _buildText('MXit itself might seem woefully outdated today compared to modern apps like Whatsapp, but the fact remains that it was always beneficial to be able to see who was online and when. It was far easier to know if someone was avoiding your messages or sneaking around without your knowledge with that feature intact. On the other hand, how to check someone’s last seen on Whatsapp has always been a little more tricky… until now, that is.'),
          Space.spaceHeight(40),
          _buildText('If you’ve been missing that invaluable ability to see who’s online and when they’ve logged off, don’t despair – we have the answer for you! We at Wseen are proud to bring you our Whatsapp online status checker app; a premium AI-based application that shows you exactly how to see who is online on Whatsapp – and how to check someone’s last seen on Whatsapp, too. Never again will you have to be left in the dark when it comes to which of your friends, family members or colleagues are online; our app does everything for you, giving you all the intel you need without having to splash out on pricey Private Eye services.'),
          Space.spaceHeight(40),
          const SizedBox(width: double.infinity, child: Image(image: AssetImage('assets/images/ic_whatsapplastseen.png'), fit: BoxFit.cover)),
        ],
      ),
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: SizeConfig.screenWidth! * 0.4, child: _buildText('Remember that amazing feature on MXit, the legendary chatting service of the early 2000s, that allowed you to check when your friends and contacts were online virtually at all times? You always knew when they were up, when they had been online, and when they were sleeping or otherwise busy and unable to talk. Catching a cheating S.O. or a ghoster was far easier because of that feature, too – but the tightening of virtual security in recent years has done away with this handy mechanic in favor of much stricter privacy controls.')),
              Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/3),
              SizedBox(width: SizeConfig.screenWidth! * 0.4 , child: const Image(image: AssetImage('assets/images/ic_whatsapptexting.png'), fit: BoxFit.cover)),
            ],
          ),
          Space.spaceHeight(40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(width: SizeConfig.screenWidth! * 0.4, child: _buildText('MXit itself might seem woefully outdated today compared to modern apps like Whatsapp, but the fact remains that it was always beneficial to be able to see who was online and when. It was far easier to know if someone was avoiding your messages or sneaking around without your knowledge with that feature intact. On the other hand, how to check someone’s last seen on Whatsapp has always been a little more tricky… until now, that is.')),
                  Space.spaceHeight(40),
                  SizedBox(width: SizeConfig.screenWidth! * 0.4, child:_buildText('If you’ve been missing that invaluable ability to see who’s online and when they’ve logged off, don’t despair – we have the answer for you! We at Wseen are proud to bring you our Whatsapp online status checker app; a premium AI-based application that shows you exactly how to see who is online on Whatsapp – and how to check someone’s last seen on Whatsapp, too. Never again will you have to be left in the dark when it comes to which of your friends, family members or colleagues are online; our app does everything for you, giving you all the intel you need without having to splash out on pricey Private Eye services.')),
                ],
              ),
              Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/3),
              SizedBox(width: SizeConfig.screenWidth! * 0.4 , child: const Image(image: AssetImage('assets/images/ic_whatsapplastseen.png'), fit: BoxFit.cover)),
            ],
          ),
        ],
      )
    ];

    return Container(
      width: SizeConfig.screenWidth,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! > 800 ? (SizeConfig.screenWidth! * 0.2)/3 : SizeConfig.screenWidth! > 500 ? 60 : SizeConfig.screenWidth! > 400 ? 40 : SizeConfig.screenWidth! > 300 ? 20 : 10) + EdgeInsets.only(top: 60, bottom: SizeConfig.screenWidth! < 600 ? 140 : 160),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.center, child: ProjectText.rText(text: 'Check Their Online Status with Wseen', fontSize: SizeConfig.screenWidth! > 1200 ? 60 : SizeConfig.screenWidth! > 800 ? 55 : SizeConfig.screenWidth! > 600 ? 50 : SizeConfig.screenWidth! > 400 ? 40 : 35, color: Colors.black, fontWeight: FontWeight.w800)),
          Space.spaceHeight(60),
          SizeConfig.screenWidth! > 800 ? imageEndText.last : imageEndText.first,
          Space.spaceHeight(60),
          ProjectText.rText(text: 'How Our Whatsapp Online Checker Works', fontSize: SizeConfig.screenWidth! > 1200 ? 35 : SizeConfig.screenWidth! > 800 ? 30 : SizeConfig.screenWidth! > 600 ? 28 : SizeConfig.screenWidth! > 400 ? 25 : 22, color: Colors.black, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
          Space.spaceHeight(20),
          _buildText('The curious minds out there may be wondering exactly how we show Wseen users when someone is online on Whatsapp. Our app is based on advanced artificial intelligence that gathers data on your contacts’ usage habits and uses unique algorithms to make predictions about their activities. Simply put, if you want to know how to check who is online on Whatsapp, or simply discover how to find online friends in Whatsapp, Wseen will assess this information and send it back to you in a convenient and easy-to-read format.'),
          Space.spaceHeight(40),
          _buildText('Of course, our app’s capabilities aren’t limited to simply showing you when your contacts are online. We can also show you exactly how much time they spend chatting on Whatsapp, how often they log on, and pecisely when they were last online. All you need to access these ground-breaking services is a computer and a Whatsapp account – as well as the certainty that you really do want to know what your contacts are up to! If you are absolutely certain that you do, it’s definitely time to take the leap…'),
          Space.spaceHeight(60),
          ProjectText.rText(text: 'Why You Need Wseen’s Services', fontSize: SizeConfig.screenWidth! > 1200 ? 35 : SizeConfig.screenWidth! > 800 ? 30 : SizeConfig.screenWidth! > 600 ? 28 : SizeConfig.screenWidth! > 400 ? 25 : 22, color: Colors.black, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
          Space.spaceHeight(20),
          _buildText('There are many scenarios in which knowing who is online on Whatsapp might come in handy. Did you send your date a message a few days ago and haven’t heard back yet? Do you want to know if you’re being ghosted so that you can move on and explore greener pastures? Are you suspecting your significant other of chatting with someone else when they take suspicious trips to the bathroom at 3am? Are you worried about a BFF that you haven’t heard back from in a while? No matter why you need to get notification when someone is online on Whatsapp, we’re here to help you out.'),
          Space.spaceHeight(40),
          _buildText('If you need to know when a specific person has logged on, our Whatsapp last seen checker will even send you instant notifications so that you can catch them while they’re still online and avoid missing out on staying in contact. This is by far the easiest way to check when someone is online by Whatsapp, and we’ve made it happen to make your life simpler. Gone are the days of waiting online for hours in the hopes of catching that elusive contact when they log on; Wseen’s online notify Whatsapp Android technology does all the work on your behalf, leaving you with more time to kick back, do a Tinder Profile Search, and enjoy a few episodes (or seasons!) on Netflix.'),
          Space.spaceHeight(60),
          ProjectText.rText(text: 'Put Your Mind at Ease Today', fontSize: SizeConfig.screenWidth! > 1200 ? 35 : SizeConfig.screenWidth! > 800 ? 30 : SizeConfig.screenWidth! > 600 ? 28 : SizeConfig.screenWidth! > 400 ? 25 : 22, color: Colors.black, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
          Space.spaceHeight(20),
          _buildText('Knowing exactly how to check who is online on Whatsapp is a priceless tool, regardless of why you need to know. Thanks to Wseen, you can not only check Whatsapp who is online, but also compare chatting habits between two contacts, discover a contact’s phone usage and sleeping habits, and so much more. How to see who is online on Whatsapp is only the tip of the iceberg… if you want to be a true DIY detective, you need to know the whole story, which is exactly why we are here! Enjoy a 2-day free trial of our innovative app today and answer that age old question, “Who were you chatting with at 3am?!” for good!')
        ],
      ),
    );
  }

  _buildText(String text) => ProjectText.rText(text: text, height: 2, fontSize: SizeConfig.screenWidth! > 1200 ? 20 : SizeConfig.screenWidth! > 800 ? 18 : SizeConfig.screenWidth! > 600 ? 17 : SizeConfig.screenWidth! > 400 ? 16 : 14, color: Colors.black87, textAlign: TextAlign.left, fontWeight: FontWeight.w400);

}