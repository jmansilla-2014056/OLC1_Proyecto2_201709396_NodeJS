"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var FuncionReport_1 = require("./FuncionReport");
var ClassReport = /** @class */ (function () {
    function ClassReport(ast1, ast2) {
        this.clases1 = [];
        this.clases2 = [];
        this.copiasclase1 = [];
        this.copiasclase2 = [];
        this.compararClases(ast1, ast2);
    }
    ClassReport.prototype.compararClases = function (ast1, ast2) {
        this.clases2 = [];
        this.clases1 = [];
        this.treeclass(ast1);
        this.clases2 = this.clases1;
        this.clases1 = [];
        this.treeclass(ast2);
        this.copyclass(this.clases1, this.clases2);
    };
    ClassReport.prototype.copyclass = function (clases1, clasese2) {
        console.log("-----------------REPORTE 1------------------");
        for (var _i = 0, clases1_1 = clases1; _i < clases1_1.length; _i++) {
            var a = clases1_1[_i];
            for (var _a = 0, clasese2_1 = clasese2; _a < clasese2_1.length; _a++) {
                var b = clasese2_1[_a];
                if (a.nombre1 == b.nombre1) {
                    var fr = new FuncionReport_1.FuncionReport();
                    fr.compararFuncion(a, b);
                }
            }
        }
    };
    ClassReport.prototype.treeclass = function (temporal) {
        if (temporal != null) {
            if (temporal.listaIns != null && temporal.listaIns.length > 0) {
                for (var i = 0; i < temporal.listaIns.length; i++) {
                    if (temporal.listaIns[i].tipo1 == "Clase") {
                        this.clases1.push(temporal.listaIns[i]);
                    }
                    this.treeclass(temporal.listaIns[i]);
                }
            }
        }
    };
    return ClassReport;
}());
exports.ClassReport = ClassReport;
