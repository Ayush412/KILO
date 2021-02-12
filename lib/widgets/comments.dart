import 'package:flutter/material.dart';
import 'package:kilo/bloc/comments_bloc.dart';

comments(ScrollController controller){
  return StreamBuilder(
    stream: commentsBloc.commentsOut,
    builder: (context, snap) {
      if(snap.data==null)
        return Center(child: Text('No comments yet'),);
      else
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            controller: controller,
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle, color: Colors.orange[400], size: 28,),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                          child: Text(snap.data[index].data()['Name'], style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ), 
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Flexible(
                        child: Text(snap.data[index].data()['Text'], style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300, wordSpacing: 2, height: 1.3))
                      )
                    ),
                  ),
                ],
              );
            },
          ),
        );
    },
  );
}
// Padding(
//                               padding: const EdgeInsets.only(),
//                               child: Flexible(child:Text(snap.data[index].data()['Text'], style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300, wordSpacing: 2, height: 1.3)))
//                             ),