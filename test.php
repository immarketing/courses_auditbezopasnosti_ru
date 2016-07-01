<?php
/**
 * Created by PhpStorm.
 * User: Папа
 * Date: 18.03.2016
 * Time: 23:12
 */
require 'vendor/autoload.php';

\PhpOffice\PhpWord\Autoloader::register();

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
