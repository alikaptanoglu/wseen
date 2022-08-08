import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/endsection.dart';
import 'package:wseen/models/floatingactionbutton.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';
import '../providers/modelprovider.dart';

class LastSeen extends StatefulWidget {
  const LastSeen({Key? key}) : super(key: key);

  @override
  State<LastSeen> createState() => _LastSeenState();
}

class _LastSeenState extends State<LastSeen> {

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
          const LoadingScreenThreeDots()
        ],
      ),
    );
  }

  Widget buildSection(){

    List<Widget> imageEndText = [
      Column(
        children: [
          _buildText('Whatsapp is the world’s number-one instant messaging app for a good reason. It’s convenient, it’s safe to use, it’s completely free, and it allows you to contact anyone in the world, as long as they have an internet connection smartphone capable of supporting the application. It also works flawlessly on tablets, laptops, PCs, and practically any other internet-connected device you could think of. However, like with any free service, it has its quirks, especially when it comes to personal privacy.'),
          Space.spaceHeight(40),
          _buildText('Let’s take the Whatsapp last seen feature, for example. Unless you deliberately turn this feature off, every one of your contacts can see exactly when you were last online and whether or not their messages have reached you. If you’re trying to avoid someone or would prefer not to chat to them right now, this is less than ideal – and likewise, if one of your contacts switches off their Whatsapp last seen, you simply can’t tell whether or not they’ve seen your texts. We’ve all been there, and it’s admittedly pretty frustrating sometimes, especially when it’s obvious that their last seen on Whatsapp is wrong.'),
          Space.spaceHeight(40),
          const SizedBox(width: double.infinity, child: Image(image: AssetImage('assets/images/ic_seewhensomeoneonline.png'), fit: BoxFit.cover)),
        ],
      ),
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(width: SizeConfig.screenWidth! * 0.4, child: _buildText('Whatsapp is the world’s number-one instant messaging app for a good reason. It’s convenient, it’s safe to use, it’s completely free, and it allows you to contact anyone in the world, as long as they have an internet connection smartphone capable of supporting the application. It also works flawlessly on tablets, laptops, PCs, and practically any other internet-connected device you could think of. However, like with any free service, it has its quirks, especially when it comes to personal privacy.')),
                  Space.spaceHeight(40),
                  SizedBox(width: SizeConfig.screenWidth! * 0.4, child:_buildText('Let’s take the Whatsapp last seen feature, for example. Unless you deliberately turn this feature off, every one of your contacts can see exactly when you were last online and whether or not their messages have reached you. If you’re trying to avoid someone or would prefer not to chat to them right now, this is less than ideal – and likewise, if one of your contacts switches off their Whatsapp last seen, you simply can’t tell whether or not they’ve seen your texts. We’ve all been there, and it’s admittedly pretty frustrating sometimes, especially when it’s obvious that their last seen on Whatsapp is wrong.')),
                ],
              ),
              Space.spaceWidth((SizeConfig.screenWidth! * 0.2)/3),
              SizedBox(width: SizeConfig.screenWidth! * 0.4 , child: const Image(image: AssetImage('assets/images/ic_seewhensomeoneonline.png'), fit: BoxFit.cover)),
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
          Align(alignment: Alignment.center, child: ProjectText.rText(text: 'Crack the Whatsapp Last Seen\n Feature with Wseen', fontSize: SizeConfig.screenWidth! > 1200 ? 60 : SizeConfig.screenWidth! > 800 ? 55 : SizeConfig.screenWidth! > 600 ? 45 : SizeConfig.screenWidth! > 400 ? 30 : 30, color: Colors.black, fontWeight: FontWeight.w800)),
          Space.spaceHeight(60),
          SizeConfig.screenWidth! > 800 ? imageEndText.last : imageEndText.first,
          Space.spaceHeight(60),
          ProjectText.rText(text: 'How the Timestamp System Works', fontSize: SizeConfig.screenWidth! > 1200 ? 35 : SizeConfig.screenWidth! > 800 ? 30 : SizeConfig.screenWidth! > 600 ? 28 : SizeConfig.screenWidth! > 400 ? 25 : 22, color: Colors.black, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
          Space.spaceHeight(20),
          _buildText('But what exactly is last seen, and how do you know how to turn off Whatsapp last seen on your own profile? Well, Whatsapp has a built-in timestamp that tells you whether a specific user is online or when they were ‘last seen’ at a particular time. For those users who want a bit more privacy on the app, they can choose to hide online Whatsapp android status from their other contacts, which removes this timestamp altogether.'),
          Space.spaceHeight(40),
          _buildText('Currently, there are three settings available to achieve this, allowing you to show this information to all Whatsapp users, only your contacts, or nobody at all. Of course, while your last seen information might be hidden, people will always be able to see when you are actively online.'),
          Space.spaceHeight(40),
          _buildText('If you want to know how to hide Whatsapp last seen time on your profile, you will need to choose the setting that bars everyone from viewing that info. If one of your contacts’ Whatsapp last seen today is not working, then you can be fairly certain that they have also turned off their friends’ ability to view their timestamps.'),
          Space.spaceHeight(60),
          ProjectText.rText(text: 'Stay One Step Ahead with Us', fontSize: SizeConfig.screenWidth! > 1200 ? 35 : SizeConfig.screenWidth! > 800 ? 30 : SizeConfig.screenWidth! > 600 ? 28 : SizeConfig.screenWidth! > 400 ? 25 : 22, color: Colors.black, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
          Space.spaceHeight(20),
          _buildText('Like with most privacy settings, the Whatsapp last seen feature can be both a blessing and a curse. As an example, let’s say that you are suspecting that your significant other isn’t being as faithful as they say they are. They’re always on their phone when they think you aren’t looking, sending texts under the duvet cover and spending just a little too much time in the bathroom with their smartphone in hand. If they have figured out how to turn off Whatsapp last seen, you won’t be able to see how frequently they’ve been online to confirm your suspicions. Well, not without our Wseen app, that is!'),
          Space.spaceHeight(40),
          _buildText('Wseen is our cutting-edge Whatsapp tracking app that allows you to monitor your friends’, family members’, significant others’ or even employees’ chatting habits and usage. Even if they have found out how to hide last seen in Whatsapp Android or iOS, you can use our app to obtain comprehensive timelines that show you exactly when they were online, when they logged off, and how much time they spent chatting in between.'),
          Space.spaceHeight(40),
          _buildText('If you suspect foul play, Wseen will also use the power of artificial intelligence to show you when your contact went to bed, how many contacts they spoke to within a given time frame, and much, much more. It can also confirm by default whether or not they have opted to Whatsapp disable online status. They might be able to hide online Whatsapp Android timestamps, but with Wseen, you will always be one step ahead...'),
          Space.spaceHeight(60),
          ProjectText.rText(text: 'Get the Truth with Wseen', fontSize: SizeConfig.screenWidth! > 1200 ? 35 : SizeConfig.screenWidth! > 800 ? 30 : SizeConfig.screenWidth! > 600 ? 28 : SizeConfig.screenWidth! > 400 ? 25 : 22, color: Colors.black, fontWeight: FontWeight.bold, textAlign: TextAlign.left),
          Space.spaceHeight(20),
          _buildText('Knowing exactly how to check who is online on Whatsapp is a priceless tool, regardless of why you need to know. Thanks to Wseen, you can not only check Whatsapp who is online, but also compare chatting habits between two contacts, discover a contact’s phone usage and sleeping habits, and so much more. How to see who is online on Whatsapp is only the tip of the iceberg… if you want to be a true DIY detective, you need to know the whole story, which is exactly why we are here! Enjoy a 2-day free trial of our innovative app today and answer that age old question, “Who were you chatting with at 3am?!” for good!'),
          Space.spaceHeight(40),
          _buildText('If you’ve noticed that one of your friends’ or family members’ Whatsapp last seen today is not working, chances are that they have turned off their Whatsapp lseen timestamp Android to fly under the radar for a while. They might even have already researched how to hide online on Whatsapp Android – and whether or not they’re up to something suspect is ultimately for you to decide. With that said, we at Wseen stand by our motto – Trust, but Verify.'),
        ],
      ),
    );
  }

  _buildText(String text) => ProjectText.rText(text: text, height: 1.8, fontSize: SizeConfig.screenWidth! > 1200 ? 18 : SizeConfig.screenWidth! > 800 ? 17 : SizeConfig.screenWidth! > 600 ? 16 : SizeConfig.screenWidth! > 400 ? 15 : 14, color: Colors.black87, textAlign: TextAlign.left, fontWeight: FontWeight.w400);

}