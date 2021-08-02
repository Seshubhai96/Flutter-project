import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/services/Quries.dart';
import 'package:flutter_application_3/views/project_views/Products.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  //CarouselSliderController _sliderController;

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // _sliderController = CarouselSliderController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        thickness: 5,
        hoverThickness: 2,
        showTrackOnHover: true,
        controller: scrollController,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          controller: scrollController,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: MyQuries.carsoulQuery.snapshots(),
              // ignore: missing_return
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  height: 150,
                  child: CarouselSlider.builder(
                    enableAutoSlider: true,
                    autoSliderTransitionTime: Duration(milliseconds: 30),
                    autoSliderTransitionCurve: Curves.fastOutSlowIn,
                    unlimitedMode: true,
                    slideIndicator: CircularWaveSlideIndicator(
                        itemSpacing: 20,
                        alignment: Alignment.bottomCenter,
                        currentIndicatorColor: Colors.black),
                    itemCount: snapshot.data.docs.length,
                    slideBuilder: (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.docs[index]['carimage'],
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Category')
                    .snapshots(),
                // ignore: missing_return
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    height: 400,
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 2),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (_, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Productsscreen(
                                            catname: snapshot.data.docs[i]
                                                ['catname'],
                                            catslug: snapshot.data.docs[i]
                                                ['catslug'],
                                          )));
                            },
                            child: Card(
                              child: GridTile(
                                child: Text(""),
                                header: SizedBox(
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data.docs[i]['catimage'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                footer: Text(
                                  snapshot.data.docs[i]['catname'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Featured Products ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Featured').snapshots(),
              // ignore: missing_return
              builder: (_, snapshot) {
                if (!snapshot.hasError) {
                  print(snapshot.error);
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (_, i) {
                        return Card(
                          color: Colors.grey,
                          shape: ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          elevation: 5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child: CachedNetworkImage(
                                    imageUrl: snapshot.data.docs[i]
                                        ['Featured product']),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
                // return Card(
                //   elevation: 6,
                //   color: Colors.lightBlue[50],
                //   shape: ContinuousRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(60))),
                //   child: Swiper(
                //     layout: SwiperLayout.TINDER,
                //     itemCount: snapshot.data.docs.length,
                //     itemHeight: 200,
                //     itemWidth: 250,
                //     itemBuilder: (_, i) {
                //       return CachedNetworkImage(
                //           imageUrl: snapshot.data.docs[i]['Featured product']);
                //     },
                //   ),
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}
