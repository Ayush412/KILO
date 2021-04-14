import 'package:flutter/material.dart';
import 'package:kilo/widgets/underline_text.dart';


class PurchaseItem extends StatefulWidget {
  @override
  _PurchaseItemState createState() => _PurchaseItemState();
}

class _PurchaseItemState extends State<PurchaseItem> {

  List<int> _selectedItems = List<int>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: underlineText('Store', 24, Colors.black), 
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return 
            Container(
              color: (_selectedItems.contains(index)) ? Colors.blue.withOpacity(0.5) : Colors.transparent,
              child: ListTile(
                onTap: (){
                  if(_selectedItems.contains(index)){
                    setState(() {
                      _selectedItems.removeWhere((val) => val == index);
                    });
                  }
                },
                onLongPress: (){
                  if(! _selectedItems.contains(index)){
                    setState(() {
                      _selectedItems.add(index);
                    });
                  }
                },
                title: Text('$index'),
              ),
            );
          },
        ),
      ),
    );
  }
}