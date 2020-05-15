var express = require('express');
var parser = require('../grammar/grammar2').parser;

function enter(input) {
    return parser.parse(input);
}
    
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {

}
);

router.post('/',  (req, res)=> {
    console.log(req.body.llave);
    var temp = enter(req.body.llave);
    console.log(temp);
    var jsonG =(JSON.stringify(temp,null,2));

    jsonG = jsonG.split('nombre1').join('text').split('listaIns').join('children');
    console.log(jsonG);

    var result1 = JSON.parse(jsonG);

    res.json({tree: result1});
});

module.exports = router;