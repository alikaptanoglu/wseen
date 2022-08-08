import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wseen/models/endsection.dart';
import 'package:wseen/models/models.dart';
import 'package:wseen/products/products.dart';
import 'package:wseen/providers/providers.dart';
import '../models/floatingactionbutton.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  
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
        ProjectText.rText(text: 'Terms of Service', fontSize: w < 300 ? 30 : w < 400 ? 35 : w < 500 ? 40 : w < 600 ? 45 : w < 800 ? 50 : 60, color: Colors.black, fontWeight: FontWeight.w800),
        _s20(),
        SizedBox(width: w < 300 ? w - 30 : w < 400 ? w - 60 : w < 600 ? w - 100 : w < 1000 ?  w - 160 : 900,child: ProjectText.rText(text: 'Terms of service for w-seen.com', fontSize: w < 300 ? 15 : w < 400 ? 16 : w < 500 ? 18 : w < 600 ? 20 : 22, height: 2, textAlign: TextAlign.center, color: Colors.grey, fontWeight: FontWeight.w400)),
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
          _buildHeadText('Introduction'),
          _s10(),
          _buildText('Welcome to w-seen.net. This website is owned and operated by Desarrollo del Potencial Organizacional S de RL. By visiting our website and accessing the information, resources, services, products, and tools we provide, you understand and agree to accept and adhere to the following terms and conditions as stated in this policy (hereafter referred to as ‘User Agreement’), along with the terms and conditions as stated in our Privacy Policy (please refer to the Privacy Policy section below for more information).'),
          _s20(),
          _buildText('This agreement is in effect as of Jul 25, 2022.'),
          _s20(),
          _buildText('We reserve the right to change this User Agreement from time to time without notice. You acknowledge and agree that it is your responsibility to review this User Agreement periodically to familiarize yourself with any modifications. Your continued use of this site after such modifications will constitute acknowledgment and agreement of the modified terms and conditions.'),
          _s50(),
          _buildHeadText('Responsible Use and Conduct'),
          _s10(),
          _buildText('By visiting our website and accessing the information, resources, services, products, and tools we provide for you, either directly or indirectly (hereafter referred to as ‘Resources’), you agree to use these Resources only for the purposes intended as permitted by (a) the terms of this User Agreement, and (b) applicable laws, regulations and generally accepted online practices or guidelines.'),
          _s20(),
          _buildText('Wherein, you understand that:'),
          _s20(),
          _buildText('a. In order to access our Resources, you may be required to provide certain information about yourself (such as identification, contact details, etc.) as part of the registration process, or as part of your ability to use the Resources. You agree that any information you provide will always be accurate, correct, and up to date.'),
          _s20(),
          _buildText('b. You are responsible for maintaining the confidentiality of any login information associated with any account you use to access our Resources. Accordingly, you are responsible for all activities that occur under your account/s.'),
          _s20(),
          _buildText('c. Accessing (or attempting to access) any of our Resources by any means other than through the means we provide, is strictly prohibited. You specifically agree not to access (or attempt to access) any of our Resources through any automated, unethical or unconventional means.'),
          _s20(),
          _buildText('d. Engaging in any activity that disrupts or interferes with our Resources, including the servers and/or networks to which our Resources are located or connected, is strictly prohibited.'),
          _s20(),
          _buildText('e. Attempting to copy, duplicate, reproduce, sell, trade, or resell our Resources is strictly prohibited.'),
          _s20(),
          _buildText('f. You are solely responsible any consequences, losses, or damages that we may directly or indirectly incur or suffer due to any unauthorized activities conducted by you, as explained above, and may incur criminal or civil liability.'),
          _s20(),
          _buildText('g. We may provide various open communication tools on our website, such as blog comments, blog posts, public chat, forums, message boards, newsgroups, product ratings and reviews, various social media services, etc. You understand that generally we do not pre-screen or monitor the content posted by users of these various communication tools, which means that if you choose to use these tools to submit any type of content to our website, then it is your personal responsibility to use these tools in a responsible and ethical manner. By posting information or otherwise using any open communication tools as mentioned, you agree that you will not upload, post, share, or otherwise distribute any content that:'),
          _s20(),
          _buildText('i. Is illegal, threatening, defamatory, abusive, harassing, degrading, intimidating, fraudulent, deceptive, invasive, racist, or contains any type of suggestive, inappropriate, or explicit language;\nii. Infringes on any trademark, patent, trade secret, copyright, or other proprietary right of any party;\nIii. Contains any type of unauthorized or unsolicited advertising;\nIiii. Impersonates any person or entity, including any Wseen.net employees or representatives.'),
          _s20(),
          _buildText('We have the right at our sole discretion to remove any content that, we feel in our judgment does not comply with this User Agreement, along with any content that we feel is otherwise offensive, harmful, objectionable, inaccurate, or violates any 3rd party copyrights or trademarks. We are not responsible for any delay or failure in removing such content. If you post content that we choose to remove, you hereby consent to such removal, and consent to waive any claim against us.'),
          _s20(),
          _buildText('h. We do not assume any liability for any content posted by you or any other 3rd party users of our website. However, any content posted by you using any open communication tools on our website, provided that it doesn’t violate or infringe on any 3rd party copyrights or trademarks, becomes the property of Desarrollo del Potencial Organizacional S de RL, and as such, gives us a perpetual, irrevocable, worldwide, royalty-free, exclusive license to reproduce, modify, adapt, translate, publish, publicly display and/or distribute as we see fit. This only refers and applies to content posted via open communication tools as described, and does not refer to information that is provided as part of the registration process, necessary in order to use our Resources. All information provided as part of our registration process is covered by our privacy policy.'),
          _s20(),
          _buildText('i. You agree to indemnify and hold harmless Desarrollo del Potencial Organizacional S de RL and its parent company and affiliates, and their directors, officers, managers, employees, donors, agents, and licensors, from and against all losses, expenses, damages and costs, including reasonable attorneys’ fees, resulting from any violation of this User Agreement or the failure to fulfill any obligations relating to your account incurred by you or any other person using your account. We reserve the right to take over the exclusive defense of any claim for which we are entitled to indemnification under this User Agreement. In such event, you shall provide us with such cooperation as is reasonably requested by us.'),
          _s50(),
          _buildHeadText('Privacy'),
          _s10(),
          _buildText('Your privacy is very important to us, which is why we’ve created a separate Privacy Policy in order to explain in detail how we collect, manage, process, secure, and store your private information. Our privacy policy is included under the scope of this User Agreement. To read our privacy policy in its entirety, click here.'),
           _s50(),
          _buildHeadText('Limitation of Warranties'),
          _s10(),
          _buildText('By using our website, you understand and agree that all Resources we provide are “as is” and “as available”. This means that we do not represent or warrant to you that:\ni) the use of our Resources will meet your needs or requirements.\nii) the use of our Resources will be uninterrupted, timely, secure or free from errors.\niii) the information obtained by using our Resources will be accurate or reliable, and\niv) any defects in the operation or functionality of any Resources we provide will be repaired or corrected.'),
          _s20(),
          _buildText('Furthermore, you understand and agree that:'),
          _s20(),
          _buildText('v) any content downloaded or otherwise obtained through the use of our Resources is done at your own discretion and risk, and that you are solely responsible for any damage to your computer or other devices for any loss of data that may result from the download of such content.\nvi) no information or advice, whether expressed, implied, oral or written, obtained by you from Desarrollo del Potencial Organizacional S de RL or through any Resources we provide shall create any warranty, guarantee, or conditions of any kind, except for those expressly outlined in this User Agreement.'),
          _s50(),
          _buildHeadText('Limitation of Liability'),
          _s10(),
          _buildText('In conjunction with the Limitation of Warranties as explained above, you expressly understand and agree that any claim against us shall be limited to the amount you paid, if any, for use of products and/or services. Desarrollo del Potencial Organizacional S de RL will not be liable for any direct, indirect, incidental, consequential or exemplary loss or damages which may be incurred by you as a result of using our Resources, or as a result of any changes, data loss or corruption, cancellation, loss of access, or downtime to the full extent that applicable limitation of liability laws apply.'),
          _s50(),
          _buildHeadText('Copyrights/Trademarks'),
          _s10(),
          _buildText('All content and materials available on Wseen.net, including but not limited to text, graphics, website name, code, images and logos are the intellectual property of Desarrollo del Potencial Organizacional S de RL, and are protected by applicable copyright and trademark law. Any inappropriate use, including but not limited to the reproduction, distribution, display or transmission of any content on this site is strictly prohibited, unless specifically authorized by Desarrollo del Potencial Organizacional S de RL.'),
          _s50(),
          _buildHeadText('Termination of Use'),
          _s10(),
          _buildText('You agree that we may, at our sole discretion, suspend or terminate your access to all or part of our website and Resources with or without notice and for any reason, including, without limitation, breach of this User Agreement. Any suspected illegal, fraudulent or abusive activity may be grounds for terminating your relationship and may be referred to appropriate law enforcement authorities. Upon suspension or termination, your right to use the Resources we provide will immediately cease, and we reserve the right to remove or delete any information that you may have on file with us, including any account or login information.'),
           _s50(),
          _buildHeadText('Governing Law'),
          _s10(),
          _buildText('This website is controlled by Desarrollo del Potencial Organizacional S de RL. It can be accessed by most countries around the world. By accessing our website, you agree that the statutes and laws of our state, without regard to the conflict of laws and the United Nations Convention on the International Sales of Goods, will apply to all matters relating to the use of this website and the purchase of any products or services through this site.'),
          _s20(),
          _buildText('Furthermore, any action to enforce this User Agreement shall be brought in the federal or state courts You hereby agree to personal jurisdiction by such courts, and waive any jurisdictional, venue, or inconvenient forum objections to such courts.'),
           _s50(),
           _buildHeadText('Guarantee'),
          _s10(),
          _buildText('UNLESS OTHERWISE EXPRESSED, Desarrollo del Potencial Organizacional S de RL EXPRESSLY DISCLAIMS ALL WARRANTIES AND CONDITIONS OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES AND CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.'),
           _s50(),
          _buildHeadText('Contact Information'),
          _s10(),
          _buildText('If you have any questions or comments about these our Terms of Service as outlined above, you can contact us at:'),
          _s20(),
          _buildText('www.w-seen.com'),
          Space.spaceHeight(100),
        ],
      ),
    );
  }

  _s10() => Space.spaceHeight(10);

  _s20() => Space.spaceHeight(20);

  _s50() => Space.spaceHeight(50);

  _buildHeadText(String text) => ProjectText.rText(text: text, fontSize: SizeConfig.screenWidth! > 1200 ? 28 : SizeConfig.screenWidth! > 800 ? 26 : SizeConfig.screenWidth! > 600 ? 24 : SizeConfig.screenWidth! > 400 ? 22 : 20, color: Colors.black, fontWeight: FontWeight.w800, textAlign: TextAlign.left);

  _buildText(String text) => ProjectText.rText(text: text, height: 2, fontSize: SizeConfig.screenWidth! > 1200 ? 16 : SizeConfig.screenWidth! > 800 ? 15 : SizeConfig.screenWidth! > 600 ? 14 : SizeConfig.screenWidth! > 400 ? 13 : 12, color: Colors.black87, textAlign: TextAlign.left, fontWeight: FontWeight.w400);
}

