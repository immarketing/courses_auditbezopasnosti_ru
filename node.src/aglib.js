/**
 * Created by AVGorbunov on 04.07.2016.
 */
function readDB() {
    var mysql      = require('mysql');
    var connection = mysql.createConnection({
        host     : 'localhost',
        user     : 'mysqlcoursesuser',
        password : 'Ed61a57pe13XA88j',
        database : 'sfts_courses'
    });
    //$mysqli-> set_charset("UTF8");

    connection.connect();
    /*

    connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
        if (err) throw err;

        console.log('The solution is: ', rows[0].solution);
    });
    */

    connection.query({
        sql: 'select `id`,`Name`,`ShortName` ,`googleDocID` from `agCourses` where `googleDocID` = ?',
        timeout: 40000, // 40s
        values: ['1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw']
    }, function (error, results, fields) {
        if (error) throw error;
        console.log('The results is: ', results[0].googleDocID);
        // error will be an Error if one occurred during the query
        // results will contain the results of the query
        // fields will contain information about the returned results fields (if any)
    });

    connection.end();
}

function updateTOCForGoogleDocIDInDB (gdID, TOC) {
    var mysql      = require('mysql');
    var connection = mysql.createConnection({
        host     : 'localhost',
        user     : 'mysqlcoursesuser',
        password : 'Ed61a57pe13XA88j',
        database : 'sfts_courses'
    });
    //$mysqli-> set_charset("UTF8");

    connection.connect();

    connection.query({
        sql: 'update `agCourses` set `TOCJSON` = ? where `googleDocID` = ?',
        timeout: 40000, // 40s
        values: [ TOC , gdID]
    }, function (error, results, fields) {
        if (error) throw error;
        //console.log('The results is: ', results[0].googleDocID);
        console.log('Update ' + results.affectedRows + ' rows');
        // error will be an Error if one occurred during the query
        // results will contain the results of the query
        // fields will contain information about the returned results fields (if any)
    });

    connection.end();
}

function readURL(gdID) {
    var request = require('request');
    request('https://script.google.com/macros/s/AKfycbyNxTqZfxOECuBD6tJdtLh0xsgo8jl11LzRX2SfeNicljWu6Q/exec?docid='+gdID, function (error, response, body) {
        if (!error && response.statusCode == 200) {
            console.log(body); // Show the HTML for the Google homepage.
            var obj = JSON.parse(body);
            console.log( obj );
        }
    });
}

function updateTOCForGoofleDocID(gdID) {
    var request = require('request');
    request('https://script.google.com/macros/s/AKfycbyNxTqZfxOECuBD6tJdtLh0xsgo8jl11LzRX2SfeNicljWu6Q/exec?docid='+gdID, function (error, response, body) {
        if (!error && response.statusCode == 200) {
            console.log(body); // Show the HTML for the Google homepage.
            var obj = JSON.parse(body);
            console.log( obj );
            updateTOCForGoogleDocIDInDB(gdID, JSON.stringify(obj));
        }
    });
}

exports.readDB = readDB;
exports.readURL = readURL;
exports.updateTOCForGoofleDocID = updateTOCForGoofleDocID;

