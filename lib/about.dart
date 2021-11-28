import 'package:cipher/user.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("ABOUT", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Image.asset(
            'assets/logo.png',
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.20
                : MediaQuery.of(context).size.width * 0.25,
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.20
                : MediaQuery.of(context).size.width * 0.25,
          ),
          SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.10
                : MediaQuery.of(context).size.width * 0.15,
            child: Center(
              child: Text(
                'KRIPTOGRAFI KLASIK',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.03
                        : MediaQuery.of(context).size.width * 0.05),
              ),
            ),
          ),
          GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: user.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                String name = user.keys.elementAt(index);
                String nim = nimList[index];

                return Container(
                  margin: EdgeInsets.all(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          user.values.elementAt(index),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        top: 95,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              nim,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.07
                : MediaQuery.of(context).size.width * 0.10,
            child: Center(
              child: Text(
                'TIM PENYUSUN',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.03
                        : MediaQuery.of(context).size.width * 0.05),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Text(
              'Aplikasi ini dibuat dan dikembangkan oleh kami nama-nama di atas. Banyak rintangan yang kami hadapi saat membuat aplikasi ini, namun kami berhasil mewujudkannya 😊',
              style: TextStyle(
                  fontSize:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.0225
                          : MediaQuery.of(context).size.width * 0.03),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
