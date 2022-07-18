import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/uttils/constant.dart';

import '../model/productdetail/productbanner.dart';
import '../widget/AppBarWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class SliderShowFullmages extends StatefulWidget{
   List<dynamic> listBannerImage = [];
  late  int current;
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
                height: MediaQuery.of(context).size.height / 2,
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
        height: MediaQuery.of(context).size.height / 2,
        color: Colors.white,
        child: SizedBox(
                       height: MediaQuery.of(context).size.height,
                        child: PageView.builder(
                          // itemCount: pages.length,
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
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
                      return Center(child: 
                       getSmallImages());
                    }
                  },
                ),
          );
       }

  Container getSmallImages() {
    return Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height/8,
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
               });
            },
            child: 
            Padding(padding: EdgeInsets.all(2),child: 
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
                      fit: BoxFit.contain),
            ),
            ),
              ),
            ) 
          ));
        },
      ),
    ));
  }      
  

}