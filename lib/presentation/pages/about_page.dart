// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo_listecc/common/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/about-me';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'About Me',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const CircleAvatar(
                maxRadius: 100,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Lengkap',
                    style: kTextTheme.subtitle2,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    'Muhammad Athallah',
                    style: kTextTheme.bodyText1,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Text(
                    'Nama Panggilan',
                    style: kTextTheme.subtitle2,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    'Athal',
                    style: kTextTheme.bodyText1,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Text(
                    'Hobi',
                    style: kTextTheme.subtitle2,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    'Overthinking',
                    style: kTextTheme.bodyText1,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
              const Divider(),
              Text(
                'Media Sosial',
                style: kTextTheme.subtitle2,
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Icon(FontAwesomeIcons.facebook),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                    onPressed: () {
                      launch('https://www.facebook.com/mhdathallah.id/');
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(FontAwesomeIcons.instagram),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                    onPressed: () {
                      launch('https://www.instagram.com/mhd.athallah/');
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(FontAwesomeIcons.twitter),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                    onPressed: () {
                      launch('https://www.twitter.com/mhd_athallah/');
                    },
                  ),
                  ElevatedButton(
                    child: const Icon(FontAwesomeIcons.envelope),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                    onPressed: () {
                      launch(Uri.encodeFull(
                          'mailto:muhammad.athallah01@ui.ac.id'));
                    },
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Text(
                'Source Code',
                style: kTextTheme.subtitle2,
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
              ),
              ElevatedButton(
                child: const Icon(FontAwesomeIcons.github),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                onPressed: () {
                  launch('https://github.com/determinedguy/todo-listecc/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
