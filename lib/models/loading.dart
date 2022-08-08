import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wseen/products/products.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({Key? key, this.color = Colors.orange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 80,
        decoration: BoxDecoration(color: ProjectColors.opacityDEFw(0.1), borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Logging in..',
              style: TextStyle(color: Color.fromARGB(255, 220, 220, 220), fontSize: 20),
            ),
            Space.sWidth,
            const CircularProgressIndicator(color: Color.fromARGB(255, 220, 220, 220))
          ],
        ),
      ),
    );
  }
}

class LoadingScreenWithDuration extends StatefulWidget {
  final Widget route;
  const LoadingScreenWithDuration({Key? key, required this.route}) : super(key: key);

  @override
  State<LoadingScreenWithDuration> createState() => _LoadingScreenWithDurationState();
}

class _LoadingScreenWithDurationState extends State<LoadingScreenWithDuration> {
  bool isLoad = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      isLoad = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 220, 220, 220)))
        : widget.route;
  }
}

class LoadingScreenThreeDots extends StatefulWidget {
  const LoadingScreenThreeDots({Key? key}) : super(key: key);

  @override
  State<LoadingScreenThreeDots> createState() => _LoadingScreenThreeDotsState();
}

class _LoadingScreenThreeDotsState extends State<LoadingScreenThreeDots> with TickerProviderStateMixin {

  late Timer timer; 
  double dx = 0;
  double isScreenOpac = 1;
  double isLoadingOpac = 1;
  bool visible = true;

  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  late AnimationController fifthController;
  late Animation<double> fifthAnimation;

  @override
  void initState() {

    // FIRST CONTROLLER
    firstController = AnimationController(vsync: this, duration: const Duration(seconds: 6));
    firstAnimation = Tween<double>(begin: -pi, end: pi).animate(firstController)..addListener(() { 
      setState(() {
        
      });
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed) firstController.repeat();
      if(status == AnimationStatus.dismissed) firstController.forward();
    }); 

    // SECOND CONTROLLER
    secondController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    secondAnimation = Tween<double>(begin: -pi, end: pi).animate(secondController)..addListener(() { 
      setState(() {
        
      });
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed) secondController.repeat();
      if(status == AnimationStatus.dismissed) secondController.forward();
    });    

    // THİRD CONTROLLER
    thirdController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    thirdAnimation = Tween<double>(begin: -pi, end: pi).animate(thirdController)..addListener(() { 
      setState(() {
        
      });
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed) thirdController.repeat();
      if(status == AnimationStatus.dismissed) thirdController.forward();
    });    

    // FOURTH CONTROLLER
    fourthController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: -pi, end: pi).animate(fourthController)..addListener(() { 
      setState(() {
        
      });
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed) fourthController.repeat();
      if(status == AnimationStatus.dismissed) fourthController.forward();
    });    

    // FİFTH CONTROLLER
    fifthController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fifthAnimation = Tween<double>(begin: -pi, end: pi).animate(fifthController)..addListener(() { 
      setState(() {
        
      });
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed) fifthController.repeat();
      if(status == AnimationStatus.dismissed) fifthController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), (){
      setState(() {
        isLoadingOpac = 0;
      });
    });

    Future.delayed(const Duration(seconds: 1), (){
      setState(() {
        isScreenOpac = 0;
      });
    });  

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) { 
      setState(() {
        dx += SizeConfig.screenWidth!/30;
      });
    });

    firstController.forward();
    secondController.forward();
    thirdController.forward();
    fourthController.forward();
    fifthController.forward();
    
    super.initState();
    
  }

  @override
  void dispose() {
    timer.cancel();
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    fifthController.dispose();
    super.dispose();
  }

  final Color bodyColor = const Color.fromARGB(255, 20, 22, 25);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: isScreenOpac,
        onEnd: () => setState(() => visible = false),
        child: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              color: bodyColor,
              child: Center(
                child: AnimatedOpacity(
                  opacity: isLoadingOpac,
                  duration: const Duration(milliseconds: 100),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CustomPaint(
                      painter: MyPainter(firstAnimation.value, secondAnimation.value, thirdAnimation.value, fourthAnimation.value, fifthAnimation.value),
                    ),
                  ),
                )
              ),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                width: SizeConfig.screenWidth,
                height: 3,
                child: CustomPaint(
                  painter: BNBPainter(dx),
                ),
              ),
            ) 
          ],
        ),
      ),
    );
  }
}

class LoadingTick extends StatefulWidget {
  const LoadingTick({Key? key}) : super(key: key);

  @override
  State<LoadingTick> createState() => LoadingTickState();
}

class LoadingTickState extends State<LoadingTick> {

  Timer? timer;
  bool isOpac = true;
  bool visible = true;
  double dx = 0;

  @override
  void initState() {
    
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) { 
      dx += SizeConfig.screenWidth!/30;
    });

    Future.delayed(const Duration(milliseconds: 1500), (){
      setState(() {
        isOpac = false;
        timer!.cancel();
      });
    });

    Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        visible = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: isOpac ? 1 : 0,
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: 3,
          child: CustomPaint(
            painter: BNBPainter(dx),
          ),
        ),
      ),
    );
  }
}

 class LoadingPainter extends CustomPainter{
  late double value;
  LoadingPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = ProjectColors.themeColorMOD5..strokeCap = StrokeCap.round..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    
    path.lineTo(0, size.height);
    path.lineTo(value, size.height);
    path.lineTo(value, 0);
    path.close();

    canvas.drawPath(path, paint);
 }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
 }

class MyPainter extends CustomPainter{

  final double firstAngle;
  final double secondAngle;
  final double thirdAngle;
  final double fourthAngle;
  final double fifthAngle;

  MyPainter(this.firstAngle, this.secondAngle, this.thirdAngle, this.fourthAngle, this.fifthAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint myArc = Paint()..color = ProjectColors.themeColorMOD5..style = PaintingStyle.stroke..strokeWidth = 1..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromLTRB(0, 0, size.width, size.height), firstAngle, 2, false, myArc);
    canvas.drawArc(Rect.fromLTRB(size.width * .1, size.height * .1, size.width * .9, size.height * .9), secondAngle, 2, false, myArc);
    canvas.drawArc(Rect.fromLTRB(size.width * .2, size.height * .2, size.width * .8, size.height * .8), thirdAngle, 2, false, myArc);
    canvas.drawArc(Rect.fromLTRB(size.width * .3, size.height * .3, size.width * .7, size.height * .7), fourthAngle, 2, false, myArc);
    canvas.drawArc(Rect.fromLTRB(size.width * .4, size.height * .4, size.width * .6, size.height * .6), fifthAngle, 2, false, myArc);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BNBPainter extends CustomPainter{

  final double dx;

  BNBPainter(this.dx);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = ProjectColors.themeColorMOD5..style = PaintingStyle.fill..strokeCap = StrokeCap.round;
    Path path = Path()..moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(dx, size.height);
    path.lineTo(dx, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Widget loadingWidget() => Center(child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(ProjectColors.themeColorMOD5)));

