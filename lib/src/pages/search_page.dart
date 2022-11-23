import 'package:flights/src/widgets/search_user_delegate.dart';
import 'package:flutter/material.dart';



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
     return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: SearchUser());
            },
            child: Icon(Icons.search),
            
          ),
          SizedBox(width: 20)
        ],
      ),
    );
    
      
  }
}






 