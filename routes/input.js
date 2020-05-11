var express = require('express');
var parser = require('../grammar/grammar').parser;

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
    var jsonG =(JSON.stringify(temp,null,2));

    jsonG = jsonG.split('nombre1').join('text').split('listaIns').join('children');
    console.log(jsonG);

    res.json({mensaje: 'Node js: Resivido' });
});

module.exports = router;