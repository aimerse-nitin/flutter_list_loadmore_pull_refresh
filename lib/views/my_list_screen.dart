import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyListScreen(),
//     );
//   }
// }

class MyListScreen extends StatefulWidget {
  @override
  _MyListScreenState createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  List<String> items = List.generate(20, (index) => 'Item $index');

  Future<void> _refresh() async {
    // Simulate a time-consuming task (e.g., fetching data from a server)
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Replace this with your actual data fetching logic
      items = List.generate(20, (index) => 'Refreshed Item $index');
    });
  }

  Future<void> _loadMore() async {
    // Simulate a time-consuming task (e.g., fetching more data from a server)
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Replace this with your actual data fetching logic
      items.addAll(List.generate(10, (index) => 'Loaded Item ${items.length + index}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull to Refresh & Load More'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              _loadMore();
              return _buildLoadMoreIndicator();
            } else {
              return ListTile(
                title: Text(items[index]),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
