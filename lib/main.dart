import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/Strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.titleStr,
      theme: new ThemeData.dark(),
      home: new RandomWords(),
    );
  }
}

//自定义有状态的控件
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

//控件状态
class RandomWordsState extends State<RandomWords> {
  final _suggest = <WordPair>[];
  var _saved = new Set<WordPair>();
  final _bigFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    //产生活动内容
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(Strings.flutterStr),
        ),

        //点击跳转新页面
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //产生每一个item
  Widget _buildRow(WordPair pair) {
    final alreadySave = _saved.contains(pair);

    return new ListTile(
      //设置单词
      title: new Text(
        pair.asPascalCase,
        style: _bigFont,
      ),

      //设置收藏图标
      trailing: new Icon(
        alreadySave ? Icons.favorite : Icons.favorite_border,
        color: alreadySave ? Colors.red : null,
      ),

      //设置点击事件
      onTap: () {
        setState(() {
          if (alreadySave) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  //产生ListView列表
  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          if (index >= _suggest.length) {
            _suggest.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggest[index]);
        });
  }

  //路由跳转
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _bigFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text(Strings.saveStr),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}
