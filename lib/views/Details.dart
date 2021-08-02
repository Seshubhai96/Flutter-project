import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detailview extends StatefulWidget {
  String productname;
  String productimage;
  List size;
  Detailview({this.productname, this.productimage, this.size});
  _Detailview createState() => _Detailview();
}

class _Detailview extends State<Detailview> {
  String selected = "";
  bool selectcolor = false;
  @override
  Widget build(BuildContext context) {
    int i = 1;
    List<Widget> sizelist =
        widget.size.map((e) => getsize(e, i++, () {})).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productname,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.black),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: NetworkImage(widget.productimage),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 50,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: sizelist,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getsize(e, i, callback) {
    return InkWell(
      onTap: () {
        setState(() {
          selectcolor = !selectcolor;
          print(selectcolor);
          selected = e;
          print(selected);
        });
      },
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircleAvatar(
            backgroundColor: selectcolor ? Colors.green : Colors.red,
            child: Text(e)),
      ),
    );
  }
}
