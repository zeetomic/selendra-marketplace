import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/core/services/image_picker.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product_body.dart';

class EditProduct extends StatefulWidget {

  final OwnerProduct productOwner;

  EditProduct({this.productOwner});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  ProductModel _product = ProductModel();

  void onChanged(String value){
    _product.formKey.currentState.validate();
  }

  void onSubmit(String value){

  }

  String validateField(String value, {String label}){
    if (_product.productNameNode.hasFocus){
      print("Product $label");
    } else if (_product.priceNode.hasFocus){
      print("Price $label");
    } else if (_product.locationNode.hasFocus){
      print("Location $label");
    } else if (_product.descriptionNode.hasFocus){
      print("Description $label");
    }
    return "Error";
  }

  void onChangeImage() async {
    List fromPicker = await MyImagePicker.imagePicker(maxImages: 10);
    if (fromPicker != null){
      widget.productOwner.listImages = await MyImagePicker.getAssettoFile(fromPicker);

      print(widget.productOwner.listImages);
      setState((){
      });
    }
  }
  
  void onChangeDropDown(String label, String value){
    print(value);
    setState((){
      if (label == 'currency'){
        _product.currency = value;
      } 
      else if (label == 'scale'){
        _product.scale = value;
      }
      else if (label == 'category'){
        _product.categoryDropDown = value;
        _product.category.text = value;
      }
    });
  }

  validateAllInput(){
    if(
      _product.category.text.isNotEmpty &&
      _product.scale != null &&
      _product.currency != null &&
      _product.location != null &&
      _product.images != null &&
      _product.price.text.isEmpty &&
      _product.productName.text.isNotEmpty
    ){
      enableBtn();
    } else if (_product.enable == true){
      enableBtn();
    }
  }

  void enableBtn(){
    setState((){ _product.enable = !_product.enable;});
  }

  void removeImageByIndex(int index){
    print("My index $index");
    setState(()=> widget.productOwner.listImages.removeAt(index));
  }

  Future<void> submitProduct(OwnerProduct ownerProduct) async {
    Components.dialogLoading(context: context);
    try{
      await PostRequest().updateProduct(ownerProduct).then((value) async {
        // Close Loading
        Navigator.pop(context);
        if (value.statusCode == 200){
          await Components.dialog(context, MyText(text: json.decode(value.body)['message']), Text("Message"));

          // // Refetch Product Owner
          await Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();

          // Close Edit Screen
          Navigator.pop(context);
        }
      });
    } catch (e){
      print("Hello error");
      await Components.dialog(context, Text(e.toString()), Text("Message"));
      print(e);
    }
  }

  @override
  void initState(){

    _product = ProductModel.fromOwner(widget.productOwner);
    widget.productOwner.listImages.insert(0, widget.productOwner.thumbnail);
    // widget.productOwner.productModel.currency = 'Currency';
    // widget.productOwner.productModel.scale = 'Scale';
    // widget.productOwner.productModel.categoryDropDown = 'Category';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    _product.category.text = Provider.of<CategoriesModel>(context).findCategoriesById(widget.productOwner.categoryId);
    _product.categoryDropDown = _product.category.text;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          brightness: Brightness.light,
          titleSpacing: 0,
          // leadingWidth: 25,
          title: MyText(
            text: "Add Product",
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
          // bottom: ReuseTabBar.getItem(appBarItemOne, appBarItemTwo, appBarItemThree, controller, context),
          //  backgroundColor: Colors.white,
          leading: IconButton(
            padding: EdgeInsets.only(left: 25),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: AppServices.hexaCodeToColor(AppColors.primary),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BodyScaffold(
          // height: MediaQuery.of(context).size.height,
          child: EditProductBody(
            productOwner: widget.productOwner,
            productModel: _product,
            onChanged: onChanged,
            validate: validateField,
            onChangeImage: onChangeImage,
            onChangeDropDown: onChangeDropDown,
            removeImageByIndex: removeImageByIndex,
            onSubmit: onSubmit,
            submitProduct: submitProduct,
          )
        ),
      ),
    );
  }
}