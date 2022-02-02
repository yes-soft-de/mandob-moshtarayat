<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\CustomProductNotFoundEntity;
use App\Manager\CustomProductNotFoundManager;
use App\Request\CustomProductNotFoundCreateRequest;
use App\Response\CustomProductNotFoundResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class CustomProductNotFoundService
{
    private $autoMapping;
    private $customProductNotFoundManager;
    private $params;


    public function __construct(AutoMapping $autoMapping, CustomProductNotFoundManager $customProductNotFoundManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->customProductNotFoundManager = $customProductNotFoundManager;
        $this->params = $params->get('upload_base_url') . '/';

    }

    public function createCustomProductNotFound(CustomProductNotFoundCreateRequest $request)
    {
        $report = $this->customProductNotFoundManager->createCustomProductNotFound($request);

        return $this->autoMapping->map(CustomProductNotFoundEntity::class, CustomProductNotFoundResponse::class, $report);
    }

    public function getCustomProductsNotFound(): array
    {
        $response = [];

        $items = $this->customProductNotFoundManager->getCustomProductsNotFound();

        foreach ($items as $item) {
            $item['productImage'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);

            $response[] =  $this->autoMapping->map("array", CustomProductNotFoundResponse::class, $item);
        }

        return $response;
    }

    public function getCustomProductNotFound($id)
    {
        $item = $this->customProductNotFoundManager->getCustomProductNotFound($id);

        $item['productImage'] = $this->getImageParams($item['productImage'], $this->params.$item['productImage'], $this->params);

        return  $this->autoMapping->map("array", CustomProductNotFoundResponse::class, $item);
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
