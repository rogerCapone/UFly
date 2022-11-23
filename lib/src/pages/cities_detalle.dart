import 'package:carousel_slider/carousel_slider.dart';
import 'package:flights/src/models/city_model.dart';
import 'package:flights/src/services/local_DB/goSoon_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CitiesDetalle extends StatelessWidget {
  GoSoonDb db = GoSoonDb();

  @override
  Widget build(BuildContext context) {
    final CityInfo city = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            CarouselWithIndicator(city: city),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10),
                _posterCity(context, city),
                _descripcion(city),
                (city.scoreData.scoreInfo[0].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        0,
                        'Takes in to account the amount of available houses and flats, the amount of space provided and their corresponding quality.Also considers the average price per square meter.	',
                        Colors.blueAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[1].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        1,
                        'Its a calculation/estimation of goods and services that houses need to consume to reach some satisfaction or determined live status (modus vivendi). So its the relation between what you need to pay to reach certain live style. To be more precise we should take in to account that is a macroeconomic concept.',
                        Colors.orange)
                    : SizedBox(),
                (city.scoreData.scoreInfo[2].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        2,
                        'Consists in the evaluation of a growing market that promotes technological evolution, also with a good educational network, so enterpreneurs can have a comfortable and relaiable fiscal enviroment.',
                        Colors.green)
                    : SizedBox(),
                (city.scoreData.scoreInfo[3].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        3,
                        'It defines the average probability for a business to get temporal resources from third-parties to the business heritage in order to increase or power the expansion and also value of the corresponding company. So this is an aspect that companies should consider when exapanding their market networks.',
                        Colors.cyanAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[4].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        4,
                        'Shows the wealth of the public transport network, also the private, but this last one takes less weigth in the equation, This way we can see how easy and also cost efficient will be our visit to this city. ',
                        Colors.amberAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[5].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        5,
                        'This value is similar to travel conectivity but is more focused on the availability to get the local transport, which means taking the train, bus taxi, or metro. Not taking in to account connection flights. Or middle or long transport means.',
                        Colors.blue)
                    : SizedBox(),
                (city.scoreData.scoreInfo[6].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        6,
                        'This is straight forward related with the freedom for companies to get things done. Normally its very related with the mentality of the actual governament. And this also means if there are more or less dificulties for companies to open, to expand, to make local business,...',
                        Colors.greenAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[7].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        7,
                        'Releted to the amount of crime that we can found in the city. High percentage values mean that there is no such a big deal to get worry about your security. This doesnt mean there is no crime, but its less probabily. A low percentage means that there is a higher crime risk. So stay caution. And try to avoid certain places if possible. ',
                        Colors.deepOrangeAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[8].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        8,
                        'Refers to the medical infrastructure of the city, how fast is their health system. Also it considers if its public or otherwise its private so you have to pay to get decent health care.',
                        Colors.lightGreen)
                    : SizedBox(),
                (city.scoreData.scoreInfo[9].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        9,
                        'Considers the quality of the educational system, computing their average results in certified and regulated exams. Also takes in to account the amount of teachers per students, and the position in the global rankings of their universities.',
                        Colors.indigoAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[10].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        10,
                        'Considers the air pollution that you will be exposed when travelling. This doesnt mean that everyday it reaches that pollution level, but in the average routine day that is the air quality you could find. High percentage mean green cities with a small amount of pollution, while low percentages mean big pollution levels, so if its more than 60% try to take preventions if you are planning a long stay.',
                        Colors.brown)
                    : SizedBox(),
                (city.scoreData.scoreInfo[11].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        11,
                        'Represents the effectivity of the local/state governament tries to increment the productivity capacity of their goods and services to satisfy the social human needs.',
                        Colors.lime)
                    : SizedBox(),
                (city.scoreData.scoreInfo[12].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        12,
                        'The relation between the taxes and the corresponding benefits from those taxes. In order to get some feedback of how good or bad are the taxes managed, and also how overloaded are the goods and services that you will consume if you decide to visit it.',
                        Colors.deepPurpleAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[13].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        13,
                        'The availability to get internet connection. Not only from private companies, also how many public places, such as airports, train stations, public transport, offer people free internet access through wifi.',
                        Colors.redAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[14].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        14,
                        'The amount of available activities, and also how attractive for foreigners is to visit it. So it reffers directly to the amount of different activities, such astheater, cinema, opera, tracking, submarinism, among others it will depend on the city that you are looking in to.',
                        Colors.pinkAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[15].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        15,
                        'A indicator that represents the level of tolerance. This takes in to account the amount of crimes relative to discrimination, protests, political affers,... ',
                        Colors.yellowAccent)
                    : SizedBox(),
                (city.scoreData.scoreInfo[16].scoreOutOf10 > 0)
                    ? _graficaCard(
                        city,
                        16,
                        'The percentage of activities that can be done in the outsite in the nature. This will vary if you are looking in a city or in a village.',
                        Colors.lightGreenAccent)
                    : SizedBox(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

Widget _crearAppbar(CityInfo city) {
  return SliverAppBar(
    elevation: 2.0,
    expandedHeight: 200.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          city.cityName,
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        background: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: city.images.length,
          itemBuilder: (BuildContext context, int index) {
            return FadeInImage(
              alignment: Alignment.center,
              image: NetworkImage(city.images[index]),
              placeholder: AssetImage('assets/loading.gif'),
              fadeInDuration: Duration(milliseconds: 150),
              fit: BoxFit.cover,
            );
          },
        )),
  );
}

Widget _posterCity(BuildContext context, CityInfo city) {
  final size = MediaQuery.of(context).size;
  GoSoonDb db = GoSoonDb();

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: <Widget>[
        Hero(
          tag: city.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(city.images[0]),
              height: 150.0,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    city.cityName,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.people),
                  SizedBox(width: 10),
                  Text(city.cityPopulation.toString(),
                      style: Theme.of(context).textTheme.subhead,
                      overflow: TextOverflow.ellipsis)
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    city.countryName,
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.people),
                  SizedBox(width: 10),
                  Text(
                    city.countryPopulation.toString(),
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Text(
                    'Currency: ',
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(width: 10),
                  // Icon(FontAwesomeIcons.moneyBillWaveAlt),
                  SizedBox(width: 10),
                  Text(city.countryCurrency,
                      style: Theme.of(context).textTheme.subhead),
                  SizedBox(width: 40),
                  FutureBuilder(
                      future: db.initDB(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return _saveCity(context, city, db);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        )
      ],
    ),
  );
}

class saveCity extends StatefulWidget {
  final CityInfo city;

  saveCity({@required this.city});

  @override
  _saveCityState createState() => _saveCityState();
}

class _saveCityState extends State<saveCity> {
  @override
  Widget build(BuildContext context) {
    GoSoonDb db = GoSoonDb();
    Color color;

    var cityName = widget.city.cityName;
    var img = widget.city.images[1];

    return GestureDetector(
      onTap: () {
        var city = GoSoon(img: img, name: cityName);
        db.insert(city);
        Navigator.pop(context);
      },
      child: Container(
          width: 35,
          height: 35,
          child: Icon(FontAwesomeIcons.heartbeat, color: Colors.red[300])),
    );
  }
}

_saveCity(BuildContext context, CityInfo city, GoSoonDb db) {
  var cityName = city.cityName;
  var img = city.images[1];
  bool gotIt = false;

  return FutureBuilder(
      future: db.getAllCities(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<GoSoon> myCities = snapshot.data;
          for (var i = 0; i < myCities.length; i++) {
            print(myCities[i].name);
            if (myCities[i].name == cityName) {
              gotIt = true;
            }
          }
          return GestureDetector(
            onTap: () {
              var city = GoSoon(img: img, name: cityName);
              db.insert(city);
              Navigator.pop(context);
            },
            child: Container(
              width: 35,
              height: 35,
              child: gotIt
                  ? Icon(FontAwesomeIcons.solidHeart, color: Colors.red[300])
                  : Icon(FontAwesomeIcons.heart, color: Colors.red[300]),
            ),
          );
        } else {
          return SizedBox();
        }
      });
}

Widget _descripcion(CityInfo city) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: Text(
      city.scoreData.summary,
      textAlign: TextAlign.justify,
    ),
  );
}

Widget _graficaCard(CityInfo city, int i, String description, Color color) {
  double percentValue = ((city.scoreData.scoreInfo[i].scoreOutOf10) * 10) / 100;

  return Container(
    width: double.infinity,
    height: 230,
    child: Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(city.scoreData.scoreInfo[i].name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 3),
              Container(
                width: 100,
                height: 3,
                color: color,
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 75.0,
                      lineWidth: 8.0,
                      percent: percentValue,
                      center: Text(
                          "${((city.scoreData.scoreInfo[i].scoreOutOf10) * 10).toStringAsFixed(2)}%"),
                      progressColor: color,
                    )
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    child: Text(
                      description,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

class CarouselWithIndicator extends StatefulWidget {
  final CityInfo city;

  CarouselWithIndicator({@required this.city});
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final int i = widget.city.images.length;

    final List<String> imgList = [
      '${widget.city.images[0].toString()}',
      '${widget.city.images[1].toString()}',
      '${widget.city.images[2].toString()}',
      '${widget.city.images[3].toString()}',
      '${widget.city.images[4].toString()}',
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              widget.city.cityName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.white.withOpacity(0.65),
      expandedHeight: 220.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 24 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((url) {
                  int index = imgList.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
            ],
          )),
    );
  }
}
