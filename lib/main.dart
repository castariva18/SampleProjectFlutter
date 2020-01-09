import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {

   return MaterialApp(
     title: 'MyApp',
     home: RandomWords(),
   );
  }
}

class RandomWordsState extends State<RandomWords>{
  @override
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My New List"),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
        itemBuilder: (BuildContext _context, int i){
          if(i.isOdd){
            return Divider();
          }
          final index = i ~/ 2;

          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);// new row
        }
    );
  }

  Widget _buildRow(WordPair pair){
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase
      ),
      trailing: Icon(
        alreadySaved? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}