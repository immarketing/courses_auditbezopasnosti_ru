/**
 * Created by AVGorbunov on 25.02.2016.
 */

var parseQueryString = function (strQuery) {
    var strSearch   = strQuery.substr(1),
        strPattern  = /([^=]+)=([^&]+)&?/ig,
        arrMatch    = strPattern.exec(strSearch),
        objRes      = {};
    while (arrMatch != null) {
        objRes[arrMatch[1]] = arrMatch[2];
        arrMatch = strPattern.exec(strSearch);
    }
    return objRes;
};

function setTOCTree() {
    // Some logic to retrieve, or generate tree structure
    console.log('setTOCTree()');
    //_ijt=qves39b95dmo0h8pt54jok3sft

    var getO = parseQueryString (location.search);
    console.log(getO);
    var _ijt = getO['_ijt']
    console.log('_ijt == ['+ _ijt + ']');

    $.getJSON('./php.src/gettoc.php'+ (_ijt ? '?_ijt='+_ijt : ''), function (data) {
        var tree = [];
        var indents = [];
        console.log('function(data)');
        console.log(data);
        $.each(data, function (key, val) {
            //items.push('<li id="' + key + '">' + val + '</li>');

            //tree.push({'text': val.text});
            indents[val.indentStart] = 1;
        });

        var indentsKeys = indents.keys();
        indentsKeys = indentsKeys.sort(function (a,b) {return a-b;});

        var lvl = 1;
        $.each (indentsKeys, function (key, val) {
            //items.push('<li id="' + key + '">' + val + '</li>');
            //tree.push({'text': val.text});
            indents[key] = lvl++;
        });

        $.each(data, function (key, val) {
            //items.push('<li id="' + key + '">' + val + '</li>');

            //tree.push({'text': val.text});
            //indents[val.indentStart] = 1;
        });

        $('#agTOCTree').treeview({
            data: tree
        });
    }).done(function () {
        console.log("second success");
    })
        .fail(function (d, textStatus, error) {
            //console.log("error");
            console.error("getJSON failed, status: " + textStatus + ", error: "+error)
        })
        .always(function () {
            console.log("complete");
        });

    return;

    var tree = [
        {
            text: "Курс <b>ПРОГРАММА ОБУЧЕНИЯ ПОЖАРНО-ТЕХНИЧЕСКОГО МИНИМУМА ДЛЯ РУКОВОДИТЕЛЕЙ, ОТВЕТСТВЕННЫХ ЗА ПОЖАРНУЮ БЕЗОПАСНОСТЬ ОБЪЕКТОВ КУЛЬТУРЫ, ТЕАТРОВ, КИНОТЕАТРОВ, ЦИРКОВ, КЛУБОВ, БИБЛИОТЕК (Ф2)</b>",
            agTime: 0,
            nodes: [
                {
                    text: "<b>1.</b> Законодательная база в области пожарной безопасности",
                    agTime: 0,
                    nodes: [
                        {
                            text: "<b>1.1.</b> Федеральные законы",
                            agTime: 0,

                        },
                        {
                            text: "<b>1.2.</b> Ответственность арендаторов по пожарной безопасности",
                            agTime: 5,

                        },
                        {
                            text: "<b>1.3.</b> Расчет пожарного риска",
                            agTime: 10,
                        },
                        {
                            text: "<b>1.4.</b> Другие нормативные документы"
                        }]
                },
                {
                    text: "<b>2.</b> Порядок проведения мероприятий по надзору",
                    nodes: [
                        {
                            text: "<b>2.1.</b> Нормативные акты, ведомственные документы"
                        },
                        {
                            text: "<b>2.2.</b> Принципы защиты лиц при проведении проверок"
                        },
                        {
                            text: "<b>2.3.</b> Предмет проведения проверки"
                        },
                        {
                            text: "<b>2.4.</b> Виды мероприятий по контролю",
                            nodes: [
                                {
                                    text: "<b>2.4.1.</b> Плановая проверка"
                                },
                                {
                                    text: "<b>2.4.2.</b> Внеплановая проверка"
                                }

                            ]
                        }]
                }]
        },
        {
            text: "Еще один замечательный курс"
        },
        {
            text: "Курс №2 пожарной подготовки к самым сложным ситуациям в природе"
        },
        {
            text: "Курс №3 пожарной подготовки к самым сложным ситуациям в природе"
        },
        {
            text: "Курс №4 пожарной подготовки к самым сложным ситуациям в природе"
        }];
    return tree;
}


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
