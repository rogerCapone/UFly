import 'package:flights/src/models/city_model.dart';
import 'package:flights/src/services/cities_provider.dart';
import 'package:flights/src/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitiesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final citiesProvider = new Citiesprovider();
    final citiesList = Provider.of<HomeService>(context);

    return Container(
      width: double.infinity,
      height: size.height * 0.66,
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.017),
          CapceleraCities(),
          Container(
            width: double.infinity,
            height: size.height * 0.50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: citiesList.cities.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: citiesProvider.buscarCity(citiesList.cities[index]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final city = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(child: CardCity(city: city)),
                      );
                    } else {
                      if (index == 0) {
                        return Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CapceleraCities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 380,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 10), blurRadius: 30),
          ]),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 10), blurRadius: 30),
            ]),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // border: InputBorder.none,

                  hintText: 'Search City',
                  suffixIcon: Icon(Icons.search)),
              onSubmitted: (value) {
                final queryCity =
                    Provider.of<HomeService>(context, listen: false);
                queryCity.queryCity = value;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardCity extends StatelessWidget {
  final CityInfo city;

  CardCity({@required this.city});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    city.uniqueId = '${city.cityName}-tarjeta';

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'detallecity', arguments: city);
          },
          child: Container(
              width: size.width * 0.7,
              height: size.height * 0.40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(city.images[0]),
                    fit: BoxFit.cover,
                  ))),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(city.cityName != null ? city.cityName : '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          backgroundColor:
                              Colors.transparent.withOpacity(0.6))),
                  Text(city.countryName != null ? city.countryName : '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          backgroundColor:
                              Colors.transparent.withOpacity(0.6))),
                ],
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.yellowAccent),
                      Icon(Icons.star, color: Colors.yellowAccent),
                      Icon(Icons.star, color: Colors.yellowAccent),
                      Icon(
                        Icons.star_half,
                        color: Colors.yellowAccent,
                      )
                    ],
                  )

                  //  Text('Barcelona', style: TextStyle(color: Colors.white, fontSize: 25, backgroundColor: Colors.transparent.withOpacity(0.6))),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
