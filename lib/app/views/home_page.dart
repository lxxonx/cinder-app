import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mocozi/app/controller/group_controller.dart';

class HomePage extends StatelessWidget {
  final GroupController groupController = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'ShopX',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.view_list_rounded), onPressed: () {}),
                IconButton(icon: Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              print(groupController.groupList.value);
              if (groupController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                // return StaggeredGridView.countBuilder(
                //   crossAxisCount: 2,
                //   itemCount: groupController.productList.length,
                //   crossAxisSpacing: 16,
                //   mainAxisSpacing: 16,
                //   itemBuilder: (context, index) {
                //     return ProductTile(groupController.productList[index]);
                //   },
                //   staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                // );
                return ListView(
                  children: groupController.groupList.map((group) {
                    return Text(group.bio);
                  }).toList(),
                );
            }),
          )
        ],
      ),
    );
  }
}
