import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController _textController = TextEditingController();
  double _fontSize = 40;

  // Navigate to the second screen
  void _navigateToSecondScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(
          text: _textController.text,
          fontSize: _fontSize,
        ),
      ),
    ).then((result) {
      // Show a dialog based on the result from second screen
      if (result == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Column(
              children: [
                // Додаємо іконку
                Image.network(
                  'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
                  width: 40, // Ширина іконки
                  height: 40, // Висота іконки
                ),
                SizedBox(width: 10), // Відстань між іконкою та текстом
                Text("Don't know what to say"), // Текст діалогу
              ],
            ),
          )
        );
      } else {
        String dialogMessage = result ? "Cool!" : "Let’s try something else";
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Column(
              children: [
                // Додаємо іконку
                Image.network(
                  'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
                  width: 40, // Ширина іконки
                  height: 40, // Висота іконки
                ),
                SizedBox(width: 10), // Відстань між іконкою та текстом
                Text(dialogMessage), // Текст діалогу
              ],
            ),
            actions: <Widget>[
              // Кнопка OK
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Закриває діалогове вікно
                },
                child: Text('OK'),
              ),
            ],
          ),
        );


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Text Previewer',
          style: TextStyle(color: Colors.white))),
          backgroundColor: Colors.deepPurple),
      body: Padding(

        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText:'text',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(),
                hintText: 'Enter text',
              ),
            ),
            Text('Enter some text'),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Font size'),
                SizedBox(width: 16,),
                Text(
                  _fontSize.round().toString(), // Відображення поточного значення шрифту
                  style: TextStyle(fontSize: 16), // Опціонально налаштуйте стиль
                ),
                Expanded(child: Slider(
                  value: _fontSize,
                  min: 20,
                  max: 100,
                  divisions: 30,
                  label: _fontSize.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _fontSize = value;
                    });
                  },
                )),

              ],
            ),

            Center(
              child: ElevatedButton(
                onPressed: _navigateToSecondScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,  // Use backgroundColor instead of primary
                ),
                child: Text('Preview',
                    style: TextStyle(color: Colors.white)),

              ),
            )
            ,
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String text;
  final double fontSize;

  SecondScreen({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Preview',
            style: TextStyle(color: Colors.white))),
            backgroundColor: Colors.deepPurple),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(height: 28,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text('ok',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
