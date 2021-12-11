<?php

namespace App\Request;

class StoreCategoryWithTranslationUpdateRequest
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