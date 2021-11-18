<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\ProductEntity;
use App\Repository\ProductEntityRepository;
use App\Request\ProductCancelByStoreOwnerRequest;
use App\Request\ProductCreateRequest;
use App\Request\ProductUpdateByStoreOwnerRequest;
use App\Request\ProductUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreProductCategoryManager;


class ProductManager
{
    private $autoMapping;
    private $entityManager;
    private $productEntityRepository;
    private $storeProductCategoryManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ProductEntityRepository $productEntityRepository, StoreProductCategoryManager $storeProductCategoryManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->productEntityRepository = $productEntityRepository;
        $this->storeProductCategoryManager = $storeProductCategoryManager;
    }

    public function createProductByAdmin(ProductCreateRequest $request)
    {
        $entity = $this->autoMapping->map(ProductCreateRequest::class, ProductEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function getProductsByProductCategoryId($storeProductCategoryID)
    {
        return $this->productEntityRepository->getProductsByProductCategoryId($storeProductCategoryID);
    }

    public function getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId)
    {
        return $this->productEntityRepository->getProductsByCategoryIdAndStoreOwnerProfileId($storeProductCategoryID, $storeOwnerProfileId);
    }

    public function getProducts()
    {
        return $this->productEntityRepository->getProducts();
    }

    public function getProductByIdWithFullInfo($id)
    {
        return $this->productEntityRepository->getProductByIdWithFullInfo($id);
    }

    public function getProductsTopWanted()
    {
        return $this->productEntityRepository->getProductsTopWanted();
    }

    public function productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId)
    {
        return $this->productEntityRepository->productsTopWantedOfSpecificStoreOwner($storeOwnerProfileId);
    }

    public function getStoreProductsByProfileId($storeOwnerProfileId)
    {
        return $this->productEntityRepository->getStoreProductsByProfileId($storeOwnerProfileId);
    }

    public function getStoreProducts($storeOwnerProfileId)
    {
        return $this->productEntityRepository->getStoreProducts($storeOwnerProfileId);
    }

    public function getProductsByStoreProductCategoryID($storeProductCategoryID)
    {
        return $this->productEntityRepository->getProductsByStoreProductCategoryID($storeProductCategoryID);
    }

    public function getProductsSoldCount($id)
    {
        return $this->productEntityRepository->getProductsSoldCount($id);
    }

    public function getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $storeProductCategoryID)
    {
        return $this->productEntityRepository->getProductsByStoreProfileIDAndStoreProductCategoryID($storeOwnerProfileId, $storeProductCategoryID);
    }

    public function updateProductByAdmin(ProductUpdateRequest $request)
    {
        $entity = $this->productEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(ProductUpdateRequest::class, ProductEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function countProducts()
    {
        return $this->productEntityRepository->countProducts();
    }

    public function getProductsByName($name)
    {
        return $this->productEntityRepository->getProductsByName($name);
    }

    public function createProductByStore(ProductCreateRequest $request)
    {
        $request->setStatus('active');
        $entity = $this->autoMapping->map(ProductCreateRequest::class, ProductEntity::class, $request);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $entity;
    }

    public function updateProductByStore(ProductUpdateByStoreOwnerRequest $request)
    {
        $entity = $this->productEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(ProductUpdateByStoreOwnerRequest::class, ProductEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function getStoreProductCategoryLevel2($storeProductCategoryId)
    {
        return $this->storeProductCategoryManager->getStoreProductsCategoryLevelTwoByStoreProductCategoryID($storeProductCategoryId);
    }

    public function getStoreProductCategoryIdLevel1($storeCategoryID)
    {
        return $this->storeProductCategoryManager->getSubCategoriesByStoreCategoryID($storeCategoryID);
    }

    public function getStoreProductCategoryIdOfLevel1($storeCategoryID, $StoreProductCategoryId)
    {
        return $this->productEntityRepository->getStoreProductCategoryIdOfLevel1($storeCategoryID, $StoreProductCategoryId);
    }

    public function getStoreProductCategoryIdLevel1ByIdOfLevelTwo($storeProductCategoryID)
    {
        return $this->productEntityRepository->getStoreProductCategoryIdLevel1ByIdOfLevelTwo($storeProductCategoryID);
    }

    public function getProductsByStoreProductCategoryIDLevelOne($storeProductCategoryIdLevel1)
    {
        return $this->productEntityRepository->getProductsByStoreProductCategoryIDLevelOne($storeProductCategoryIdLevel1);
    }

    public function updateProductStatusByStore(ProductCancelByStoreOwnerRequest $request)
    {
        $entity = $this->productEntityRepository->find($request->getId());

        if (!$entity) {
            return null;
        }
        $entity = $this->autoMapping->mapToObject(ProductCancelByStoreOwnerRequest::class, ProductEntity::class, $request, $entity);

        $this->entityManager->flush();

        return $entity;
    }
}
