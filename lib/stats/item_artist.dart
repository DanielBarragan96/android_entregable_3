import 'package:entregable_2/models/artist.dart';
import 'package:flutter/material.dart';

class ItemArtist extends StatelessWidget {
  final Artist artist;
  ItemArtist({Key key,@required this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Cambiar image.network por Extended Image con place holder en caso de error o mientras descarga la imagen
    return Container(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Card(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Placeholder(
                  color: Colors.purple,
                  fallbackHeight: 32,
                  fallbackWidth: 32,
                ),
              ), 
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${artist.artistName}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),                                                         
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
