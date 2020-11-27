import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';

class Body extends StatefulWidget {
  final TabController _controller;
  Body(this._controller);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return _buildTapBarView();
  }

  Widget _buildTapBarView() {
    var _lang = AppLocalizeService.of(context);
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: <Widget>[
          Container(
            child: productsProvider.orItems.isNotEmpty
                ? ListView.builder(
                    itemCount: productsProvider.orItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            RouteAnimation(
                              enterPage: OrderDetail(
                                productOrder: productsProvider.orItems[index],
                              ),
                            ), //productsProvider.orItems[index]))
                          );
                        },
                        child: Card(
                          elevation: 0,
                          shape: kDefaultShape,
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(kDefaultRadius),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[300],
                                          spreadRadius: 5.0,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    child: Image.network(
                                      productsProvider.orItems[index].thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: ListTile(
                                        title: Text(
                                          productsProvider.orItems[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        isThreeLine: true,
                                        subtitle: Text(
                                          'Qty: ${productsProvider.orItems[index].qauantity}',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 20,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: ListTile(
                                        subtitle: Text(
                                          'Price: ${productsProvider.orItems[index].price}៛ ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kDefaultColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: SvgPicture.asset(
                      'images/undraw_loving_it.svg',
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    // child: Image.network(
                    //   'https://i.pinimg.com/originals/81/c4/fc/81c4fc9a4c06cf57abf23606689f7426.jpg',
                    //   width: 300,
                    //   height: 300,
                    // ),
                  ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _lang.translate('complete'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _lang.translate('complete'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
<<<<<<< HEAD
=======
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => SellerConfirm(productOrder: productsProvider.orItems[index]))
                    // );
                  },
>>>>>>> dev
                ),
              ],
            ),
          ),

          // ListView.builder(
          //   itemCount: productsProvider.orItems.length,
          //   itemBuilder: (context, index) {
          //     return Container(
          //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(kDefaultRadius),
          //       ),
          //       child: ListTile(
          //         title:
          //             Text('${productsProvider.orItems[index].total}៛'),
          //         subtitle: Text(
          //           productsProvider.orItems[index].shippingAddress,
          //           maxLines: 1,
          //         ),
          //         trailing: Text('${productsProvider.orItems[index].qauantity}'),
          //         leading: CircleAvatar(
          //           backgroundColor: Colors.white,
          //           backgroundImage: NetworkImage(productsProvider.oItems[index].thumbnail),
          //         ),
          //         onTap: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(builder: (context) => SellerConfirm(productOrder: OrderProduct()))//productsProvider.orItems[index]))
          //           );
          //         },
          //       ),
          //     );
          //   }
          // ),
        ],
      ),
    );
  }
}
