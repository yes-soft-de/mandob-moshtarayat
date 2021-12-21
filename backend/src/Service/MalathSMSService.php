<?php

namespace App\Service;

use App\Constant\MalathURLConstant;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class MalathSMSService
{
    // Text Encode that will send ( Your Page or PHP File Encode ) -> ( WINDOWS-1256 || UTF-8 );
    private $textEncode = "UTF-8";

    // UserName & Password
    private $userName = "";
    private $password = "";

    // Number of Mobile Numbers That Will Send Every Request .
    private $numSendPerReq = 120;

    public function __construct()
    {

    }

    public function setTextEncode($textEncode)
    {
        $this->textEncode = $textEncode;
    }

    public function setUserName($userName)
    {
        $this->userName = $userName;
    }

    public function setPassword($password)
    {
        $this->password = $password;
    }

    public function sendSMS($mobiles, $sender, $message){

        $messageLength = $this->stringLength($message);
        $messageCount = $this->count_MSG($message);

        // 1010 -> SMS Text Grater that 6 part .
        if ($messageCount>6)
        {
            return 1010;
        }

        if ($this->textEncode == 'UTF-8')
        {
            $message = iconv('UTF-8', 'WINDOWS-1256', $message);
        }

        if ($this->isItUnicode($message))
        {
            $message = $this->toUnicode($message);
            $uc = 'U';
        }
        else
        {
            $uc = 'E';
        }

        $message = urlencode($message);

        $result = -1;
        $_EX_Num = explode(',', $mobiles);
        $EX_Num_Count = count($_EX_Num);
        $_Qesmh = ceil($EX_Num_Count/$this->numSendPerReq);

        $counter = 0;

        $COUNT_OK = $COUNT_FAIL = 0;
        $SEND_OK = $SEND_FAIL = 0;
        $MOB_OK = $MOB_FAIL = '';

        for ($i=1; $i<=$_Qesmh; $i++)
        {
            $slice = array_slice($_EX_Num, $counter, $this->numSendPerReq);

            $Numr = '';

            foreach ($slice as $_Numr)
            {
                if ($this->isMobile($_Numr) && !in_array($_Numr,explode(',',$Numr)))
                {
                    $Numr .= $_Numr.',';
                }
            }

            $Numr = substr($Numr,0,-1);

            if (substr($Numr,0,-1)==',')
            {
                $Numr = substr($Numr,0,-1);
            }

            $_Count_Num = count(explode(',',$Numr));

            $URL = MalathURLConstant::$URL_GATEWAY_SEND."?username=".$this->userName."&password=".$this->password."&mobile=".$Numr."&sender=".$sender."&message=".$message."&unicode=".$uc;

            $_url = MalathURLConstant::$URL_GATEWAY.$URL;
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $_url);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_HEADER, false);
            //dd($curl);
            // execute and return string (this should be an empty string '')
            $result = curl_exec($curl);
            curl_close($curl);

            //$Result = $this->DT_URLGetData(self::$URLGateway,$URL);
            $result = (integer)str_replace(" ", "", $result);

            // -1 -> Something Wrong !!
            // 0 -> Your Message has Sent successfully.
            // 101 -> Parameter are missing.
            // 104 -> Either user name or password are missing or your Account is on hold.
            // 105 -> Credit are not available.
            // 106 -> Wrong Unicode.
            // 107 -> Blocked Sender Name.
            // 108 -> Missing Sender name.
            // 1010 -> SMS Text Grater that 6 part .
            // ELSE -> Unknown Error !.

            if ($result == 0)
            {
                $COUNT_OK += $_Count_Num;
                $SEND_OK = 'OK';
                $MOB_OK .= $Numr.',';
            }
            else
            {
                $COUNT_FAIL += $_Count_Num;
                $SEND_FAIL = 'FAIL';
                $MOB_FAIL .= $Numr.',';
            }

            $counter += $this->numSendPerReq;
        }


        $SUB_CREDIT = $messageCount * $COUNT_OK;

        $sendReply = array(
            'RESULT'	=>$result,
            'SEND_OK'	=>$SEND_OK,
            'SEND_FAIL'	=>$SEND_FAIL,
            'COUNT_OK'	=>$COUNT_OK,
            'COUNT_FAIL'=>$COUNT_FAIL,
            'MOB_OK'	=>substr($MOB_OK,0,-1),
            'MOB_FAIL'	=>substr($MOB_FAIL,0,-1),
            'MSG_Length'=>$messageLength,
            'MSG_Count'	=>$messageCount,
            'SUB_CREDIT'=>$SUB_CREDIT
        );

        return $sendReply;
    }

    public function stringLength($text)
    {
        if ($this->textEncode == 'UTF-8')
        {
            $text = iconv('UTF-8', 'WINDOWS-1256', $text);
        }

        return strlen($text);
    }

    public function count_MSG($text){

        $StrLen = StrLen($text);
        $MSG_Num = 0;

        if ($this->isItUnicode($text))
        {
            if ($StrLen>70)
            {
                while($StrLen>0)
                {
                    $StrLen -= 67;
                    $MSG_Num++;
                }
            }
            else
            {
                $MSG_Num++;
            }
        }
        else
        {
            if ($StrLen>160)
            {
                while($StrLen>0)
                {
                    $StrLen -= 134;
                    $MSG_Num++;
                }
            }
            else
            {
                $MSG_Num++;
            }
        }

        return $MSG_Num;
    }

    public function isItUnicode($text)
    {
        $unicode=false;
        $str = "������������������������������������������¡�����������������������������������'���ק������������";

        for ($i=0; $i <= strlen($str); $i++)
        {
            $strResult= substr($str,$i,1);

            for($R=0; $R<=strlen($text); $R++)
            {
                $msgResult= substr($text,$R,1);

                if($strResult==$msgResult && $strResult)
                {
                    $unicode=true;
                }
            }
        }

        return $unicode;
    }

    private function toUnicode($text)
    {
        $Backslash = "\ ";
        $Backslash = trim($Backslash);

        $UniCode = Array
        (
            "�" => "060C",
            "�" => "061B",
            "�" => "061F",
            "�" => "0621",
            "�" => "0622",
            "�" => "0623",
            "�" => "0624",
            "�" => "0625",
            "�" => "0626",
            "�" => "0627",
            "�" => "0628",
            "�" => "0629",
            "�" => "062A",
            "�" => "062B",
            "�" => "062C",
            "�" => "062D",
            "�" => "062E",
            "�" => "062F",
            "�" => "0630",
            "�" => "0631",
            "�" => "0632",
            "�" => "0633",
            "�" => "0634",
            "�" => "0635",
            "�" => "0636",
            "�" => "0637",
            "�" => "0638",
            "�" => "0639",
            "�" => "063A",
            "�" => "0641",
            "�" => "0642",
            "�" => "0643",
            "�" => "0644",
            "�" => "0645",
            "�" => "0646",
            "�" => "0647",
            "�" => "0648",
            "�" => "0649",
            "�" => "064A",
            "�" => "0640",
            "�" => "064B",
            "�" => "064C",
            "�" => "064D",
            "�" => "064E",
            "�" => "064F",
            "�" => "0650",
            "�" => "0651",
            "�" => "0652",
            "!" => "0021",
            '"' => "0022",
            "#" => "0023",
            "$" => "0024",
            "%" => "0025",
            "&" => "0026",
            "'" => "0027",
            "(" => "0028",
            ")" => "0029",
            "*" => "002A",
            "+" => "002B",
            "," => "002C",
            "-" => "002D",
            "." => "002E",
            "/" => "002F",
            "0" => "0030",
            "1" => "0031",
            "2" => "0032",
            "3" => "0033",
            "4" => "0034",
            "5" => "0035",
            "6" => "0036",
            "7" => "0037",
            "8" => "0038",
            "9" => "0039",
            ":" => "003A",
            ";" => "003B",
            "<" => "003C",
            "=" => "003D",
            ">" => "003E",
            "?" => "003F",
            "@" => "0040",
            "A" => "0041",
            "B" => "0042",
            "C" => "0043",
            "D" => "0044",
            "E" => "0045",
            "F" => "0046",
            "G" => "0047",
            "H" => "0048",
            "I" => "0049",
            "J" => "004A",
            "K" => "004B",
            "L" => "004C",
            "M" => "004D",
            "N" => "004E",
            "O" => "004F",
            "P" => "0050",
            "Q" => "0051",
            "R" => "0052",
            "S" => "0053",
            "T" => "0054",
            "U" => "0055",
            "V" => "0056",
            "W" => "0057",
            "X" => "0058",
            "Y" => "0059",
            "Z" => "005A",
            "[" => "005B",
            $Backslash => "005C",
            "]" => "005D",
            "^" => "005E",
            "_" => "005F",
            "`" => "0060",
            "a" => "0061",
            "b" => "0062",
            "c" => "0063",
            "d" => "0064",
            "e" => "0065",
            "f" => "0066",
            "g" => "0067",
            "h" => "0068",
            "i" => "0069",
            "j" => "006A",
            "k" => "006B",
            "l" => "006C",
            "m" => "006D",
            "n" => "006E",
            "o" => "006F",
            "p" => "0070",
            "q" => "0071",
            "r" => "0072",
            "s" => "0073",
            "t" => "0074",
            "u" => "0075",
            "v" => "0076",
            "w" => "0077",
            "x" => "0078",
            "y" => "0079",
            "z" => "007A",
            "{" => "007B",
            "|" => "007C",
            "}" => "007D",
            "~" => "007E",
            "�" => "00A9",
            "�" => "00AE",
            "�" => "00F7",
            "�" => "00F7",
            "�" => "00A7",
            " " => "0020",
            "\n" => "000D",
            "\r" => "000A",
            "\t" => "0009",
            "�" => "00E9",
            "�" => "00E7",
            "�" => "00E0",
            "�" => "00F9",
            "�" => "00B5",
            "�" => "00E8"
        );

        $Result="";
        $StrLen = strlen($text);
        for ($i=0;$i<$StrLen;$i++)
        {
            $currect_char = substr($text,$i,1);

            if (array_key_exists($currect_char,$UniCode))
            {
                $Result .= $UniCode[$currect_char];
            }

        }

        return $Result;
    }

    private function isMobile(&$M)
    {
        $count = strlen($M);
        $New = '';
        $ARRAY_NUM = array('0','1','2','3','4','5','6','7','8','9');
        for ($x=0;$x<=$count;$x++)
        {
            if (in_array(substr($M, $x, 1),$ARRAY_NUM)){
                $New .= substr($M, $x, 1);
            }
        }

        $M = $New;

        if (substr($New, 0, 2)=="00" || substr($New, 0, 1)=="0")
        {
            return false;
        }
        else
        {
            if (substr($New, 0, 3)=="966")
            {
                if (substr($New, 3, 1)=="0" || strlen($New)!="12")
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }
    }

}