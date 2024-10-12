import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart'as badges;
 import 'cart_modle.dart';
import 'cart_provider.dart';
import 'db_helper.dart';

class CartScreen extends StatefulWidget {
   const CartScreen({super.key, required String productName, required double productPrice});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'My Products',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(value.getCounter().toString());
                    },
                    child: const Text('0')),
                child: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body:  Column(
        children: [
          FutureBuilder(future: cart.getData(),
              builder: (context,AsyncSnapshot<List<Cart>>snapshot){

            if(snapshot.hasData){
if(snapshot.data!.isEmpty){
  return    const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
       Icon(Icons.hourglass_empty_rounded),
       Center(child: 
       
       Text('Cart is Empty',style: TextStyle(color: Colors.green,fontSize: 33),)),
    ],
  );
}else{
  return Expanded(
    child: ListView.builder(
      itemCount:snapshot.data!.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Image(
                      height: 100,
                      width: 100,
                      image:
                      NetworkImage(snapshot.data![index].image.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(snapshot.data![index].productName.toString()),
                              SizedBox(width: 30,),
                              InkWell(
                                  onTap: (){
                                    dbHelper!.delete(snapshot.data![index].id!);
                                    cart.removeCounter();
                                    cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                  },
                                  child: Icon(Icons.delete,color: Colors.green,))
                            ],
                          ),
                          Text(snapshot.data![index].unitTag.toString() +
                              "" +
                              r"$" +
                              snapshot.data![index].productPrice.toString()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {

                              },
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: (){
                                              int quantity=snapshot.data![index].quantity!;
                                              int price=snapshot.data![index].intialPrice!;
                                              quantity--;
                                              int?newPrice=price*quantity;
                                              if(quantity>0){
                                                dbHelper!.update(
                                                    Cart(id: snapshot.data![index].id!,
                                                        productName: snapshot.data![index].productName!,
                                                        productPrice:newPrice ,
                                                        intialPrice: snapshot.data![index].intialPrice!,
                                                        unitTag: snapshot.data![index].unitTag.toString(),
                                                        image: snapshot.data![index].image.toString(),
                                                        productId: snapshot.data![index].id.toString(),
                                                        quantity: quantity)).then((value){
                                                  newPrice=0;
                                                  quantity=0;
                                                  cart.removeTotalPrice(double.parse(snapshot.data![index].intialPrice.toString(),));

                                                }).onError((error,StackTrace){
                                                  print(error.toString());

                                                });
                                              }else{}

                                            },
                                            child: const Icon(Icons.remove,color: Colors.white,)),
                                        Text(snapshot.data![index].quantity.toString(),style: const TextStyle(color: Colors.white),),
                                        InkWell(
                                            onTap: (){
                                              int quantity=snapshot.data![index].quantity!;
                                              int price=snapshot.data![index].intialPrice!;
                                              quantity++;
                                              int?newPrice=price*quantity;
                                              dbHelper!.update(
                                                  Cart(id: snapshot.data![index].id!,
                                                      productName: snapshot.data![index].productName!,
                                                      productPrice:newPrice ,
                                                      intialPrice: snapshot.data![index].intialPrice!,
                                                      unitTag: snapshot.data![index].unitTag.toString(),
                                                      image: snapshot.data![index].image.toString(),
                                                      productId: snapshot.data![index].id.toString(),
                                                      quantity: quantity)).then((value){
                                                newPrice=0;
                                                quantity=0;
                                                cart.addTotalPrice(double.parse(snapshot.data![index].intialPrice.toString(),));

                                              }).onError((error,StackTrace){
                                                print(error.toString());

                                              });
                                            }
                                            ,
                                            child: const Icon(Icons.add,color: Colors.white,))
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

}



            }
            return    Text('');
          }),
          Consumer<CartProvider>(builder: (context,value,child){
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2)=='0.00'? true:false,
              child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0,bottom: 44),
                    child: Center(child: ReuseableWidget(title: 'sub Total', value: r'$'+value.getTotalPrice().toString(),)),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }

}
class ReuseableWidget extends StatelessWidget {
final  String title,value;
  const ReuseableWidget({super.key,required this .title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(value,)
        ,Text(title),
      ],
    );
  }
}

