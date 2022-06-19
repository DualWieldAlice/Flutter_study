// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.1,
            0.9,
          ],
          colors: [
            Color(0xFFd9d180),
            Color(0xffffffff),
          ],
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 0.25 * (width - 28),
              child: FlatButton(
                onPressed: (){//ここでページ遷移する
                },
                child: _IconTextItem(
                  deviceWidth: width,
                  icon: Icons.home,
                  title: 'Home',
                  // color: const Color(0xFFd9d180),
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            SizedBox(
              width: 0.25 * (width - 28),
              child: FlatButton(
                onPressed: (){},
                child: _IconTextItem(
                  deviceWidth: width,
                  icon: const IconData(0xec50, fontFamily: 'MaterialIcons'),
                  title: 'TryOut',
                  color: const Color(0xFFaaaaaa),
                ),
              ),
            ),
            SizedBox(
              width: 0.25 * (width - 28),
              child: FlatButton(
                onPressed: (){},
                child: _IconTextItem(
                  deviceWidth: width,
                  icon: const IconData(0xf400, fontFamily: 'MaterialIcons'),
                  title: 'Theory',
                  color: const Color(0xFFaaaaaa),
                ),
              ),
            ),
            SizedBox(
              width: 0.25 * (width - 28),
              child: FlatButton(
                onPressed: (){},
                child: _IconTextItem(
                  deviceWidth: width,
                  icon: const IconData(0xe03a, fontFamily: 'MaterialIcons'),
                  title: 'Record',
                  color: const Color(0xFFaaaaaa),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconTextItem extends StatelessWidget {
  const _IconTextItem({
    Key? key,
    required this.deviceWidth,
    required this.icon,
    required this.title,
    required this.color,
  }) : super(key: key);

  final double deviceWidth;
  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.25 * (deviceWidth - 28),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: color,
              ),

            ),
          ),
        ],
      ),
    );
  }
}