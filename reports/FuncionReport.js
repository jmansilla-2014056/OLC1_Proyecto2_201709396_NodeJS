"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var FuncionReport = /** @class */ (function () {
    function FuncionReport() {
        this.funciones1 = [];
        this.funciones2 = [];
        this.parametros1 = [];
        this.parametros2 = [];
    }
    FuncionReport.prototype.compararFuncion = function (class1, class2) {
        console.log("---------------------REPORTE 2-----------------------");
        console.log("CLASE: " + class1.nombre1);
        this.funciones1 = [];
        this.funciones2 = [];
        //Extrar funciones de la clase 1 y de clase 2
        this.treefunc(class1);
        this.funciones2 = this.funciones1;
        this.funciones1 = [];
        this.treefunc(class2);
        //Buscar si hay copias entre las listas de funciones
        this.filterfunc(this.funciones1, this.funciones2);
    };
    FuncionReport.prototype.filterfunc = function (funciones1, funciones2) {
        for (var _i = 0, funciones1_1 = funciones1; _i < funciones1_1.length; _i++) {
            var a = funciones1_1[_i];
            for (var _a = 0, funciones2_1 = funciones2; _a < funciones2_1.length; _a++) {
                var b = funciones2_1[_a];
                var bandera = false;
                // Que sean del mismo tipo
                if (a.nombre1.indexOf('void') >= 0 && b.nombre1.indexOf('void') >= 0) {
                    bandera = true;
                }
                else if (a.nombre1.indexOf('int') >= 0 && b.nombre1.indexOf('int') >= 0) {
                    bandera = true;
                }
                else if (a.nombre1.indexOf('String') >= 0 && b.nombre1.indexOf('String') >= 0) {
                    bandera = true;
                }
                else if (a.nombre1.indexOf('char') >= 0 && b.nombre1.indexOf('char') >= 0) {
                    bandera = true;
                }
                else if (a.nombre1.indexOf('boolean') >= 0 && b.nombre1.indexOf('boolean') >= 0) {
                    bandera = true;
                }
                else if (a.nombre1.indexOf('double') >= 0 && b.nombre1.indexOf('double') >= 0) {
                    bandera = true;
                }
                // cumplio que son del mismo tipo ahora verificar parametros
                if (bandera) {
                    // Se extraen parametros de a y se extran parametros de b
                    this.parametros2 = [];
                    this.parametros1 = [];
                    this.treeparameters(a);
                    this.parametros2 = this.parametros1;
                    this.parametros1 = [];
                    this.treeparameters(b);
                    //Finalmente se comprueba
                    if (this.funcCopy(this.parametros1, this.parametros2)) {
                        console.log("El metodo o funcion :" + a.nombre1 + " es una copia");
                    }
                }
            }
        }
    };
    FuncionReport.prototype.funcCopy = function (p1, p2) {
        if (p1.length == p2.length && p1.length == 0) {
            return true;
        }
        //Que tengan la misma cantidad de parametros
        if (p1.length == p2.length) {
            for (var i = 0; i < p1.length; i++) {
                var bandera = false;
                // que los parametros sean del mismo tipo
                if (p1[i].nombre1.indexOf('void ') >= 0 && p2[i].nombre1.indexOf('void ') >= 0) {
                    bandera = true;
                }
                else if (p1[i].nombre1.indexOf('int ') >= 0 && p2[i].nombre1.indexOf('int ') >= 0) {
                    bandera = true;
                }
                else if (p1[i].nombre1.indexOf('String ') >= 0 && p2[i].nombre1.indexOf('String ') >= 0) {
                    bandera = true;
                }
                else if (p1[i].nombre1.indexOf('char ') >= 0 && p2[i].nombre1.indexOf('char ') >= 0) {
                    bandera = true;
                }
                else if (p1[i].nombre1.indexOf('boolean ') >= 0 && p2[i].nombre1.indexOf('boolean ') >= 0) {
                    bandera = true;
                }
                else if (p1[i].nombre1.indexOf('double ') >= 0 && p2[i].nombre1.indexOf('double ') >= 0) {
                    bandera = true;
                }
                if (!bandera) {
                    return false;
                }
            }
        }
        else {
            return false;
        }
        return true;
    };
    FuncionReport.prototype.treeparameters = function (temporal) {
        if (temporal != null) {
            if (temporal.listaIns != null && temporal.listaIns.length > 0) {
                for (var i = 0; i < temporal.listaIns.length; i++) {
                    if (temporal.listaIns[i].tipo1 == "Parametros") {
                        this.parametros1.push(temporal.listaIns[i]);
                    }
                    this.treeparameters(temporal.listaIns[i]);
                }
            }
        }
    };
    FuncionReport.prototype.treefunc = function (temporal) {
        if (temporal != null) {
            if (temporal.listaIns != null && temporal.listaIns.length > 0) {
                for (var i = 0; i < temporal.listaIns.length; i++) {
                    if (temporal.listaIns[i].tipo1 == "Metodo" || temporal.listaIns[i].tipo1 == "Main" || temporal.listaIns[i].tipo1 == "Funcion") {
                        this.funciones1.push(temporal.listaIns[i]);
                    }
                    this.treefunc(temporal.listaIns[i]);
                }
            }
        }
    };
    return FuncionReport;
}());
exports.FuncionReport = FuncionReport;
