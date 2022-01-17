<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ProductEntity;
use App\Manager\ProductManager;
use App\Manager\UserManager;
use App\Request\ProductCreateRequest;
use App\Request\ProductFilterByNameRequest;
use App\Request\ProductTranslationCreateRequest;
use App\Request\ProductTranslationUpdateRequest;
use App\Request\ProductUpdateByStoreOwnerRequest;
use App\Request\ProductUpdateRequest;
use App\Request\ProductWithTranslationCreateRequest;
use App\Request\ProductWithTranslationUpdateRequest;
use App\Response\CostDetailsResponse;
use App\Response\ProductCreateResponse;
use App\Response\ProductsByProductCategoryIdAndStoreOwnerProfileIdResponse;
use App\Response\ProductsByStoreOwnerProfileIdResponse;
use App\Response\ProductsByStoreProductCategoryIdResponse;
use App\Response\ProductsResponse;
use App\Response\ProductFullInfoResponse;
use App\Response\ProductsByProductCategoryIdResponse;
use App\Response\ProductsTopWantedResponse;
use App\Response\ProductUpdateResponse;
use App\Response\StoreProductCategoriesResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use App\Service\StoreOwnerProfileService;

class ProductService
{
    private $autoMapping;
    private $productManager;
    private $params;
    private $userManager;
    private $ratingService;
    private $storeOwnerProfileService;
    private $productTranslationService;
    private $primaryLanguage;

    public function __construct(AutoMapping $autoMapping, ProductManager $productManager, ParameterBagInterface $params, userManager $userManager,  RatingService $ratingService,StoreOwnerProfileService $storeOwnerProfileService,
     ProductTranslationService $productTranslationService)
    {
        $this->autoMapping = $autoMapping;
        $this->productManager = $productManager;
        $this->userManager = $userManager;
        $this->params = $params->get('upload_base_url') . '/';
        $this->primaryLanguage = $params->get('primary_language');
        $this->ratingService = $ratingService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->productTranslationService = $productTranslationService;
    }

    public function createProductByAdmin(ProductCreateRequest $request)
    {
        $item = $this->productManager->createProductByAdmin($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }

    public function getProductsByProductCategoryId($userLocale, $storeProductCategoryID)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationsByProductCategoryId($storeProductCategoryID);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsByProductCategoryId($storeProductCategoryID);
        }

        foreach ($products as $item) {

            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getActiveProductsByProductCategoryId($userLocale, $storeProductCategoryID)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getActiveProductsTranslationsByProductCategoryId($storeProductCategoryID);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getActiveProductsByProductCategoryId($storeProductCategoryID);
        }

        foreach ($products as $item) {
            $item['costDetails'] = $this->costDetails($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission'], $item['discount']);

            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileId($userLocale, $storeProductCategoryID, $storeOwnerProfileId)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId);
        }

        foreach ($products as $item) {
            $item['costDetails'] = $this->costDetails($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission'], $item['discount']);
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileIdForStore($userLocale, $storeProductCategoryID, $storeOwnerProfileId)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationByCategoryIdAndStoreOwnerProfileIdForStore($storeProductCategoryID, $storeOwnerProfileId);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsByCategoryIdAndStoreOwnerProfileIdForStore($storeProductCategoryID, $storeOwnerProfileId);
        }

        foreach ($products as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileIdForAdmin($userLocale, $storeProductCategoryID, $storeOwnerProfileId)
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationByCategoryIdAndStoreOwnerProfileIdForAdmin($storeProductCategoryID, $storeOwnerProfileId);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsByCategoryIdAndStoreOwnerProfileIdForAdmin($storeProductCategoryID, $storeOwnerProfileId);
        }

        foreach ($products as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdAndStoreOwnerProfileIdResponse::class, $item);
        }

        return $response;
    }

    public function getProducts()
    {
        $items = $this->productManager->getProducts();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', ProductsResponse::class, $item);
        }

        return $response;
    }

    public function getProductByIdWithFullInfo($userLocale, $id)
    {
        if ($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productTranslation = $this->productManager->getProductTranslationByProductIdWithFullInfo($id);

            if($productTranslation['language'] == $userLocale)
            {
                $item = $productTranslation;
            }
            elseif($productTranslation['language'] == null)
            {
                $productTranslation['productName'] = $productTranslation['primaryProductName'];

                $item = $productTranslation;
            }
            elseif($productTranslation['language'] != null && $productTranslation['language'] != $userLocale)
            {

                $productTranslation['productName'] = $productTranslation['primaryProductName'];

                $item = $productTranslation;
            }
        }
        else
        {
            $item = $this->productManager->getProductByIdWithFullInfo($id);
        }

        if($item['productImage'])
        {
            $item['productImage'] = $this->params . $item['productImage'];
        }

        if($item['image'])
        {
            $item['image'] = $this->params . $item['image'];
        }

        $item['costDetails'] = $this->costDetails($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission'], $item['discount']);

        $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');

        $item['soldCount'] = $this->getProductsSoldCount($item['id']);
        $item['productPriceWithOutCommission'] = $item['productPrice'];
        $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);

        return $this->autoMapping->map('array', ProductFullInfoResponse::class, $item);
    }

    public function willProductCommissionBeCharged($isCommission, $productPrice, $commission, $storeCommission)
    {
        if($isCommission == true){
            return ($productPrice * $commission  / 100) + $productPrice;
        }
        else {
            return ($productPrice * $storeCommission / 100) + $productPrice;
        }
    }

    public function costDetails($isCommission, $productPrice, $commission, $storeCommission, $discount)
    {
        $item = [];
        $item['price'] = $productPrice;
        $item['discount'] = $discount;
        $item['priceWithDiscount'] = $item['price'] - ($productPrice * $discount / 100);;

        if($isCommission == true){
            $item['priceWithCommission'] = ($productPrice * $commission  / 100) + $productPrice;
            $item['priceWithCommissionAfterDiscount'] = ( $item['priceWithDiscount'] * $commission  / 100) + $item['priceWithDiscount'];
            $item['commission'] = $commission;
        }

        else {
            $item['priceWithCommission'] = ($productPrice * $storeCommission / 100) + $productPrice;
            $item['priceWithCommissionAfterDiscount'] = ($item['priceWithDiscount'] * $storeCommission / 100) + $item['priceWithDiscount'];
            $item['commission'] = $storeCommission;
        }

        $item['priceFinal'] = $item['priceWithCommissionAfterDiscount'];

        return $this->autoMapping->map('array', CostDetailsResponse::class, $item);
    }

    public function getProductsTopWanted($userLocale): ?array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTopWantedTranslations();

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsTopWanted();
        }

        foreach ($products as $product) {

            $product['productPriceWithOutCommission'] = $product['productPrice'];
            $product['productPrice'] = $this->willProductCommissionBeCharged($product['isCommission'], $product['productPrice'], $product['commission'], $product['storeCommission']);

            $img = isset($product['image']);

            if ($img) {
                $product['productImage'] = $this->getImageParams($product['productImage'], $this->params.$product['productImage'], $this->params);

                $topOwner['imageURL'] = $product['image'];
            }

            $response[] = $this->autoMapping->map('array', ProductsTopWantedResponse::class, $product);
        }

        return $response;
    }

    public function productsTopWantedOfSpecificStoreOwner($userLocale, $storeOwnerProfileId): ?array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->productsTopWantedOfSpecificStoreOwnerTranslation($storeOwnerProfileId);

            $Products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $Products = $this->productManager->productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId);
        }

        foreach ($Products as $product) {

            $product['costDetails'] = $this->costDetails($product['isCommission'], $product['productPrice'], $product['commission'], $product['storeCommission'], $product['discount']);

            $product['productPrice'] = $this->willProductCommissionBeCharged($product['isCommission'], $product['productPrice'], $product['commission'], $product['storeCommission']);

            $img = isset($product['image']);
            if ($img) {
                $product['productImage'] = $this->getImageParams($product['productImage'], $this->params.$product['productImage'], $this->params);

                $topOwner['imageURL'] = $product['image'];
            }

            $response[] = $this->autoMapping->map('array', ProductsTopWantedResponse::class, $product);
        }

        return $response;
    }

    public function getStoreProductsByProfileId($userLocale, $storeOwnerProfileId): ?array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getStoreProductsTranslationByProfileId($storeOwnerProfileId);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getStoreProductsByProfileId($storeOwnerProfileId);
        }

        foreach ($products as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getStoreProducts($userID, ProductFilterByNameRequest $request): ?array
    {
        $storeOwnerProfileId = $this->userManager->getStoreProfileId($userID);

        if($request->getName())
        {
            if($request->getLanguage() != null && $request->getLanguage() != $this->primaryLanguage)
            {
                $productsTranslation = $this->productManager->getProductsTranslationByTranslatedNameAndStoreOwnerProfileId($request->getName(), $storeOwnerProfileId);

                $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $request->getLanguage());
            }
            else
            {
                $products = $this->getProductsByNameAndStoreOwnerProfileId($request->getName(), $storeOwnerProfileId);
            }

            return $this->returnProduct($products);
        }
        else
        {
            if($request->getLanguage() != null && $request->getLanguage() != $this->primaryLanguage)
            {
                $productsTranslation = $this->productManager->getProductsTranslationByStoreOwnerProfileId($storeOwnerProfileId);

                $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $request->getLanguage());
            }
            else
            {
                $products = $this->productManager->getStoreProducts($storeOwnerProfileId);
            }

            return $this->returnProduct($products);
        }
    }

    public function returnProduct($items){
        $response = [];

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
//            $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByStoreProductCategoryID($userLocale, $storeProductCategoryID): ?array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationByStoreProductCategoryID($storeProductCategoryID);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsByStoreProductCategoryID($storeProductCategoryID);
        }

        foreach ($products as $item) {

            $item['costDetails'] = $this->costDetails($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission'], $item['discount']);

            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['productPriceWithOutCommission'] = $item['productPrice'];
            $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByStoreProductCategoryIDForStore($userLocale, $storeProductCategoryID, $userID): ?array
    {
        $response = [];

        $storeOwnerProfileId = $this->userManager->getStoreProfileId($userID);

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationsByStoreProductCategoryIDForStore($storeProductCategoryID, $storeOwnerProfileId);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsByStoreProductCategoryIDForStore($storeProductCategoryID, $storeOwnerProfileId);
        }

        foreach ($products as $item) {
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
//            $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function getProductsSoldCount($id)
    {
        return $this->productManager->getProductsSoldCount($id);

    }

    public function getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $storeProductCategoryID): ?array
    {
        $response = [];

        $items = $this->productManager->getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $storeProductCategoryID);

        foreach ($items as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function updateProductByAdmin($request)
    {
        $item = $this->productManager->updateProductByAdmin($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }

    public function updateProductCommissionByAdmin($request)
    {
        $item = $this->productManager->updateProductCommissionByAdmin($request);

        return $this->autoMapping->map(ProductEntity::class, ProductUpdateResponse::class, $item);
    }

    public function countProducts()
    {
        return $this->productManager->countProducts();
    }

    public function getProductsByName($name)
    {
        return $this->productManager->getProductsByName($name);
    }

    public function getProductsByNameAndStoreOwnerProfileId($name, $storeOwnerProfileId)
    {
        return $this->productManager->getProductsByNameAndStoreOwnerProfileId($name, $storeOwnerProfileId);
    }

    public function createProductByStore(ProductWithTranslationCreateRequest $request, $userID)
    {
        $storeOwnerProfileId = $this->userManager->getStoreProfileId($userID);

        // insert the data in the primary language
        $productCreateRequest = $this->autoMapping->map('array', ProductCreateRequest::class, $request->getData());

        $productCreateRequest->setStoreOwnerProfileID($storeOwnerProfileId['id']);

        $product = $this->productManager->createProductByStore($productCreateRequest);

        // then, insert the translation, if exists
        if($request->getTranslate())
        {
            $this->createProductTranslation($request->getTranslate(), $product->getId());
        }

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $product);
    }

    public function createProductTranslation($translationArrayRequest, $productID)
    {
        if($translationArrayRequest)
        {
            foreach($translationArrayRequest as $translationRequest)
            {
                $productTranslationRequest = $this->autoMapping->map('array', ProductTranslationCreateRequest::class, $translationRequest);

                $productTranslationRequest->setProductID($productID);

                $this->productTranslationService->createProductTranslation($productTranslationRequest);
            }
        }
        else
        {
            // No translations were provided!
            // Skip inserting translations
        }
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function updateProductByStore(ProductWithTranslationUpdateRequest $request, $userID)
    {
        $storeProfileID = $this->storeOwnerProfileService->getStoreOwnerProfile($userID);

        $doesStoreOwnProduct = $this->productManager->doesStoreOwnProduct($storeProfileID->id, $request->getData()['id']);
        if ($doesStoreOwnProduct) {

            // First, update the content in the primary language
            $productUpdateRequest = $this->autoMapping->map('array', ProductUpdateByStoreOwnerRequest::class, $request->getData());

            //Second, update the translation data
            if ($request->getTranslate()) {
                $this->updateProductTranslation($request->getTranslate());

                $productEntity = $this->productManager->getProductEntityByID($productUpdateRequest->getId());

                if ($productEntity) {
                    $productUpdateRequest->setProductName($productEntity->getProductName());
                }
            }

            $product = $this->productManager->updateProductByStore($productUpdateRequest);

            return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $product);
        }
    }

    public function updateProductTranslation($translationArrayRequest)
    {
        if($translationArrayRequest)
        {
            foreach($translationArrayRequest as $translationRequest)
            {
                $productTranslationUpdateRequest = $this->autoMapping->map('array', ProductTranslationUpdateRequest::class, $translationRequest);

                $this->productTranslationService->updateProductTranslationByProductIdAndLanguage($productTranslationUpdateRequest);
            }
        }
    }

    public function getProductsByStoreCategoryID($userLocale, $storeCategoryID): ?array
    {
        $response = [];

        $storeProductCategoriesIdsLevel1 = $this->productManager->getStoreProductCategoryIdLevel1($storeCategoryID);

        foreach($storeProductCategoriesIdsLevel1 as $item )
        {
//            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);

            $item['storeProductCategoriesLevel2'] = $this->getStoreProductCategoryLevel2($userLocale, $item['id']);

            foreach($item['storeProductCategoriesLevel2'] as $value)
            {
                if($value->products)
                {
                   foreach($value->products as $product)
                   {
                       $response[] = $this->autoMapping->map(ProductsByProductCategoryIdResponse::class, ProductsByStoreProductCategoryIdResponse::class, $product);
                   }
                }
            }
        }

        return $response;
    }
    //TODO changing the function name to get products from subCategory one or two.
//get products from subCategory one or two.
    public function getStoreProductCategoryLevel2($userLocale, $storeProductCategoryIdLevel1): array
    {
        $response = [];

        $storeProductCategoriesLevelTwo = $this->productManager->getStoreProductCategoryLevel2($storeProductCategoryIdLevel1);

        foreach ($storeProductCategoriesLevelTwo as $item)
        {
            $item['productCategoryImage'] = $this->getImageParams($item['productCategoryImage'], $this->params . $item['productCategoryImage'], $this->params);

            $item['products'] = $this->getProductsByStoreProductCategoryID($userLocale, $item['id']);

            $response[] = $this->autoMapping->map('array', StoreProductCategoriesResponse::class, $item);
        }

        return $response;
    }

    public function getProductsByStoreProductCategoryLevelTwo($userLocale, $storeProductCategoryIdLevelTwo, $storeOwnerProfileID): array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationByStoreProductCategoryID($storeProductCategoryIdLevelTwo);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsByStoreProductCategoryIDAndStoreOwnerProfileID($storeProductCategoryIdLevelTwo, $storeOwnerProfileID);
        }

        foreach ($products as $item) {
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }

        return $response;
    }

    public function updateProductStatusByStore($request)
    {
        $item = $this->productManager->updateProductStatusByStore($request);

        return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $item);
    }

    public function getSimilarProductsByStoreProductCategoryIdOfLevelTwo($userLocale, $storeProductCategoryID): ?array
    {
        $response = [];

        $storeProductCategoryIdLevel1 = $this->productManager->getProductCategoryLevelOneByProductCategoryLevelTwoID($storeProductCategoryID);

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            if ($storeProductCategoryIdLevel1) {

                $productsTranslations = $this->productManager->getProductsTranslationByStoreProductCategoryIDLevelOne($storeProductCategoryIdLevel1['id']);

                $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslations, $userLocale);
            } else {

                $products = [];
            }
        }
        else
        {
            if ($storeProductCategoryIdLevel1) {

                $products = $this->productManager->getProductsByStoreProductCategoryIDLevelOne($storeProductCategoryIdLevel1['id']);
            } else {

                $products = [];
            }
        }

        foreach($products as $item)
        {
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);
            $item['productPriceWithOutCommission'] = $item['productPrice'];

            $response[] = $this->autoMapping->map("array", ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function deleteProductById($request)
    {
        $result = $this->productManager->deleteProductById($request);

        if($result == 'productNotFound')
        {
            return $result;
        }
        else
        {
            return $this->autoMapping->map(ProductEntity::class, ProductCreateResponse::class, $result);
        }
    }

    public function getLast30Products($userLocale): ?array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getLast30ProductsTranslation();

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getLast30Products();
        }

        foreach ($products as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
//            $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);

            $response[] = $this->autoMapping->map('array', ProductsByProductCategoryIdResponse::class, $item);
        }
        return $response;
    }

    public function getProductsStoreOwnerProfileId($userLocale, $storeOwnerProfileId): array
    {
        $response = [];

        if($userLocale != null && $userLocale != $this->primaryLanguage)
        {
            $productsTranslation = $this->productManager->getProductsTranslationsByStoreOwnerProfileId($storeOwnerProfileId);

            $products = $this->replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale);
        }
        else
        {
            $products = $this->productManager->getProductsStoreOwnerProfileId($storeOwnerProfileId);
        }

        foreach ($products as $item) {
            $item['image'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);
            $item['rate'] = $this->ratingService->getAvgRating($item['id'], 'product');
            $item['soldCount'] = $this->getProductsSoldCount($item['id']);
            $item['store'] = $this->storeOwnerProfileService->getStoreNameById($item['storeOwnerProfileID']);
            $item['productPrice'] = $this->willProductCommissionBeCharged($item['isCommission'], $item['productPrice'], $item['commission'], $item['storeCommission']);

            $response[] = $this->autoMapping->map('array', ProductsByStoreOwnerProfileIdResponse::class, $item);
        }

        return $response;
    }

    public function replaceProductTranslatedNameByPrimaryOne($productsTranslation, $userLocale)
    {
        $products = [];

        if($productsTranslation)
        {
            foreach($productsTranslation as $product)
            {
                if($product['language'] == $userLocale)
                {
                    $products[] = $product;
                }
                elseif($product['language'] == null)
                {
                    $product['productName'] = $product['primaryProductName'];

                    $products[] = $product;
                }
                elseif($product['language'] != null && $product['language'] != $userLocale)
                {
                    // here means that there is another content in different language rather that the required one or the primary one
                    if (!$this->checkIfItemExistsInSpecificLanguage($productsTranslation, $product['id'], $userLocale))
                    {
                        $product['productName'] = $product['primaryProductName'];

                        $products[] = $product;
                    }
                }
            }
        }

        return $products;
    }

    public function checkIfItemExistsInSpecificLanguage($array, $itemID, $language)
    {
        foreach ($array as $item)
        {
            if ($item['id'] == $itemID && $item['language'] == $language)
            {
                return true;
            }
        }

        return false;
    }

    public function getStoreOwnersProfilesIDsByStoreProductCategoriesIDs($storeProductsCategoriesIDsArray)
    {
        return $this->productManager->getStoreOwnersProfilesIDsByStoreProductCategoriesIDs($storeProductsCategoriesIDsArray);
    }
}
