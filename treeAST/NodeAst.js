"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var NodeAst = /** @class */ (function () {
    function NodeAst(tipo, nombre, id) {
        this.listaIns = [];
        this.tipo1 = tipo;
        this.nombre1 = nombre;
        this.id = id;
    }
    NodeAst.prototype.encontrarNodeAst = function (listaNodo) {
        for (var i = 0; i < listaNodo.length; i++) {
            this.listaIns.push(listaNodo[i]);
        }
    };
    return NodeAst;
}());
exports.NodeAst = NodeAst;
