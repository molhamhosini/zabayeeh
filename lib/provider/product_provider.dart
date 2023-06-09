import 'package:flutter/material.dart';
import 'package:zabayeh_aljazeera/data/model/response/base/api_response.dart';
import 'package:zabayeh_aljazeera/data/model/response/category_model.dart';
import 'package:zabayeh_aljazeera/data/model/response/product_model.dart';
import 'package:zabayeh_aljazeera/data/repository/product_repo.dart';
import 'package:zabayeh_aljazeera/data/repository/search_repo.dart';
import 'package:zabayeh_aljazeera/helper/api_checker.dart';
import 'package:zabayeh_aljazeera/helper/product_type.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepo productRepo;
  final SearchRepo searchRepo;

  ProductProvider({@required this.productRepo, this.searchRepo});

  // Latest products
  Product _product;
  List<Product> _popularProductList;
  List<Product> _dailyItemList;
  List<Product> _latestProductList;
  List<Product> _featuredProductList;
  List<Product> _mostViewedProductList;
  List<Product> _recommendProduct;
  List<Product> _trendingProduct;
  bool _isLoading = false;
  int _popularPageSize;
  int _latestPageSize;
  List<String> _offsetList = [];
  List<String> _popularOffsetList = [];
  int _quantity = 1;
  List<int> _variationIndex;
  int _imageSliderIndex;
  int _cartIndex;
  int offset = 1;
  int popularOffset = 1;

  Product get product => _product;
  int get cartIndex => _cartIndex;
  List<Product> get popularProductList => _popularProductList;
  List<Product> get dailyItemList => _dailyItemList;
  List<Product> get featuredProductList => _featuredProductList;
  List<Product> get mostViewedProductList => _mostViewedProductList;
  List<Product> get latestProductList => _latestProductList;
  List<Product> get recommendProduct => _recommendProduct;
  List<Product> get trendingProduct => _trendingProduct;
  bool get isLoading => _isLoading;
  int get popularPageSize => _popularPageSize;
  int get latestPageSize => _latestPageSize;
  int get quantity => _quantity;
  List<int> get variationIndex => _variationIndex;
  int get imageSliderIndex => _imageSliderIndex;



  Future<void> getItemList(BuildContext context, String _offset, bool reload,String languageCode, String productType) async {
    if(reload || _offset == '1') {
      popularOffset = 1 ;
      _popularOffsetList = [];
    }

    if (!_popularOffsetList.contains(_offset)) {
      _popularOffsetList.add(_offset);
      _isLoading = true;
      print('product type is ________> $productType');
      ApiResponse apiResponse = await productRepo.getItemList(_offset,languageCode, productType);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        if (reload || _offset == '1' ) {
          if(productType == ProductType.DAILY_ITEM) {
            _dailyItemList = [];
          }else if(productType == ProductType.FEATURED_ITEM){
            _featuredProductList = [];
          } else if(productType == ProductType.POPULAR_PRODUCT){
            _popularProductList = [];
          }else if(productType == ProductType.MOST_REVIEWED){
            _mostViewedProductList = [];
          }else if(productType == ProductType.TRENDING_PRODUCT){
            _trendingProduct = [];
          }else if(productType == ProductType.RECOMMEND_PRODUCT){
            _recommendProduct = [];
          }
        }

        if(productType == ProductType.DAILY_ITEM) {
          _dailyItemList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        }else if(productType == ProductType.FEATURED_ITEM){
          _featuredProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        }else if(productType == ProductType.POPULAR_PRODUCT){
          _popularProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        }else if(productType == ProductType.MOST_REVIEWED){
          print('product json --> ');
          ProductModel.fromJson(apiResponse.response.data).products.forEach((product) { 
            print('product ---> ${product.name}');
          });
          print('${ProductModel.fromJson(apiResponse.response.data).products}');
          _mostViewedProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        }else if(productType == ProductType.RECOMMEND_PRODUCT){
          _recommendProduct.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        }else if(productType == ProductType.TRENDING_PRODUCT){
          _trendingProduct.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        }

        _popularPageSize = ProductModel.fromJson(apiResponse.response.data).totalSize;
        _isLoading = false;

      } else {
        _isLoading = false;
        ApiChecker.checkApi(apiResponse);
      }
    } else {
      if(isLoading) {
        _isLoading = false;
      }
    }
    notifyListeners();
  }

  Future<void> getLatestProductList(BuildContext context, String _offset, bool reload,String languageCode) async {
    if(reload || _offset == '1') {
      offset = 1 ;
      _offsetList = [];
    }

    if (!_offsetList.contains(_offset)) {
      _offsetList.add(_offset);
      ApiResponse apiResponse = await productRepo.getLatestProductList(_offset,languageCode);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        if (reload || _offset == '1' ) {
          _latestProductList = [];
        }
        _latestProductList.addAll(ProductModel.fromJson(apiResponse.response.data).products);
        _latestPageSize = ProductModel.fromJson(apiResponse.response.data).totalSize;
        _isLoading = false;

      } else {
        _isLoading = false;
        ApiChecker.checkApi(apiResponse);
      }
    } else {
      if(isLoading) {
        _isLoading = false;
      }
    }
    notifyListeners();
  }


  Future<Product> getProductDetails(BuildContext context, String productID, String languageCode, {bool searchQuery = false}) async {
    _product = null;
    ApiResponse apiResponse = await productRepo.getProductDetails(productID, languageCode, searchQuery);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _product = Product.fromJson(apiResponse.response.data);
      initData(_product);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();

    return _product;

  }

  void showBottomLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void setExistData(int cartIndex) {
    _cartIndex = cartIndex;
  }

  void initData(Product product) {
    _variationIndex = [];
    _cartIndex = null;
    _quantity = 1;
    product.choiceOptions.forEach((element) => _variationIndex.add(0));
  }


  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity + 1;
    } else {
      _quantity = _quantity - 1;
    }
    notifyListeners();
  }

  void setCartVariationIndex(int index, int i) {
    _variationIndex[index] = i;
    _quantity = 1;
    notifyListeners();
  }

  int _rating = 0;
  int get rating => _rating;

  void setRating(int rate) {
    _rating = rate;
    notifyListeners();
  }

  String _errorText;

  String get errorText => _errorText;

  void setErrorText(String error) {
    _errorText = error;
    notifyListeners();
  }

  void removeData() {
    _errorText = null;
    _rating = 0;
    notifyListeners();
  }

  void setImageSliderSelectedIndex(int selectedIndex) {
    _imageSliderIndex = selectedIndex;
    notifyListeners();
  }

  // Brand and category products
  List<Product> _categoryProductList = [];
  List<Product> _categoryAllProductList = [];
  bool _hasData;

  double _maxValue = 0;

  double get maxValue => _maxValue;

  List<Product> get categoryProductList => _categoryProductList;

  List<Product> get categoryAllProductList => _categoryAllProductList;

  bool get hasData => _hasData;

  void initCategoryProductList(String id, BuildContext context, String languageCode) async {
    _categoryProductList = [];
    _categoryAllProductList = [];
    _hasData = true;
    ApiResponse apiResponse = await productRepo.getBrandOrCategoryProductList(id, languageCode);
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      _categoryProductList = [];
      _categoryAllProductList = [];
      apiResponse.response.data.forEach((product) => _categoryProductList.add(Product.fromJson(product)));
      apiResponse.response.data.forEach((product) => _categoryAllProductList.add(Product.fromJson(product)));
      _hasData = _categoryProductList.length > 1;
      List<Product> _products = [];
      _products.addAll(_categoryProductList);
      List<double> _prices = [];
      _products.forEach((product) => _prices.add(double.parse(product.price.toString())));
      _prices.sort();
      if(categoryProductList.length!=0)
      _maxValue = _prices[_prices.length - 1];

    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  void sortCategoryProduct(int filterIndex) {
    if(filterIndex == 0) {
      _categoryProductList.sort((product1, product2) => product1.price.compareTo(product2.price));
    }else if(filterIndex == 1) {
      _categoryProductList.sort((product1, product2) => product1.price.compareTo(product2.price));
      Iterable iterable = _categoryProductList.reversed;
      _categoryProductList = iterable.toList();
    }else if(filterIndex == 2) {
      _categoryProductList.sort((product1, product2) => product1.name.toLowerCase().compareTo(product2.name.toLowerCase()));
    }else if(filterIndex == 3) {
      _categoryProductList.sort((product1, product2) => product1.name.toLowerCase().compareTo(product2.name.toLowerCase()));
      Iterable iterable = _categoryProductList.reversed;
      _categoryProductList = iterable.toList();
    }
    notifyListeners();
  }

  searchProduct(String query) {
    if (query.isEmpty) {
      _categoryProductList.clear();
      _categoryProductList = categoryAllProductList;
      notifyListeners();
    } else {
      _categoryProductList = [];
      categoryAllProductList.forEach((product) async {
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          _categoryProductList.add(product);
        }
      });
      _hasData = _categoryProductList.length > 1;
      notifyListeners();
    }
  }

  int _filterIndex = -1;
  double _lowerValue = 0;
  double _upperValue = 0;

  int get filterIndex => _filterIndex;

  double get lowerValue => _lowerValue;

  double get upperValue => _upperValue;

  void setFilterIndex(int index) {
    _filterIndex = index;
    notifyListeners();
  }

  void setLowerAndUpperValue(double lower, double upper) {
    _lowerValue = lower;
    _upperValue = upper;
    notifyListeners();
  }


  void sortSearchList(int selectSortByIndex, List<CategoryModel> categoryList) {
    if (_upperValue > 0 && selectSortByIndex == 0) {
      _categoryProductList.clear();
      _categoryAllProductList.forEach((product) {
        if (((double.parse(product.price.toString())) >= _lowerValue) && ((double.parse(product.price.toString())) <= _upperValue)) {
          _categoryProductList.add(product);
        }
      });
    } else if (_upperValue == 0 && selectSortByIndex == 0) {
      _categoryProductList .clear();
      _categoryProductList = _categoryAllProductList;
    } else if (_upperValue == 0 && selectSortByIndex == 1) {
      _categoryProductList.clear();
      _categoryProductList = _categoryAllProductList;
      _categoryProductList.sort((a, b){
        double aPrice=double.parse(a.price.toString());
        double bPrice=double.parse(b.price.toString());
        return aPrice.compareTo(bPrice);
      });
    } else if (_upperValue == 0 && selectSortByIndex == 2) {
      _categoryProductList.clear();
      _categoryProductList = _categoryAllProductList;
      _categoryProductList.sort((a, b){
        double aPrice=double.parse(a.price.toString());
        double bPrice=double.parse(b.price.toString());
        return aPrice.compareTo(bPrice);
      });
      Iterable iterable = _categoryProductList.reversed;
      _categoryProductList = iterable.toList();
    }
    notifyListeners();
  }

  bool _isClear = true;

  bool get isClear => _isClear;

  void cleanSearchProduct() {
    _isClear = true;
    notifyListeners();
  }

  List<String> _allSortBy = [];

  List<String> get allSortBy => _allSortBy;
  int _selectSortByIndex = 0;

  int get selectSortByIndex => _selectSortByIndex;

  updateSortBy(int index) {
    _selectSortByIndex = index;
    notifyListeners();
  }

  initializeAllSortBy(BuildContext context) {
    if (_allSortBy.length == 0) {
      _allSortBy = [];
      _allSortBy = searchRepo.getAllSortByList();
    }
    _filterIndex = -1;

  }
}
