import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import '../providers/product.dart';

class EditProductsScrenn extends StatefulWidget {
  static const ROUTE_NAME = '/edit-products';

  @override
  _EditProductsScrennState createState() => _EditProductsScrennState();
}

enum FormFields { Title, Description, ImageUrl, Price }

class _EditProductsScrennState extends State<EditProductsScrenn> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  var _existProduct =
      Product(id: null, title: '', description: '', imageUrl: '', price: 0);

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        final product =
            Provider.of<Products>(context, listen: false).findById(productId);
        _existProduct = product;
        _initValue = {
          'title': product.title,
          'description': product.description,
          'price': product.price.toString(),
          // 'imageUrl': product.imageUrl,
          'imageUrl': ''
        };
        _imageUrlController.text = product.imageUrl;
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      final imageUrlValid = imageValidator(_imageUrlController.text);
      print('IMAGEURL : $imageUrlValid');
      if (imageUrlValid != null) {
        return;
      } else {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final formValid = _form.currentState.validate();
    if (!formValid) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_existProduct.id == null) {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_existProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong. 😌'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_existProduct.id, _existProduct);
      Navigator.of(context).pop();
    }
  }

  void _onSaveField<T>(T val, FormFields field) {
    switch (field) {
      case FormFields.Description:
        _existProduct = Product(
            id: _existProduct.id,
            title: _existProduct.title,
            description: val as String,
            price: _existProduct.price,
            isFavorite: _existProduct.isFavorite,
            imageUrl: _existProduct.imageUrl);
        break;
      case FormFields.Title:
        _existProduct = Product(
            id: _existProduct.id,
            title: val as String,
            description: _existProduct.description,
            isFavorite: _existProduct.isFavorite,
            price: _existProduct.price,
            imageUrl: _existProduct.imageUrl);
        break;
      case FormFields.Price:
        _existProduct = Product(
            id: _existProduct.id,
            title: _existProduct.title,
            description: _existProduct.description,
            isFavorite: _existProduct.isFavorite,
            price: double.parse((val as String)),
            imageUrl: _existProduct.imageUrl);
        break;
      case FormFields.ImageUrl:
        _existProduct = Product(
            id: _existProduct.id,
            title: _existProduct.title,
            description: _existProduct.description,
            isFavorite: _existProduct.isFavorite,
            price: _existProduct.price,
            imageUrl: val as String);
        break;
      default:
    }
  }

  String imageValidator(String val) {
    print('value inputted: $val');
    if (val.isEmpty) return 'Please input image URL';
    if (!val.startsWith('http') && !val.startsWith('https'))
      return 'Please input valid image URL location';
    if (!val.endsWith('.png') &&
        !val.endsWith('.jpg') &&
        !val.endsWith('.jpeg')) return 'Please input valid image format URL';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                        initialValue: _initValue['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                        onSaved: (val) => _onSaveField(val, FormFields.Title),
                        validator: (val) =>
                            val.isEmpty ? 'Please input valid title' : null),
                    TextFormField(
                        initialValue: _initValue['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode),
                        onSaved: (val) => _onSaveField(val, FormFields.Price),
                        validator: (val) => double.tryParse(val) == null
                            ? 'Please input valid price number'
                            : double.parse(val) <= 0
                                ? 'Please input price number greater than zero'
                                : null),
                    TextFormField(
                        initialValue: _initValue['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (val) =>
                            _onSaveField(val, FormFields.Description),
                        validator: (val) => val.length <= 6
                            ? 'Description length must be more than 6'
                            : null),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageUrlController.text.isEmpty
                              ? Text(
                                  'Enter Image Url',
                                )
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                            // NOTE: if we set init value together with controller it could be throw error
                            child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          controller: _imageUrlController,
                          onSaved: (val) =>
                              _onSaveField(val, FormFields.ImageUrl),
                          textInputAction: TextInputAction.done,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) => _saveForm,
                          validator: (val) => imageValidator(val),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
