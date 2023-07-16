import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: ChangeColorCard(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.asset('assets/img.png',fit: BoxFit.fill,),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(50),
              )
            ),
            SizedBox(width: 10,),
            Column(
              children: [
                Text('پوریا عباسی',style: TextStyle(fontSize: 23,color: Colors.grey[900],fontWeight: FontWeight.bold),)
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<int>idx=[1,2,3];

Color? ChangeColorCard(){
  int i=idx.length;
  Color? color;

    if(i==3){
      idx.remove(idx.last);
     return color=Colors.blueAccent;
    }else if(i==2){
      idx.remove(idx.last);
     return color=Colors.cyan;
    }else{
      idx.add(2);
      idx.add(3);
     return color=Colors.cyanAccent;
    }
}