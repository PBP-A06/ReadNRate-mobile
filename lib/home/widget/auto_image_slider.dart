import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsImageSlider extends StatefulWidget{
  const NewsImageSlider({super.key});

  @override
  State<StatefulWidget> createState() => _NewsImageSliderState();
}

class _NewsImageSliderState extends State<NewsImageSlider> {
  final List<Widget> newsSlides = [

    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset('assets/banner1.png'),
    ),
    
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset('assets/banner2.png'),
    ),

    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset('assets/banner3.png'),
    ),

  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 120,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }
            ), 
            items: newsSlides,
          ),

        Container(
          padding: const EdgeInsets.only(top: 15),
          child: AnimatedSmoothIndicator(activeIndex: currentIndex, 
            count: newsSlides.length,
            effect: const WormEffect(
              dotHeight: 6,
              dotWidth: 6,
              spacing: 5,
              dotColor: Colors.white,
              activeDotColor: Color.fromARGB(193, 190, 55, 6),
              paintStyle: PaintingStyle.fill,
            ),
          )
        ),
      ]
    );
  }
}
