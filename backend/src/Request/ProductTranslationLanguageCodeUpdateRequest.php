<?php

namespace App\Request;

class ProductTranslationLanguageCodeUpdateRequest
{
    private $oldLanguageCode;

    private $newLanguageCode;

    /**
     * @return mixed
     */
    public function getOldLanguage()
    {
        return $this->oldLanguageCode;
    }

    /**
     * @return mixed
     */
    public function getNewLanguageCode()
    {
        return $this->newLanguageCode;
    }
}
