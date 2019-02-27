import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),                             // ... to here.
      home: new RandomWords(),
    );
//    final wordPair = new WordPair.random(); // Add this line.
//    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(    // Change "const" to "new".
//          //child: const Text('Hello World'),   // Replace this text...
//
//          child: new RandomWords(),  // With this text.
//        ),
//      ),
//    );
  }
}


class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => new RandomWordsState();
    // TODO: implement createState


}


class  RandomWordsState extends State<RandomWords>
{
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return new Scaffold(         // Add 6 lines from here...
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );                           // ... to here.
        },
      ),
    );
  }

  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();   // Add this line.
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  @override                                  // Add from this line ...
  Widget build(BuildContext context) {
//    final WordPair wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Scaffold (                   // Add from here...
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],                      // ... to here.

      ),
      body: _buildSuggestions(),
    );


 }




  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),

        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }


  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);  // Add this line.
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),

      trailing: new Icon(   // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),                    // ... to here.

      onTap: () {      // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },               // ... to here.
    );
  }

}


