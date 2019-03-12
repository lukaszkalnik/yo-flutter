import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yo/person.dart';
import 'package:yo/session_model.dart';

Future<void> main() async {
  final SessionModel sessionModel = SessionModel();
  runApp(ScopedModel<SessionModel>(model: sessionModel, child: YoApp()));
}

class YoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yo!',
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Color(0xFFF67280),
        ),
        home: Scaffold(body: ScopedModelDescendant<SessionModel>(
            builder: (BuildContext context, Widget child, SessionModel model) {
          if (!model.initialized) {
            return Container(
              color: Colors.green,
              child: SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (model.isUserLoggedIn) {
            return FriendsListPage();
          } else {
            return LoginPage();
          }
        })));
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6C5B7B),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Yo!",
              style: Theme.of(context).textTheme.display4,
            ),
          ),
          RaisedButton(
            child: Text("Google login"),
            onPressed: () {
              print("login");
              final SessionModel model = ScopedModel.of<SessionModel>(context);
              model.googleLogin();
            },
          ),
        ],
      ),
    );
  }
}

class FriendsListPage extends StatefulWidget {
  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  final List<Person> _friends = [
    Person("ffff", "Frederik Schweiger",
        "https://pbs.twimg.com/profile_images/1074391975820972033/SP7txc1D_400x400.jpg"),
    Person("pppp", "Pascal Welsch",
        "https://pbs.twimg.com/profile_images/941273826557677568/wCBwklPP_400x400.jpg"),
    Person("gggg", "Georg Bednorz",
        "https://pbs.twimg.com/profile_images/1091439933716381701/PIfcpdHq_400x400.png"),
    Person("ssss", "Seth Ladd",
        "https://pbs.twimg.com/profile_images/986316447293952000/oZWVUWDs_400x400.jpg"),
    Person("kkkk", "Kate Lovett",
        "https://pbs.twimg.com/profile_images/1048927764156432384/JxEqQ9dX_400x400.jpg"),
    Person("tttt", "Tim Sneath",
        "https://pbs.twimg.com/profile_images/653618067084218368/XlQA-oRl_400x400.jpg"),
    Person("hhhh", "Filip Hráček",
        "https://pbs.twimg.com/profile_images/796079953079111680/ymD9DY5g_400x400.jpg"),
    Person("aaaa", "Andrew Brogdon",
        "https://pbs.twimg.com/profile_images/651444930884186112/9vlhNFlu_400x400.png"),
    Person("nnnn", "Nitya Narasimhan",
        "https://pbs.twimg.com/profile_images/988808912504733697/z03gHVFL_400x400.jpg"),
  ];

  List<Color> _colors = [
    Color(0xFFF8B195),
    Color(0xFFF67280),
    Color(0xFFC06C84),
    Color(0xFF6C5B7B),
    Color(0xFF355C7D),
    Color(0xFF34495D),
  ];

  Widget _createListItem(Person person, Color color) {
    return Material(
      color: color,
      child: InkWell(
        onTap: () => print('Tapped ${person.name}'),
        child: Container(
          height: 128,
          alignment: Alignment.centerLeft,
          child: ListTile(
            leading: ClipRRect(
              child: Image.network(
                person.photoUrl,
                height: 56,
                width: 56,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            title: Text(
              person.name.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.display1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                    fontSize: 28,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          _createListItem(_friends[index], _colors[index % 6]),
      itemCount: _friends.length,
    );
  }
}
