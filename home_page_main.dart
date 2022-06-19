// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'footer.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: _homePage(),
      ),
    );
  }
}

class _homePage extends StatefulWidget {
  const _homePage({Key? key}) : super(key: key);

  @override
  State<_homePage> createState() => _homePageState();
}

class _homePageState extends State<_homePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  var typing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                typing = !typing;
              });
            },
            icon: Icon(typing ? Icons.done : Icons.search)),
        title: typing
            ? Container(
                color: const Color(0xFFffffff),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: '検索',
                  ),
                ),
              )
            : const Text('化学を勉強しよう'),
        backgroundColor: const Color(0xFF7fd9d2), //青緑
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              /// いまのところ EdgeInsets.all(ここ) を変数で指定できないので，何か工夫する
              /// 一番上のパネルとヘッダーの間のスペース
              padding: const EdgeInsets.only(top: 63),
              child: GridView.count(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                children: List<Widget>.generate(
                  8, //fieldListの長さで指定できたらいいな
                  _generator,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xFFffffff),
      bottomNavigationBar: const Footer(),
    );
  }

  //グリッドの生成
  Widget _generator(int index) {
    List<String> fieldList = [
      "結晶",
      "反応熱",
      "平衡",
      "酸化還元",
      "溶液",
      "無機",
      "有機",
      "応用"
    ];

    return GestureDetector(
      child: GridTile(
        child: Padding(
          /// いまのところ EdgeInsets.all(ここ) を変数で指定できないので，何か工夫する
          /// パネルごとの間隔
          padding: const EdgeInsets.all(28),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF000000), width: 2.0),
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFffffff),
            ),
            child: Center(
              child: Text(
                fieldList[index],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),

      /// 2回タップで関数を動かせるみたい(onPressedがないので，そこは考えます)
      onDoubleTap: () {
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('You double tapped on ${index + 1}'),
            duration: const Duration(seconds: 3),
          ),
        );
      },
    );
  }
}
