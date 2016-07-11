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
        console.log("sendTic() second success");
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
        console.log('function(data)');
        console.log(data);

        tree = transformDataToTOCTree(data);

        tree = [{ text: "ПТМ ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ  ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)",
            nodes : tree
        }];

        $('#agTOCTree').treeview({
            data: tree
        });

        $('#agTOCTree').on('nodeSelected', function(event, data) {
            // Your logic goes here
            console.log("You clicked a paragraph!");
            console.log(event);
            console.log(data);

            window.open('https://docs.google.com/document/d/1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw/pub?embedded=true#'+(data.curHash ? data.curHash : ""), 'agContentFrame','');
            sendTic();
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

    $('.agImagePopup').magnificPopup({
        type: 'image'
        // other options
    });

    $('body').each(function () {
        var $spy = $(this).scrollspy('refresh')
    });

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
