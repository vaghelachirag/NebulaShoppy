import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/uttils/constant.dart';

import '../model/productdetail/productbanner.dart';
import '../widget/AppBarWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class SliderShowFullmages extends StatefulWidget{
   List<dynamic> listBannerImage = [];
 // late  int current;
   final controller = PageController(viewportFraction: 1, keepPage: true);
 int current = 0;

  SliderShowFullmages(
      {required this.listBannerImage,
      required this.current,
    });


  @override
   _SliderShowFullmagesState createState() =>  _SliderShowFullmagesState();
}
class _SliderShowFullmagesState extends State<SliderShowFullmages>  {
 late PageController controller ;
 
  bool _stateChange = false; 
  @override
  void initState() {
    super.initState();
    controller =  PageController(initialPage: widget.current, keepPage: false, viewportFraction: 1);
  }
 
  @override
  Widget build(BuildContext context) {
    widget.current = (_stateChange == false) ? widget.current : widget.current;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         getfullscreenImage(),
         Expanded(child: 
          getsmallscreenImage())
        ],
      )
      ,
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
                height: MediaQuery.of(context).size.height  -  MediaQuery.of(context).size.height/4,
                 child:  PinchZoom(
               child: FadeInImage.assetNetwork(
                      placeholder: placeholder_path,
                      image: widget.listBannerImage[index].hqImageFile,
                      fit: BoxFit.contain),
                resetDuration: const Duration(milliseconds: 100),
               maxScale: 2.5,
               onZoomStart: (){print('Start zooming');},
                onZoomEnd: (){print('Stop zooming');},
             )
                 
                  ,
              ),
              )
            ,
            ));

      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height  -  MediaQuery.of(context).size.height/4,
        color: Colors.white,
        child: SizedBox(
                       height: MediaQuery.of(context).size.height,
                        child: PageView.builder(
                            controller: controller,
                          // itemCount: pages.length,
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                           padEnds: true,   
                           itemCount:  widget.listBannerImage.length,
                              onPageChanged: (value) {                            
                              setState((){
                                widget.current = value;
                              });
                          },
                        ),
                      )
       
      );
    }      
  

   Container getsmallscreenImage(){
          return Container(
            child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (widget.listBannerImage.isEmpty) {
                      return Text("");
                    } else {
                      return 
                       Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child:
                       getSmallImages());
                    }
                  },
                ),
          );
       }

  Container getSmallImages() {
    return Container(
       height: MediaQuery.of(context).size.height/8,
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child:
              new Expanded(
           child: 
           Align(
            alignment: Alignment.center,
            child: 
           
             ListView.builder(
        itemCount: widget.listBannerImage.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
               setState(() {
                  widget.current = index;
                  controller.jumpToPage(widget.current);
               });
            },
            child: 
            Padding(padding: EdgeInsets.all(5),child: 
            Align(
              alignment: Alignment.center,
              child: 
                Container(
                 decoration: BoxDecoration(
           border: Border.all(color:  widget.current == index
                              ? Colors.black
                              : Colors.black12)
            ),
                child: SizedBox(
              width: MediaQuery.of(context).size.width / 6,
              child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child:  FadeInImage.assetNetwork(
                      placeholder: placeholder_path,
                      image: widget.listBannerImage[index].imageFile,
                      fit: BoxFit.fitHeight),
            ),
            ),
              ),
            ) 
          ));
        },
      ))),
          )
        ],
      )
      ,
    );
  }      

}