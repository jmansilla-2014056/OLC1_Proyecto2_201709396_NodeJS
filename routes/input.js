var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {

}
);

router.post('/',  (req, res)=> {
    console.log(req.body.llave);
    res.json({ mensaje: 'Node js: Resivido' });
});

module.exports = router;