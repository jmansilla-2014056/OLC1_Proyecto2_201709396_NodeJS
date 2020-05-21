const {NodeAst} = require('../treeAST/NodeAst');
const {ErrorAst} = require("../treeAST/ErrorAst");
const {ClassReport} = require("../reports/ClassReport");

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
try {
    var temp1 = enter(req.body.llave1);
    var  ast1;
    var err1;
    if(temp1[0] === undefined) {
        ast1 = new NodeAst("Raiz", "Raiz", 0);
    }else{
        ast1 = temp1[0];
    }

    if(temp1[1] === undefined || temp1[1].length ===  0 ){
        err1 = [new ErrorAst("","",null,null)];
    }else{
        err1 = temp1[1];
    }

    var jsonAst1 = (JSON.stringify(ast1, null, 2));
    var jsonError1 = (JSON.stringify(err1, null, 2));

    jsonAst1 = jsonAst1.split('nombre1').join('text').split('listaIns').join('children');

    var temp2 = enter(req.body.llave2);
    var  ast2;
    var err2;
    if(temp2[0] === undefined) {
        ast2 = new NodeAst("Raiz", "Raiz", 0);
    }else{
        ast2 = temp2[0];
    }

    if(temp2[1] === undefined || temp2[1].length ===  0 ){
        err2 = [new ErrorAst("","",null,null)];
    }else{
        err2 = temp2[1];
    }

    var jsonAst2 = (JSON.stringify(ast2, null, 2));
    var jsonError2 = (JSON.stringify(err2, null, 2));

    var nuevo = new ClassReport(ast1,ast2);


    jsonAst2 = jsonAst2.split('nombre1').join('text').split('listaIns').join('children');

}catch (e) {
    console.error(e);
}

    res.json({tree1: jsonAst1, errores1: jsonError1, tree2: jsonAst2, errores2: jsonError2});
});

module.exports = router;