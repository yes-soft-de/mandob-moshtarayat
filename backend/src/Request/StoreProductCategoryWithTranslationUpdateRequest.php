<?php

namespace App\Request;

class StoreProductCategoryWithTranslationUpdateRequest
{
    private $data;

    private $translate;

    public function getData()
    {
        return $this->data;
    }

    public function getTranslate()
    {
        return $this->translate;
    }

}