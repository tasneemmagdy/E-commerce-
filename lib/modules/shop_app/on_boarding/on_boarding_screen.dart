import 'package:flutter/material.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/modules/shop_app/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Boarding{
  final String image;
  final String title;
  final String body;

  Boarding({
    required this.image,
    required this.title,
    required this.body
});
}


class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingController = PageController();

  bool isLast = false;
  void submit(){
    CasheHelper.saveData(
        key: 'OnBoarding',
        value:true
    ).then((value)
    {
      if(value){
        navigateAndFinish(
            context,
            LoginScreen()
        );
      }
    });
  }

  List<Boarding> boarding = [
    Boarding(
        image: 'assets/images/Online-store-on-mobile-application---Premium-image-PNG.png',
        title: 'OnBoarding 1 Title',
        body: 'OnBoarding 1 Body'
    ),
    Boarding(
        image: 'assets/images/image78s.png',
        title: 'OnBoarding 2 Title',
        body: 'OnBoarding 2 Body'
    ),
    Boarding(
        image: 'assets/images/imagesss16334015.png',
        title: 'OnBoarding 3 Title',
        body: 'OnBoarding 3 Body'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  color:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
                ),
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index) => buildBoardingItems(boarding[index]),
                itemCount: boarding.length,
                controller: onBoardingController ,
                physics: BouncingScrollPhysics(),
                onPageChanged:(int index)
                {
                 if(index == boarding.length-1){
                   setState(() {
                     isLast = true;
                   });
                 }
                   else{
                     setState(() {
                       isLast = false;
                     });
                 }
                } ,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: onBoardingController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4,
                      dotWidth: 10.0,
                      spacing: 5
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast){
                      submit();
                    }
                    else{
                      onBoardingController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.bounceInOut
                      );
                    }

                  },
                child: Icon(
                    Icons.arrow_forward_outlined
                ),
                ),
              ],
            )
          ],
        ),
      ),
    );


  }

  Widget buildBoardingItems(Boarding model) =>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox (
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );
}
