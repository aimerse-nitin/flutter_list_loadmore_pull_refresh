import 'package:flutter/material.dart';

class MyApiListScreen extends StatefulWidget {
  @override
  _MyApiListScreenState createState() => _MyApiListScreenState();
}

class _MyApiListScreenState extends State<MyApiListScreen> {
  List<String> items = [];
  final int _limit = 20;//Never changes, final
  int _offset = 0;

  Future<void> _handleResponse() async {
    // Simulate a time-consuming task (e.g., fetching data from a server)
    _offset=0;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Replace this with your actual data fetching logic
      items = List.generate(_limit, (index) => 'Item $index');
    });
  }

  Future<void> _loadMorePrepareInput() async {
    // Simulate a time-consuming task (e.g., fetching more data from a server)
    await Future.delayed(Duration(seconds: 2));
    _offset++;//INCREASE OFFSET TO +1
    setState(() {
      // Replace this with your actual data fetching logic
      items.addAll(List.generate(10, (index) => 'More Item ${items.length + index}'));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _handleResponse();//First time API load
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull to Refresh & Load More'),
      ),
      body: RefreshIndicator(
        onRefresh: _handleResponse,
        child: ListView.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              _loadMorePrepareInput();
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
