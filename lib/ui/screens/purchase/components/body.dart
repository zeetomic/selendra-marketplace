import 'package:albazaar_app/ui/screens/purchase/components/all_order.dart';
import 'package:albazaar_app/ui/screens/purchase/components/complete_order.dart';
import 'package:albazaar_app/ui/screens/purchase/components/pending_order.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:albazaar_app/all_export.dart';

class Body extends StatefulWidget {

  final TabController _controller;

  Body(this._controller);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: [
          
          AllOrder(refresh: _refresh,),

          PendingOrder(refresh: _refresh,),

          CompleteOrder(refresh: _refresh,)

        ],
      ),
    );
    //_buildTapBarView();
  }
}
