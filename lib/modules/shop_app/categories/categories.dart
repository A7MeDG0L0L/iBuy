import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/categories_model.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/shop_states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCategoryList(
              ShopCubit.get(context).categoriesModel.data.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCategoryList(Datum model) => InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            Image(
              image: NetworkImage(model.image),
              height: 100,
              width: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Text(model.name),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
              color: Colors.grey,
            ),
          ],
        ),
      );
}
