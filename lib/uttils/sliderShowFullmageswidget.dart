import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/uttils/constant.dart';

import '../model/productdetail/productbanner.dart';
import '../widget/AppBarWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class SliderShowFullmages extends StatefulWidget{
   List<ProductBannerData> listBannerImage = [];
  final int current;
   final controller = PageController(viewportFraction: 1, keepPage: true);

  SliderShowFullmages(
      {required this.listBannerImage,
      required this.current,
    });


  @override
   _SliderShowFullmagesState createState() =>  _SliderShowFullmagesState();
}
class _SliderShowFullmagesState extends State<SliderShowFullmages>  {
  int _current = 0;
  bool _stateChange = false; 
  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    _current = (_stateChange == false) ? widget.current : _current;
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Product Image", false)),
      body:  getfullscreenImage(),
    );
  }
    Container getfullscreenImage(){

      final pages = List.generate(
        widget.listBannerImage.length,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: 
              InkWell(
                onTap: (){
                  
                },
                child:   Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                 child: FadeInImage.assetNetwork(
                      placeholder: placeholder_path,
                      image: widget.listBannerImage[index].imageFile,
                      fit: BoxFit.contain),
              ),
              )
            ,
            ));

      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  Column(
          children: [
            SizedBox(
                       height: MediaQuery.of(context).size.height - 100,
                        child: PageView.builder(
                          controller: widget.controller,
                          // itemCount: pages.length,
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: SmoothPageIndicator(
                            controller: widget.controller,
                            count: widget.listBannerImage.length,
                            effect: ScrollingDotsEffect(
                                activeStrokeWidth: 2.6,
                                activeDotScale: 1.3,
                                maxVisibleDots: 5,
                                radius: 8,
                                spacing: 10,
                                dotHeight: 12,
                                dotWidth: 12,
                                activeDotColor: Colors.cyan)),
                      )
          ],
        )
       
      );
    }      
  

}