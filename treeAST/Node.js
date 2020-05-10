"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Node = /** @class */ (function () {
    function Node(tipo, nombre) {
        this.listaIns = [];
        this.tipo1 = tipo;
        this.nombre1 = nombre;
    }
    Node.prototype.encontrarNodo = function (listaNodo) {
        for (var i = 0; i < listaNodo.length; i++) {
            this.listaIns.push(listaNodo[i]);
        }
    };
    return Node;
}());
exports.Node = Node;
