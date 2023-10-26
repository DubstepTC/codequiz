import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  void startSearch() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isSearching
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search...",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              )
            : Text("Your Text Here"),
        GestureDetector(
          onTap: startSearch,
          child: Image.asset(
            "assets/images/search.svg",
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}