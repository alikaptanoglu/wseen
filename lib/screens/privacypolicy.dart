import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/endsection.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';
import '../models/floatingactionbutton.dart';
import '../providers/providers.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  
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
          SingleChildScrollView(
            controller: scrollController,
            child: Container(
              color: Colors.white,
              width: SizeConfig.screenWidth!,
              child: Column(
                children: [
                  header(),
                  section(),
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

  Widget header(){
    double w = SizeConfig.screenWidth!;
    return Column(
      children: [
        Space.spaceHeight(140),
        ProjectText.rText(text: 'Privacy Policy', fontSize: w < 300 ? 30 : w < 400 ? 35 : w < 500 ? 40 : w < 600 ? 45 : w < 800 ? 50 : 60, color: Colors.black, fontWeight: FontWeight.w800),
        Space.spaceHeight(20),
        SizedBox(width: w < 300 ? w - 30 : w < 400 ? w - 60 : w < 600 ? w - 100 : w < 1000 ?  w - 160 : 900,child: ProjectText.rText(text: 'This privacy policy has been compiled to better serve those who are concerned with how their ‘Personally Identifiable Information’ (PII) is being used online. PII, as described in US privacy law and information security, is information that can be used on its own or with other information to identify, contact, or locate a single person, or to identify an individual in context. Please read our privacy policy carefully to get a clear understanding of how we collect, use, protect or otherwise handle your Personally Identifiable Information in accordance with our website.', fontSize: w < 300 ? 15 : w < 400 ? 16 : w < 500 ? 18 : w < 600 ? 20 : 22, height: 2, textAlign: TextAlign.center, color: Colors.grey, fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget section(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! > 800 ? SizeConfig.screenWidth! * .05 + 20 : SizeConfig.screenWidth! > 500 ? 30 : SizeConfig.screenWidth! > 400 ? 20 : SizeConfig.screenWidth! > 300 ? 10 : 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space.spaceHeight(100),
          _buildHeadText('What personal information do we collect from the people that visit our blog, website or app?'),
          Space.spaceHeight(10),
          _buildText('We do not collect information from visitors of our site or other details to help you with your experience.'),
          Space.spaceHeight(50),
          _buildHeadText('When do we collect information?'),
          Space.spaceHeight(10),
          _buildText('We collect information from you when you enter information on our site.'),
          Space.spaceHeight(50),
          _buildHeadText('How do we use your information?'),
          Space.spaceHeight(10),
          _buildText('We may use the information we collect from you when you register, make a purchase, sign up for our newsletter, respond to a survey or marketing communication, surf the website, or use certain other site features in the following ways:'),
           Space.spaceHeight(50),
          _buildHeadText('How do we protect your information?'),
          Space.spaceHeight(10),
          _buildText('Our website is scanned on a regular basis for security holes and known vulnerabilities in order to make your visit to our site as safe as possible.'),
           Space.spaceHeight(50),
          _buildHeadText('We use regular Malware Scanning'),
          Space.spaceHeight(10),
          _buildText('Your personal information is contained behind secured networks and is only accessible by a limited number of persons who have special access rights to such systems, and are required to keep the information confidential. In addition, all sensitive/credit information you supply is encrypted via Secure Socket Layers (SSL) technology.'),
          Space.spaceHeight(20),
          _buildText('We implement a variety of security measures when a user enters, submits, or accesses their information to maintain the safety of your personal information.'),
          Space.spaceHeight(20),
          _buildText('All transactions are processed through a gateway provider and are not stored or processed on our servers.'),
          Space.spaceHeight(50),
          _buildHeadText('Do we use ‘cookies’?'),
          Space.spaceHeight(10),
          _buildText('We do not use cookies for tracking purposes.'),
          Space.spaceHeight(20),
          _buildText('You can choose to have your computer warn you each time a cookie is being sent, or you can choose to turn off all cookies. You do this through your browser settings. Since browser is a little different, look at your browser’s Help Menu to learn the correct way to modify your cookies.'),
          Space.spaceHeight(20),
          _buildText('If you turn cookies off, Some of the features that make your site experience more efficient may not function properly.that make your site experience more efficient and may not function properly.'),
           Space.spaceHeight(50),
          _buildHeadText('Third-party disclosure'),
          Space.spaceHeight(10),
          _buildText('We do not sell, trade, or otherwise transfer to outside parties your Personally Identifiable Information unless we provide users with advance notice. This does not include website hosting partners and other parties who assist us in operating our website, conducting our business, or serving our users, so long as those parties agree to keep this information confidential. We may also release information when it’s release is appropriate to comply with the law, enforce our site policies, or protect ours or others’ rights, property or safety.'),
          Space.spaceHeight(20),
          _buildText('However, non-personally identifiable visitor information may be provided to other parties for marketing, advertising, or other uses.'),
           Space.spaceHeight(50),
          _buildHeadText('Third-party links'),
          Space.spaceHeight(10),
          _buildText('Occasionally, at our discretion, we may include or offer third-party products or services on our website. These third-party sites have separate and independent privacy policies. We therefore have no responsibility or liability for the content and activities of these linked sites. Nonetheless, we seek to protect the integrity of our site and welcome any feedback about these sites.'),

           Space.spaceHeight(50),
           _buildHeadText('Google'),
          Space.spaceHeight(10),
          _buildText('Google’s advertising requirements can be summed up by Google’s Advertising Principles. They are put in place to provide a positive experience for users.'),
          Space.spaceHeight(20),
          _buildText('We have not enabled Google AdSense on our site but we may do so in the future.'),

           Space.spaceHeight(50),
          _buildHeadText('Users can visit our site anonymously.'),
          Space.spaceHeight(10),
          _buildText('Once this privacy policy is created, we will add a link to it on our home page or as a minimum, on the first significant page after entering our website.'),
          Space.spaceHeight(20),
          _buildText('Our Privacy Policy link includes the word ‘Privacy’ and can easily be found on the page specified above.'),
          Space.spaceHeight(20),
          _buildText('You will be notified of any Privacy Policy changes:'),
          Space.spaceHeight(20),
          _buildText('• On our Privacy Policy Page'),
          Space.spaceHeight(20),
          _buildText('Can change your personal information:'),
          Space.spaceHeight(20),
          _buildText('• By emailing us'),
          Space.spaceHeight(50),
          _buildHeadText('How does our site handle Do Not Track signals?'),
          Space.spaceHeight(10),
          _buildText('We honor Do Not Track signals and Do Not Track, plant cookies, or use advertising when a Do Not Track (DNT) browser mechanism is in place.'),
          Space.spaceHeight(50),
          _buildHeadText('Does our site allow third-party behavioral tracking?'),
          Space.spaceHeight(10),
          _buildText('It’s also important to note that we do not allow third-party behavioral tracking'),
          Space.spaceHeight(50),
          _buildHeadText('COPPA (Children Online Privacy Protection Act)'),
          Space.spaceHeight(10),
          _buildText('When it comes to the collection of personal information from children under the age of 13 years old, the Children’s Online Privacy Protection Act (COPPA) puts parents in control. The Federal Trade Commission, United States’ consumer protection agency, enforces the COPPA Rule, which spells out what operators of websites and online services must do to protect children’s privacy and safety online.'),
          Space.spaceHeight(20),
          ProjectText.rText(text: 'We do not specifically market to children under the age of 13 years old.', height: 2, fontSize: SizeConfig.screenWidth! > 1200 ? 16 : SizeConfig.screenWidth! > 800 ? 15 : SizeConfig.screenWidth! > 600 ? 14 : SizeConfig.screenWidth! > 400 ? 13 : 12, color: Colors.grey, textAlign: TextAlign.left, fontWeight: FontWeight.w600),
          Space.spaceHeight(50),
          _buildHeadText('Do we let third-parties, including ad networks or plug-ins collect PII from children under 13'),
          Space.spaceHeight(10),
          _buildText('No we do not let third-parties, collect PII from children under 13.'),
          Space.spaceHeight(50),
          _buildHeadText('Fair Information Practices'),
          Space.spaceHeight(10),
          _buildText('The Fair Information Practices Principles form the backbone of privacy law in the United States and the concepts they include have played a significant role in the development of data protection laws around the globe. Understanding the Fair Information Practice Principles and how they should be implemented is critical to comply with the various privacy laws that protect personal information.'),
          Space.spaceHeight(20),
          _buildText('In order to be in line with Fair Information Practices we will take the following responsive action, should a data breach occur:'),
          Space.spaceHeight(20),
          _buildText('We will notify the users via in-site notification'),
          Space.spaceHeight(20),
          _buildText('• Within 7 business days'),
          Space.spaceHeight(20),
          _buildText('We also agree to the Individual Redress Principle which requires that individuals have the right to legally pursue enforceable rights against data collectors and processors who fail to adhere to the law. This principle requires not only that individuals have enforceable rights against data users, but also that individuals have recourse to courts or government agencies to investigate and/or prosecute non-compliance by data processors.'),
          Space.spaceHeight(50),
          _buildHeadText('CAN SPAM Act'),
          Space.spaceHeight(10),
          _buildText('The CAN-SPAM Act is a law that sets the rules for commercial email, establishes requirements for commercial messages, gives recipients the right to have emails stopped from being sent to them, and spells out tough penalties for violations.'),
          Space.spaceHeight(20),
          _buildText('We collect your email address in order to:\nTo be in accordance with CANSPAM, we agree to the following:\nIf at any time you would like to unsubscribe from receiving future emails, you can email us at support@Wseen.net and we will promptly remove you from ALL correspondence.'),
          Space.spaceHeight(50),
          _buildHeadText('Contacting Us'),
          Space.spaceHeight(10),
          _buildText('If there are any questions regarding this privacy policy, you may contact us using the information below.'),
          Space.spaceHeight(20),
          _buildText('www.w-seen.com\nIstanbul/Sarıyer - Etiler, 34337\nTurkey\nSupport mail: info@wseen.com'),
          Space.spaceHeight(20),
          _buildText('Last Edited on 06-07-2022'),
          Space.spaceHeight(100),
        ],
      ),
    );
  }

  _buildHeadText(String text) => ProjectText.rText(text: text, fontSize: SizeConfig.screenWidth! > 1200 ? 28 : SizeConfig.screenWidth! > 800 ? 26 : SizeConfig.screenWidth! > 600 ? 24 : SizeConfig.screenWidth! > 400 ? 22 : 20, color: Colors.black, fontWeight: FontWeight.w800, textAlign: TextAlign.left);

  _buildText(String text) => ProjectText.rText(text: text, height: 2, fontSize: SizeConfig.screenWidth! > 1200 ? 16 : SizeConfig.screenWidth! > 800 ? 15 : SizeConfig.screenWidth! > 600 ? 14 : SizeConfig.screenWidth! > 400 ? 13 : 12, color: Colors.black87, textAlign: TextAlign.left, fontWeight: FontWeight.w400);
}

