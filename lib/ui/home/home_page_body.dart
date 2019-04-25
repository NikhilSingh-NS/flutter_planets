import 'package:flutter/material.dart';
import 'package:planets/entity/planet.dart';
import 'package:planets/ui/components/text_style.dart';
import 'package:planets/ui/detail/detail_page.dart';

class HomePageBody extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return new Expanded(
        /*child: new ListView.builder(itemBuilder: (context, index) => new PlanetRow(planets[index]),
          itemCount: planets.length,
          padding: new EdgeInsets.symmetric(vertical: 16.0),
        )*/
        child: new Container(
          color: new Color(0xFF736AB7),
          child: new CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              new SliverPadding(padding: const EdgeInsets.symmetric(vertical: 16.0),
                sliver: new SliverFixedExtentList(
                    delegate: new SliverChildBuilderDelegate(
                        (context, index) => new PlanetRow(planets[index]),
                        childCount: planets.length
                    ),
                    itemExtent: 172.0),
              )
            ]
          ),
        ),
    );
  }

}

class PlanetRow extends StatelessWidget{

  final Planet planet;
  final bool horizontal;

  PlanetRow(this.planet, {this.horizontal = true});

  PlanetRow.vertical(this.planet): horizontal = false;

  @override
  Widget build(BuildContext context) {

    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(tag: "planet-${planet.id}",
            child:
        new Image(image: new AssetImage(planet.image),
            height: 92.0,
            width: 92.0,
        ),
      )
    );

    Widget _planetValue({String value, String image}){
      return new Row(
        children: <Widget>[
          new Image.asset(image, height: 12.0),
          new Container(width: 8.0),
          new Text(value,
            style: regularTextStyle,
          )
        ],
      );
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(planet.name,
            style: headerTextStyle,
          ),
          new Container(height: 10.0),
          new Text(planet.location,
            style: subHeaderTextStyle,
          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: new Color(0xff00c6ff),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _planetValue(value: planet.distance,
                      image: "assets/img/ic_distance.png")
              ),
              new Container (
                  width: horizontal ? 8.0 : 32.0,
              ),
              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _planetValue(value: planet.gravity,
                      image: "assets/img/ic_gravity.png")
              )
            ],
          )
        ],
      ),
    );

    final planetCard = new Container(
      height: horizontal ? 132.0 : 158.0,
      margin: horizontal ? new EdgeInsets.only(left: 46.0) : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
          color: new Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0)
            )
          ]
      ),
      child: planetCardContent,
    );


    return new GestureDetector(
      //onTap: ()=> Navigator.pushNamed(context, "/detail"),
      onTap: horizontal ? () => Navigator.of(context).push(new PageRouteBuilder(
          pageBuilder: (_,__,___) => new DetailPage(planet),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          new FadeTransition(opacity: animation, child: child)
        )): null,
      child: new Container(
        margin: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0
        ),
        child: new Stack(
            children: <Widget>[
            planetCard,
            planetThumbnail
          ],
        )
      )
    );

  }

}

