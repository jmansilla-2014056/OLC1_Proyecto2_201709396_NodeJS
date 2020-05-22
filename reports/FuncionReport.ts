import {NodeAst} from "../treeAST/NodeAst";
import {Clase} from "../treeAST/Clase";

export class FuncionReport {
    //Funciones de ambas clases
    public funciones1: Array<NodeAst>;
    public funciones2: Array<NodeAst>;
    //Parametros
    public parametros1: Array<NodeAst>;
    public parametros2: Array<NodeAst>;

    public report1: Clase;
    public report2: Clase;

    public class1: NodeAst;
    public class2: NodeAst;

    constructor(){
        this.funciones1 = [];
        this.funciones2 = [];
        this.parametros1 = [];
        this.parametros2 = [];
        this.report1 = new Clase('', 0,0);
        this.report2 = new Clase('', 0,0);
        this.class1 = new NodeAst('','',0);
        this.class2 = new NodeAst('','',0);
    }


    llenarReporte(){
        this.report1 = new Clase(this.class1.nombre1,this.contarMetodos1(),this.contarFunciones1());
        this.report2 = new Clase(this.class2.nombre1 + "(Copia)",this.contarMetodos2(),this.contarFunciones2());
    }

    contarFunciones1(){
        let contador:number = 0;
        for(let a of this.funciones1){
            if(a.tipo1=="Funcion"){
                contador++;
            }
        }
        return contador;
    }


    contarFunciones2(){
        let contador:number = 0;
        for(let a of this.funciones2){
            if(a.tipo1=="Funcion"){
                contador++;
            }
        }
        return contador;
    }

    contarMetodos1(){
        let contador:number = 0;
        for(let a of this.funciones1){
            if(a.tipo1=="Metodo" || a.tipo1=="Main"){
                contador++;
            }
        }
        return contador;
    }


    contarMetodos2(){
        let contador:number = 0;
        for(let a of this.funciones2){
            if(a.tipo1=="Metodo" || a.tipo1=="Main"){
                contador++;
            }
        }
        return contador;
    }




    compararFuncion(class1: NodeAst, class2: NodeAst ){
        this.class1 = class1;
        this.class2 = class2;
        console.log("---------------------REPORTE 2-----------------------");
        console.log("CLASE: "+ class1.nombre1);
        this.funciones1 = [];
        this.funciones2 = [];
        //Extrar funciones de la clase 1 y de clase 2
        this.treefunc(class1);
        this.funciones2 = this.funciones1;
        this.funciones1 = [];
        this.treefunc(class2);

        //Buscar si hay copias entre las listas de funciones
        this.filterfunc(this.funciones1,this.funciones2);
    }


    filterfunc(funciones1:  Array<NodeAst>, funciones2:  Array<NodeAst>){

        for(let a of funciones1){
            for(let b of funciones2) {
                let bandera: boolean = false;
                // Que sean del mismo tipo retorno
                if(a.nombre1.indexOf('void')  >= 0 && b.nombre1.indexOf('void')  >= 0){
                   bandera = true;
                }else if(a.nombre1.indexOf('int') >= 0 && b.nombre1.indexOf('int') >= 0){
                    bandera = true;
                }else if(a.nombre1.indexOf('String') >= 0 && b.nombre1.indexOf('String') >= 0){
                    bandera = true;
                }else if(a.nombre1.indexOf('char') >= 0 && b.nombre1.indexOf('char') >= 0 ){
                    bandera = true;
                }else if(a.nombre1.indexOf('boolean') >= 0 && b.nombre1.indexOf('boolean') >= 0 ){
                    bandera = true;
                }else if(a.nombre1.indexOf('double') >= 0 && b.nombre1.indexOf('double') >= 0 ) {
                    bandera = true;
                }

                // cumplio que son del mismo tipo ahora verificar parametros
                if(bandera){
                    // Se extraen parametros de a y se extran parametros de b
                    this.parametros2 = [];
                    this.parametros1 = [];
                    this.treeparameters(a);
                    this.parametros2 = this.parametros1;
                    this.parametros1 = [];
                    this.treeparameters(b);

                    //Finalmente se comprueba
                    if(this.funcCopy(this.parametros1, this.parametros2)){
                        console.log("El metodo o funcion :" + a.nombre1 + " es una copia");
                    }

                }

            }
        }
    }


    funcCopy(p1:  Array<NodeAst>, p2: Array<NodeAst>){
        //Sin parametros
        if(p1.length == p2.length && p1.length == 0 ){
            return true;
        }

        //Que tengan la misma cantidad de parametros
        if(p1.length == p2.length){
            for(let i=0;i<p1.length;i++){
                let bandera: boolean = false;
                // que los parametros sean del mismo tipo
                if(p1[i].nombre1.indexOf('void ')  >= 0 && p2[i].nombre1.indexOf('void ')  >= 0){
                    bandera = true;
                }else if(p1[i].nombre1.indexOf('int ') >= 0 && p2[i].nombre1.indexOf('int ') >= 0){
                    bandera = true;
                }else if(p1[i].nombre1.indexOf('String ') >= 0 && p2[i].nombre1.indexOf('String ') >= 0){
                    bandera = true;
                }else if(p1[i].nombre1.indexOf('char ') >= 0 && p2[i].nombre1.indexOf('char ') >= 0 ){
                    bandera = true;
                }else if(p1[i].nombre1.indexOf('boolean ') >= 0 && p2[i].nombre1.indexOf('boolean ') >= 0 ){
                    bandera = true;
                }else if(p1[i].nombre1.indexOf('double ') >= 0 && p2[i].nombre1.indexOf('double ') >= 0 ) {
                    bandera = true;
                }

                if(!bandera){
                    return false;
                }
            }
        }else{
            return false
        }

        return true;
    }

    treeparameters(temporal: NodeAst){
        if(temporal != null){
            if(temporal.listaIns != null && temporal.listaIns.length > 0){
                for(let i=0;i<temporal.listaIns.length;i++){
                    if(temporal.listaIns[i].tipo1 == "Parametros"){
                        this.parametros1.push(temporal.listaIns[i]);
                    }
                    this.treeparameters(temporal.listaIns[i]);
                }
            }
        }
    }


    treefunc(temporal: NodeAst){
        if(temporal != null){
            if(temporal.listaIns != null && temporal.listaIns.length > 0){
                for(let i=0;i<temporal.listaIns.length;i++){
                    if(temporal.listaIns[i].tipo1 == "Metodo" || temporal.listaIns[i].tipo1 == "Main" || temporal.listaIns[i].tipo1 == "Funcion"){
                        this.funciones1.push(temporal.listaIns[i]);
                    }
                    this.treefunc(temporal.listaIns[i]);
                }

            }
        }
    }

}