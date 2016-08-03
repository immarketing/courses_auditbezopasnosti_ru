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
        }
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

function agClickDoneBtn() {
    showModal('Вы хотите завершить тестирование?','Вы действительно хотите завершить тестирование? Результаты тестирования будут отправлены на сервер.',
        [{text:'Завершить', action : function() {var a=1;}}]);
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

    //noinspection JSDuplicatedDeclaration
    for (var i = agTestingData.data.length -1; i >= 0 ; i--){
        var cQuest = agTestingData.data[i];

        if (""==cQuest.qText) {
            // надо удалить этот элемент из массива
            agTestingData.data.splice (i,1);
            //noinspection UnnecessaryContinueJS
            continue;
        }
    }
    //noinspection JSDuplicatedDeclaration
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

    //$.getJSON('./php.src/gettoc.php' + (_ijt ? '?_ijt=' + _ijt : ''), function (data) {
    $.getJSON('./index.php?action=gettoc&' + (_ijt ? '_ijt=' + _ijt : ''), function (data) {
        var tree = [];

        //console.log('function(data)');
        //console.log(data);

        if ('OK' !== data['status']) {
            log('Что-то пошло не так при получении строки TOC с сервера');
            return ;
        }

        tree = transformDataToTOCTree(data['data']);

        var crsData = data['courseData'];

        if (crsData) {
            agTestingData['courseData'] = crsData;
            agTestingData['courseDataLoaded'] = true;
        }

        tree = [{ text: crsData ['Name']
            //"ПТМ ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ  ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)"
            ,
            nodes : [{text:'МАТЕРИАЛЫ', nodes :tree, curHash: "" }, {text : 'ТЕСТИРОВАНИЕ', try2Test:""}]
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


}
/*
$( "div#agTOCTree li.node-agTOCTree" ).each(function( index ) {
    //console.log( index + ": " + $( this ).text() );
    console.log( index + ": " + $( this ).text() );
    //$( this ).append ('<a>fff</a>');
});
*/

function randN(n){  // [ 1 ] random numbers
    return (Math.random()+'').slice(2, 2 + Math.max(1, Math.min(n, 15)) );
}

function showModal (header, body, buttons){
    var dlgID = 'agDlgConfirmLogout'+randN(100);
    var labelledby = 'agModalLabelConfLogout'+dlgID;

    var dlgDiv = $('<div/>', {
        id:     dlgID,
        class:  'modal fade',
        tabindex: "-1",
        role: 'dialog',
        'aria-labelledby' : labelledby
    });

    var dlgDivDialog = $('<div/>', {
        class:  'modal-dialog modal-sm',
        role: 'document'
    });
    dlgDiv.append(dlgDivDialog);
    var dlgDivDialogModalContent = $('<div/>', {
        class:  'modal-content'
    });
    dlgDivDialog.append(dlgDivDialogModalContent);
    // <div class="modal-header">
    var dlgDivDialogModalContentHeader = $('<div/>', {
        class:  'modal-header'
    });
    var dlgDivDialogModalContentHeaderCls = $('<button/>', {type : "button", class : "close", 'data-dismiss':"modal", 'aria-label':"Закрыть"});
    $('<i/>', {'class' : "fa fa-times", 'aria-hidden' : "true"}).appendTo(dlgDivDialogModalContentHeaderCls);
    dlgDivDialogModalContentHeader.append(dlgDivDialogModalContentHeaderCls);
    $('<h4/>', {'class' : "modal-title", 'id' : labelledby, text : header }).appendTo(dlgDivDialogModalContentHeader);

    //modal-body
    var dlgDivDialogModalContentBody = $('<div/>', {
        class:  'modal-body'
        ,text: body
    });
    // modal-footer
    var dlgDivDialogModalContentFooter = $('<div/>', {
        class:  'modal-footer'
    });
    $('<button/>', {'class' : "btn btn-default", 'type' : "button", 'data-dismiss':"modal", text: 'Отмена'}).appendTo(dlgDivDialogModalContentFooter);
    dlgDivDialogModalContent.append(dlgDivDialogModalContentHeader);
    dlgDivDialogModalContent.append(dlgDivDialogModalContentBody);
    dlgDivDialogModalContent.append(dlgDivDialogModalContentFooter);

    buttons.forEach(function(item, i, arr) {
        //alert( i + ": " + item + " (массив:" + arr + ")" );
        $('<button/>', {'class' : "btn btn-primary", 'data-dismiss':"modal", 'type' : "button", text: item['text'],
            on : {click : function (event){item['action']();}}
        }).appendTo(dlgDivDialogModalContentFooter);
    });

    $( "body" ).append (dlgDiv);
    dlgDiv.modal({});
}

function handlelogout(e) {
    data = {'action':'logout'};
    $.ajax({ // инициaлизируeм ajax зaпрoс
        type: 'POST', // oтпрaвляeм в POST фoрмaтe, мoжнo GET
        url: 'index.php?action=logout', // путь дo oбрaбoтчикa, у нaс oн лeжит в тoй жe пaпкe
        dataType: 'json', // oтвeт ждeм в json фoрмaтe
        data: data, // дaнныe для oтпрaвки
        beforeSend: function (data) { // сoбытиe дo oтпрaвки
            //form.find('input[type="submit"]').attr('disabled', 'disabled'); // нaпримeр, oтключим кнoпку, чтoбы нe жaли пo 100 рaз
        },
        success: function (data) { // сoбытиe пoслe удaчнoгo oбрaщeния к сeрвeру и пoлучeния oтвeтa
            if (data['error']) { // eсли oбрaбoтчик вeрнул oшибку
                // alert(data['error']); // пoкaжeм eё тeкст
                log (data['error']);
            } else { // eсли всe прoшлo oк
                //alert('Письмo oтврaвлeнo! Чeкaйтe пoчту! =)'); // пишeм чтo всe oк
                rdr = data['redirect'];
                if (rdr) {
                    window.open(rdr, '_top','');
                }
            }
        },
        error: function (xhr, ajaxOptions, thrownError) { // в случae нeудaчнoгo зaвeршeния зaпрoсa к сeрвeру
            log (xhr.status);
            log (thrownError);
            alert("При получении данных с сервера возникла ошибка. Пожалуйста, нажмите ссылку 'Выход' и войдите снова.");
            //alert(xhr.status); // пoкaжeм oтвeт сeрвeрa
            //alert(thrownError); // и тeкст oшибки
        },
        complete: function (data) { // сoбытиe пoслe любoгo исхoдa
            //form.find('input[type="submit"]').prop('disabled', false); // в любoм случae включим кнoпку oбрaтнo
        }

    });
}

$(document).ready(function () {
    setTOCTree();
    loadTestingJSON();

    showLearningPanel();
    showTestingPanel();

    $('.navbar #agLogout').on( 'click', function (event) {
        //$('#agDlgConfirmLogout').modal({});

        showModal('Подтвердите выход!',
            'Вы подтверждаете выход из процесса обучения? Сессия будет завершена и вам придется проходить все заново?',
            [{text:'ОК', action : function (){
                handlelogout (event);
            } }]);
        }
    );

    /*
     $('body>div.container.ag-slideUp').addClass("ag-hidden").viewportChecker({
     classToAdd: 'ag-visible animated fadeIn-- flipInX-- slideInUp',
     offset: 150
     });
     */
});

var agTICResult = {};
//var agTestingJSON = {};
var agTestingData = { loaded : false, data: []};

