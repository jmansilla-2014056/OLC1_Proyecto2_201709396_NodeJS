"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Node = /** @class */ (function () {
    function Node(tipo, nombre, id) {
        this.listaIns = [];
        this.tipo1 = tipo;
        this.nombre1 = nombre;
        this.id = id;
    }
    Node.prototype.encontrarNode = function (listaNodo) {
        for (var i = 0; i < listaNodo.length; i++) {
            this.listaIns.push(listaNodo[i]);
        }
    };
    return Node;
}());
exports.Node = Node;
