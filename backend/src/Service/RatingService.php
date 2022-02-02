<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\RatingEntity;
use App\Manager\RatingManager;
use App\Request\RatingCreateRequest;
use App\Response\RatingResponse;


class RatingService
{
    private $autoMapping;
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->ratingManager = $ratingManager;
    }

    public function createRatingByCaptainOrClient(RatingCreateRequest $request)
    {
        $rating = $this->ratingManager->createRatingByCaptainOrClient($request);

        return $this->autoMapping->map(RatingEntity::class, RatingResponse::class, $rating);
    }

    public function createCaptainRatingByClient(RatingCreateRequest $request)
    {
        $rating = $this->ratingManager->createCaptainRatingByClient($request);

        return $this->autoMapping->map(RatingEntity::class, RatingResponse::class, $rating);
    }

    public function createStoreRatingByClient(RatingCreateRequest $request)
    {
        $rating = $this->ratingManager->createStoreRatingByClient($request);

        return $this->autoMapping->map(RatingEntity::class, RatingResponse::class, $rating);
    }

    public function createProductRatingByClient(RatingCreateRequest $request)
    {
        $rating = $this->ratingManager->createProductRatingByClient($request);

        return $this->autoMapping->map(RatingEntity::class, RatingResponse::class, $rating);
    }

    public function getAvgRating($itemID, $itemType)
    {
        return $this->ratingManager->getAvgRating($itemID, $itemType);
     }

    public function getAvgOrder($orderNumber)
    {
        return $this->ratingManager->getAvgOrder($orderNumber);
     }
}
