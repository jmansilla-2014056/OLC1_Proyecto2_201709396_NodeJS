const {NodeAst} = require('../treeAST/NodeAst');
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
try {
    var errores;
    var ast;
    var temp = enter(req.body.llave);

    if(temp.length === 2){
        ast = temp[0];
        errores = temp[1];
    }else{
        errores = temp[1];
        console.log(errores);
        ast = new NodeAst("Raiz","Raiz",0);
    }

    var jsonAst = (JSON.stringify(ast, null, 2));
    var jsonError = (JSON.stringify(errores, null, 2));

    jsonAst = jsonAst.split('nombre1').join('text').split('listaIns').join('children');

    console.log("------------------------JSONERROR----------------------------");
    console.log(jsonError);
    console.log("-------------------------JSONAST-----------------------------");
    console.log(jsonAst);
}catch (e) {
    console.error(e);
}
    //var result1 = JSON.parse(jsonAst);
    //var result2 = JSON.parse(jsonError);

    res.json({tree: jsonAst, errores: jsonError});
});

module.exports = router;