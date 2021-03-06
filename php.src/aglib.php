<?php
/**
 * Created by PhpStorm.
 * User: AVGorbunov
 * Date: 04.07.2016
 * Time: 13:14
 */

function connectDB (){
    $mysqli = new mysqli("localhost", "mysqlcoursesuser", "Ed61a57pe13XA88j", "sfts_courses");
    $mysqli-> set_charset("UTF8");
    if (!$mysqli) {
        die("Connection failed: " . $mysqli->connect_error);
    }

    return $mysqli;
}

function agAnswerJSON ($toSend){
    header("Content-Type: application/json");
    echo ( json_encode ($toSend));
}

// to.do что-то надо сделать, и сделать быстро
function initJSONReplyOK () {
    $rpl = [
        //'status'=>"OK"
        //, ''
    ];
    setJSONReplyOK($rpl);
    return $rpl;
}

function setJSONReplyError (&$jsn, $errMsg = '', $errDesc = '') {
    $jsn['status']="error";
    $jsn['error']=$errMsg;
    $jsn['errorDesc']=$errDesc;
}

function setJSONReplyOK (&$jsn) {
    $jsn['status']="OK";
}

function setJSONReplyRedirect (&$jsn, $rdr) {
    $jsn['redirect']=$rdr;
}

function initJSONReplyError () {
    $rpl = [
        //'status'=>"error"
        //, ''
    ];
    setJSONReplyError($rpl);
    return $rpl;
}

// to.do надо просмотреть все использования и в тех, в которых устанавливается ошибка, переделать на процедуру
function initJSONReply ($isError = false) {
    return (!$isError?initJSONReplyOK():initJSONReplyError());
}

function setTestResultForPPLID ($id, $testResultJSONAsString) {
    $db = connectDB();
    $prep = $db->prepare("update sfts_courses.agpupils set isTestCompleted = 1,testResult = ? where id = ?");
    $prep->bind_param('si',$testResultJSONAsString, $id );
    $prep->execute();
    //$result = $db->query();
    $db->close();
}
function getTestingJSONForTestID ($id) {
    $result = '';
    $tst = readTests($id);
    if ($tst) {
        // прочитали данные теста из базы. Реально мне нужна только информация по ID гугл документа
        $courseID = $tst['GoogleSheetID'];
    }
    if ($tst['JSON']) {
        $result = $tst['JSON'];
    } else {
        $url = 'https://script.google.com/macros/s/AKfycbxCQvc631SEAgPfjIukHwyGlT89IyL8XMb3UdODclQaAWpBjA/exec?version=2&docid='.$courseID;
        $result = file_get_contents($url);
        $db = connectDB();
        $prep = $db->prepare("update agtests set JSON = ? where id = ? and JSON is NULL ");
        $prep->bind_param('si',$result, $id );
        $prep->execute();
        //$result = $db->query();
        $db->close();
        // mysqli_stmt::send_long_data ( int $param_nr , string $data )
    }
    return $result;
}

function readTests ($id) {
    try {
        $db = connectDB();
        $query = "select * from agtests where id = ? limit 1";
        $sth = $db->prepare($query);
        $sth->bind_param('i', $id);
        $sth->execute( );
        $result = $sth->get_result();
        return $result->fetch_assoc();
    } catch (Exception $e){
        throw $e;
    }
}

function readCourses ($id){
    try {
        $db = connectDB();
        $query = "select * from agcourses where id = ? limit 1";
        $sth = $db->prepare($query);
        $sth->bind_param('i', $id);
        $sth->execute( );
        $result = $sth->get_result();
        return $result->fetch_assoc();
    } catch (Exception $e){
        throw $e;
    }
}

function readGoogleTOC ($gdID) {
    //$mysqli = new mysqli("localhost", "mysqlcoursesuser", "Ed61a57pe13XA88j", "sfts_courses");
    $mysqli = connectDB();
    if (!$mysqli) {
        die("Connection failed: " . $mysqli->connect_error);
    }
    $gdID = $mysqli->real_escape_string($gdID);
    $result = $mysqli->query("select `id`,`Name`,`ShortName` ,`googleDocID`, `TOCJSON` from `agCourses` where `googleDocID` = '$gdID'");

    $row = $result->fetch_assoc();
    //echo "id: " . $row["id"]. " - Name: " . $row["googleDocID"]. " " . $row["TOCJSON"]. "<br>";

    return $row["TOCJSON"];

    /*

    if (mysqli_num_rows($result) > 0) {
        // output data of each row
        while($row = mysqli_fetch_assoc($result)) {
            echo "id: " . $row["id"]. " - Name: " . $row["firstname"]. " " . $row["lastname"]. "<br>";
        }
    } else {
        echo "0 results";
    }
    */

    $result->free_result();
    $mysqli->close();
    //echo htmlentities($row['_message']);


}

function testWord() {
    $phpWord = new  \PhpOffice\PhpWord\PhpWord();

    $phpWord->setDefaultFontName('Times New Roman');
    $phpWord->setDefaultFontSize(14);
    $properties = $phpWord->getDocInfo();
    $properties->setCreator('Name');
    $properties->setCompany('Company');
    $properties->setTitle('Title');
    $properties->setDescription('Description');
    $properties->setCategory('My category');
    $properties->setLastModifiedBy('My name');
    $properties->setCreated(mktime(0, 0, 0, 3, 12, 2015));
    $properties->setModified(mktime(0, 0, 0, 3, 14, 2015));
    $properties->setSubject('My subject');
    $properties->setKeywords('my, key, word');
    $sectionStyle = array(

        'orientation' => 'landscape',
        'marginTop' => \PhpOffice\PhpWord\Shared\Converter::pixelToTwip(10),
        'marginLeft' => 600,
        'marginRight' => 600,
        'colsNum' => 1,
        'pageNumberingStart' => 1,
        'borderBottomSize' => 100,
        'borderBottomColor' => 'C0C0C0'

    );
    $section = $phpWord->addSection($sectionStyle);

    $text = "PHPWord is a library written in pure PHP that provides a set of classes to write to and read from different document file formats.";
    $fontStyle = array('name'=>'Arial', 'size'=>36, 'color'=>'075776', 'bold'=>TRUE, 'italic'=>TRUE);
    $parStyle = array('align'=>'right','spaceBefore'=>10);

    $section->addText(htmlspecialchars($text), $fontStyle,$parStyle);

    $fontStyle = array('name' => 'Times New Roman', 'size' => 16,'color' => '075776','italic'=>true);
    $listStyle = array('listType'=>\PhpOffice\PhpWord\Style\ListItem::TYPE_BULLET_EMPTY);

    $section->addListItem('Элемент 1',0,$fontStyle,$listStyle);
    $section->addListItem('Элемент 2',0,$fontStyle,$listStyle);
    $section->addListItem('Элемент 3',0,$fontStyle,$listStyle);
    $section->addListItem('Элемент 4',0,$fontStyle,$listStyle);
    $section->addListItem('Элемент 5',0,$fontStyle,$listStyle);

    $objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord,'Word2007');
    $objWriter->save('doc.docx');

    $objReader = \PhpOffice\PhpWord\IOFactory::createReader('ODText');
//($phpWord,'Word2007');
//$file2load = 'C:\Users\Папа\Google Диск\Бизнес\АудитБезопасности\Сайт школа безопасности\Пробная программа.odt';
    $file2load = 'doc2.odt';
    if ($objReader->canRead($file2load) || 1==1) {
        $phpW2 = new  \PhpOffice\PhpWord\PhpWord();
        $phpW2 = $objReader->load($file2load);
        $titles = $phpW2->getTitles();
        foreach ($titles->getItems() as $ttl) {
            echo $ttl->getText();
            echo $ttl->getDepth();
            //$ttl.
            //echo $ttl;
        }
        echo $titles;
        //echo $file2load;
    } else {
        echo time();
    }

}

//require_once './aglibs/agdbg.php'; // как будто идет подключение
//require_once 'ajax.php'; // как будто идет подключение
