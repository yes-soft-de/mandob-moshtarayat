<?php

namespace App\Request;

class ProductWithTranslationUpdateRequest
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