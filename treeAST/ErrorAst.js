"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var ErrorAst = /** @class */ (function () {
    function ErrorAst(descripcion, lexema, linea, columna, id) {
        this.descripcion = descripcion;
        this.lexema = lexema;
        this.linea = linea;
        this.columna = columna;
        this.id = id;
    }
    return ErrorAst;
}());
exports.ErrorAst = ErrorAst;
