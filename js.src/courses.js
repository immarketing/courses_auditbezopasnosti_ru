/**
 * Created by AVGorbunov on 25.02.2016.
 */

var parseQueryString = function (strQuery) {
    var strSearch = strQuery.substr(1),
        strPattern = /([^=]+)=([^&]+)&?/ig,
        arrMatch = strPattern.exec(strSearch),
        objRes = {};
    while (arrMatch != null) {
        objRes[arrMatch[1]] = arrMatch[2];
        arrMatch = strPattern.exec(strSearch);
    }
    return objRes;
};

function transformDataToTOCTree(data) {
    var result = [];
    var indents = []; // уровни отступов

    // определяем, какие уровни доступов вообще есть.
    $.each(data, function (key, val) {
        //items.push('<li id="' + key + '">' + val + '</li>');
        //tree.push({'text': val.text});
        indents[0+val.indentStart] = 1;
    });

    // сортируем ключи (уровни доступов) их по возрастанию
    var indentsKeys = [];

    for (i = 0 ; i<= indents.length-1;i++) {
        if (indents [i] > 0) {
            indentsKeys.push(i)
        };
    }

    indentsKeys = indentsKeys.sort(function (a, b) {
        return 0+a - b;
    });

    // соотносим имеющиеся уровни доступов с их уровнями, начиная с 1
    var lvl = 1;
    $.each(indentsKeys, function (key, val) {
        //items.push('<li id="' + key + '">' + val + '</li>');
        //tree.push({'text': val.text});
        indents[val] = lvl++;
    });

    // рабочий массив
    var workArr = [[],[],[],[],[],[]]; // предполагаем максимальное кол-во уровней в 6

    var i = 0;
    // "linkUrl":"#heading=h.1nyf8737emu2"
    for (i = 0; i <= data.length-1; i++ ){
        var curIndent = 0+data[i].indentStart;
        var curLevel = 0+indents[curIndent];
        var curText = ""+ data[i].text;
        var curLinkUrl = ""+ data[i].linkUrl;
        var curUrl = curLinkUrl;
        curUrl = (""+curUrl).replace( /.*=/, "");

        workArr[curLevel-1].push({text : curText, curHash :  curUrl});

        var nextIndent = 0;
        var nextLevel = 0;

        if ( i == data.length-1) {
            //continue;
            nextLevel = 1;
            nextIndent = indentsKeys[0];
        } else {
            nextIndent = 0+data[i+1].indentStart;
            nextLevel = 0+indents[nextIndent];
        }


        if (curIndent == nextIndent) {
            // добавляем текущий уровень
            //workArr[curLevel-1].push({text : curText});
        } else if (curIndent < nextIndent) {
            // добавляем текущий уровень
            //workArr[curLevel-1].push({text : curText});
            var j = 0;
            for (j = curLevel+1; j <= nextLevel-1; j++) {
                workArr[j-1].push({text : "?????"});
            }
        } else {
            // текущий уровень больше следующего. Надо закрывать.
            //workArr[curLevel-1].push({text : curText});
            var j = 0;
            for (j = curLevel; j >= nextLevel+1; j--) {
                var curArr = workArr[j-2].pop();
                curArr.nodes = workArr[j-1];
                workArr[j-2].push(curArr);
                workArr[j-1] = [];
                //workArr[j-1].push({text : "?????"});
            }
        }
    }

    result = workArr[0];

    return result;
}

function sendTic(){
    var getO = parseQueryString(location.search);
    var _ijt = getO['_ijt'];

    $.getJSON('./index.php?action=tic&' + (_ijt ? '_ijt=' + _ijt : ''), function (data) {
        console.log("sendTic() success");
        console.log(data);
        agTICResult = data;
        console.log(agTICResult);
    }).done(function () {
        console.log("sendTic() second success");
    })
        .fail(function (d, textStatus, error) {
            //console.log("error");
            console.error("sendTic() getJSON failed, status: " + textStatus + ", error: " + error)
        })
        .always(function () {
            console.log("sendTic() complete");
        });
}

function showLearningPanel () {
    $("div#agLearning").removeClass('agDisplayNone');
    $("div#agTesting").addClass('agDisplayNone');

}

function showTestingPanel (){
    loadTestingJSON();
    $("div#agTesting").removeClass('agDisplayNone');
    $("div#agLearning").addClass('agDisplayNone');
}

function agClickPrevBtn() {
    agClickAnswrsBtn(-1);
}

function agStoreQuestion (){
    $("#agTestingAnswrOpt1").text("" + (agTestingData.data[agTestingData.curQuestion].qAns1));
    $("#agTestingAnswrOpt2").text("" + (agTestingData.data[agTestingData.curQuestion].qAns2));
    $("#agTestingAnswrOpt3").text("" + (agTestingData.data[agTestingData.curQuestion].qAns3));
    $("#agTestingAnswrOpt4").text("" + (agTestingData.data[agTestingData.curQuestion].qAns4));
    $("#agTestingAnswrOpt5").text("" + (agTestingData.data[agTestingData.curQuestion].qAns5));
    $("#agTestingAnswrOpt6").text("" + (agTestingData.data[agTestingData.curQuestion].qAns6));

    if ($("#agTestingAnswrRdo1").prop("checked") ) {agTestingData.data[agTestingData.curQuestion].answrNo=1}
    if ($("#agTestingAnswrRdo2").prop("checked") ) {agTestingData.data[agTestingData.curQuestion].answrNo=2}
    if ($("#agTestingAnswrRdo3").prop("checked") ) {agTestingData.data[agTestingData.curQuestion].answrNo=3}
    if ($("#agTestingAnswrRdo4").prop("checked") ) {agTestingData.data[agTestingData.curQuestion].answrNo=4}
    if ($("#agTestingAnswrRdo5").prop("checked") ) {agTestingData.data[agTestingData.curQuestion].answrNo=5}
    if ($("#agTestingAnswrRdo6").prop("checked") ) {agTestingData.data[agTestingData.curQuestion].answrNo=6}

}


function agClickAnswrsBtn(drctn ) {
    if (drctn > 0) {
        if (agTestingData.curQuestion == (agTestingData.data.length-1)) {
            return;
        }
    } else if (drctn < 0) {
        if (agTestingData.curQuestion == 0) {
            return;
        }
    } else if (drctn == 0) {
        return;
    }

    var element = $( this );
    console.log(element);

    agStoreQuestion();
    agTestingData.curQuestion += (drctn<0?-1:1);
    displayTesting();
}

function agClickNextBtn() {
    agClickAnswrsBtn(1);
}

function displayTesting (){
    // показываем тестирование на экране
    var aQuestion = agTestingData.data[agTestingData.curQuestion];

    // agTestingAnswrBtnsPrev
    if (agTestingData.curQuestion == 0) {
        $("#agTestingAnswrBtnsPrev").addClass('disabled');
    } else {
        $("#agTestingAnswrBtnsPrev").removeClass('disabled');
    }

    // agTestingAnswrBtnsNext
    if (agTestingData.curQuestion == (agTestingData.data.length-1)) {
        $("#agTestingAnswrBtnsNext").addClass('disabled');
    } else {
        $("#agTestingAnswrBtnsNext").removeClass('disabled');
    }

    // agTestingAnsrsCurAns
    $("#agTestingAnsrsCurAns").text("" + (agTestingData.curQuestion + 1));

    // agTestingAnsrsTotal
    $("#agTestingAnsrsTotal").text("" + (agTestingData.data.length));

    // agTestingAnswrOpt1
    $("#agTestingAnswrOpt1").text("" + (agTestingData.data[agTestingData.curQuestion].qAns1));
    $("#agTestingAnswrRdo1").prop('checked',(agTestingData.data[agTestingData.curQuestion].answrNo == 1));
    $("#agTestingAnswrOpt2").text("" + (agTestingData.data[agTestingData.curQuestion].qAns2));
    $("#agTestingAnswrRdo2").prop('checked',(agTestingData.data[agTestingData.curQuestion].answrNo == 2));
    $("#agTestingAnswrOpt3").text("" + (agTestingData.data[agTestingData.curQuestion].qAns3));
    $("#agTestingAnswrRdo3").prop('checked',(agTestingData.data[agTestingData.curQuestion].answrNo == 3));
    $("#agTestingAnswrOpt4").text("" + (agTestingData.data[agTestingData.curQuestion].qAns4));
    $("#agTestingAnswrRdo4").prop('checked',(agTestingData.data[agTestingData.curQuestion].answrNo == 4));
    $("#agTestingAnswrOpt5").text("" + (agTestingData.data[agTestingData.curQuestion].qAns5));
    $("#agTestingAnswrRdo5").prop('checked',(agTestingData.data[agTestingData.curQuestion].answrNo == 5));
    $("#agTestingAnswrOpt6").text("" + (agTestingData.data[agTestingData.curQuestion].qAns6));
    $("#agTestingAnswrRdo6").prop('checked',(agTestingData.data[agTestingData.curQuestion].answrNo == 6));
    // agTestingAnsrsAnsText
    $("#agTestingAnsrsAnsText").text("" + (agTestingData.data[agTestingData.curQuestion].qText));
}

function normalizeTestingData() {
    // нормализация данных в списке вопросов
    if (! agTestingData.loaded) {
        return;
    }

    var tData = agTestingData.data;

    for (var i = agTestingData.data.length -1; i >= 0 ; i--){
        var cQuest = agTestingData.data[i];

        if (""==cQuest.qText) {
            // надо удалить этот элемент из массива
            agTestingData.data.splice (i,1);
            continue;
        }
    }
    for (var i = agTestingData.data.length -1; i >= 0 ; i--){
        agTestingData.data[i].noByOrder = i +1; // номер по порядку
    }
}

function initTestingData(dt) {
    agTestingData.data = dt;
    agTestingData.loaded = true;
    agTestingData.curQuestion = 0;

    normalizeTestingData();
    displayTesting();
}

function loadTestingJSON (){
    if (agTestingData.loaded) {
        return;
    }
    var getO = parseQueryString(location.search);
    var _ijt = getO['_ijt'];
    $.getJSON('./index.php?action=gettestingjson&' + (_ijt ? '_ijt=' + _ijt : ''), function (data) {
        console.log("loadTestingJSON() success");
        console.log(data);
        //agTICResult = data;
        //console.log(agTICResult);
        initTestingData(data);
    }).done(function () {
        console.log("loadTestingJSON() second success");
    })
        .fail(function (d, textStatus, error) {
            //console.log("error");
            console.error("loadTestingJSON() getJSON failed, status: " + textStatus + ", error: " + error);
            agTestingData.loaded = false;
            agTestingData.data = [];
            loadTestingJSON();
        })
        .always(function () {
            console.log("loadTestingJSON() complete");
        });
}

function setTOCTree() {
    // Some logic to retrieve, or generate tree structure
    console.log('setTOCTree()');
    //_ijt=qves39b95dmo0h8pt54jok3sft

    var getO = parseQueryString(location.search);
    console.log(getO);
    var _ijt = getO['_ijt'];
    console.log('_ijt == [' + _ijt + ']');

    $.getJSON('./php.src/gettoc.php' + (_ijt ? '?_ijt=' + _ijt : ''), function (data) {
        var tree = [];

        //console.log('function(data)');
        //console.log(data);

        tree = transformDataToTOCTree(data);

        tree = [{ text: "ПТМ ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ  ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)",
            nodes : [{text:'ОБУЧЕНИЕ', nodes :tree, curHash: "" }, {text : 'ТЕСТИРОВАНИЕ', try2Test:""}]
        }];

        $('#agTOCTree').treeview({
            data: tree
        });

        $('#agTOCTree').on('nodeSelected', function(event, data) {
            // Your logic goes here
            /*
            console.log("You clicked a paragraph!");
            console.log(event);
            */
            console.log(data);

            if ('curHash' in data) {
                window.open('https://docs.google.com/document/d/1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw/pub?embedded=true#'+(data.curHash ? data.curHash : ""), 'agContentFrame','');
                showLearningPanel();
                sendTic();
            }

            if ('try2Test' in data) {
                console.log(data);
                if (('result' in window.agTICResult) && ("OK"===window.agTICResult.result)) {
                    // все должно быть ОК
                    console.log('RESULT === OK');
                    showTestingPanel();
                } else {
                    console.log('RESULT !== OK');
                    showLearningPanel ();
                }
            }

            //$('div#itemIdHolder').html(data.agTime);
            //$("#jquery_jplayer_1").jPlayer("play", data.agTime);
        });

    }).done(function () {
        console.log("second success");
    })
        .fail(function (d, textStatus, error) {
            //console.log("error");
            console.error("getJSON failed, status: " + textStatus + ", error: " + error)
        })
        .always(function () {
            console.log("complete");
        });

    return;
}
/*
$( "div#agTOCTree li.node-agTOCTree" ).each(function( index ) {
    //console.log( index + ": " + $( this ).text() );
    console.log( index + ": " + $( this ).text() );
    //$( this ).append ('<a>fff</a>');
});
*/

$(document).ready(function () {
    setTOCTree();
    loadTestingJSON();

    showLearningPanel();
    showTestingPanel();

    $('.agImagePopup').magnificPopup({
        type: 'image'
        // other options
    });

    $('body').each(function () {
        var $spy = $(this).scrollspy('refresh')
    });


    /*
    $(window).scroll(function (eo) {
        //$( "span" ).css( "display", "inline" ).fadeOut( "slow" );
        //console.log("scroll(function(" + eo);

        if ($(document).scrollTop() > $("#about").offset().top - 30) {
            $("a.navbar-brand").show(400);
            //$("a.navbar-brand").removeClass("ag-no-display animated slideOutUp");
            //$("a.navbar-brand").addClass('ag-display animated slideInUp');
        } else {
            $("a.navbar-brand").hide(400);
            //$("a.navbar-brand").removeClass("animated slideInUp");
            //$("a.navbar-brand").addClass('animated slideOutDown');

        }
    });
    */

    // Add smooth scrolling to all links in navbar + footer link
    $(".navbar a, footer a[href='#myPage']").on('click', function (event) {

        // Prevent default anchor click behavior
        event.preventDefault();

        // Store hash
        var hash = this.hash;

        // Using jQuery's animate() method to add smooth page scroll
        // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
        $('html, body').animate({
            scrollTop: $(hash).offset().top
        }, 400, function () {

            // Add hash (#) to URL when done scrolling (default click behavior)
            window.location.hash = hash;
        });
    });

    /*

     $('body>div.container.ag-slideUp').addClass("ag-hidden").viewportChecker({
     classToAdd: 'ag-visible animated fadeIn-- flipInX-- slideInUp',
     offset: 150
     });
     */

    $(".navbar").on("activate.bs.scrollspy", function () {
        //var x = $(".nav li.active > a");
        //$("#demo").empty().html("You are currently viewing: " + x);
        //console.log(x.text());
        //console.log(x.length);

        //$("a.navbar-brand").css("display", "block");
        //$("a.navbar-brand").css("visibility", "visible");
        //$("a.navbar-brand").show(800);
    });
});

var agTICResult = {};
//var agTestingJSON = {};
var agTestingData = { loaded : false, data: []};

