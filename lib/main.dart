import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartUp Name Generate',
      home: new RandomWords(),
    );
  }
}

// 自定义控件
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

//State类
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
          child: new Text("Flutter"),
        ),
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
}
