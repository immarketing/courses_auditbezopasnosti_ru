/**
 * Created by AVGorbunov on 01.07.2016.
 */

function readDB() {
    var mysql      = require('mysql');
    var connection = mysql.createConnection({
        host     : 'localhost',
        user     : 'mysqlcoursesuser',
        password : 'Ed61a57pe13XA88j',
        database : 'sfts_courses'
    });

    connection.connect();

    connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
        if (err) throw err;

        console.log('The solution is: ', rows[0].solution);
    });

    connection.end();

}

function readURL() {
    var request = require('request');
    request('https://script.google.com/macros/s/AKfycbyNxTqZfxOECuBD6tJdtLh0xsgo8jl11LzRX2SfeNicljWu6Q/exec?docid=1dvrIuJYSj83jmhmURQCmH6DEIrIs0ivIrw0l5iPFANw', function (error, response, body) {
        if (!error && response.statusCode == 200) {
            console.log(body); // Show the HTML for the Google homepage.
            var obj = JSON.parse(body);
            console.log( obj );
        }
    });
}

readDB();


