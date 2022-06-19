import 'package:flutter/material.dart';
import 'home_page_main.dart';

void main(){
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainHomePage();
  }
}
