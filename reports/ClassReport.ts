import {NodeAst} from "../treeAST/NodeAst";
import {FuncionReport} from "./FuncionReport";
import {Clase} from "../treeAST/Clase";

export class ClassReport {

  public clases1: Array<NodeAst>;
  public clases2: Array<NodeAst>;
  public copiasclase1: Array<NodeAst>;
  public copiasclase2: Array<NodeAst>;
  public reporte: Array<Clase>;

 constructor(){
     this.clases1 = [];
     this.clases2 = [];
     this.copiasclase1 = [];
     this.copiasclase2 = [];
     this.reporte = []
 }

 compararClases(ast1: NodeAst, ast2: NodeAst ){
     this.clases2 = [];
     this.clases1 = [];
     this.treeclass(ast1);
     this.clases2 = this.clases1;
     this.clases1 = [];
     this.treeclass(ast2);
     this.copyclass(this.clases1,this.clases2);

 }

    copyclass(clases1:  Array<NodeAst>, clasese2:  Array<NodeAst>){
        console.log("-----------------REPORTE 1------------------");
        for(let a of clases1){
            for(let b of clasese2) {
                if(a.nombre1 == b.nombre1){
                    let fr = new FuncionReport();
                    fr.compararFuncion(a, b);
                    fr.llenarReporte();
                    this.reporte.push(fr.report1);
                    this.reporte.push(fr.report2);
                }
            }
        }
    }


 treeclass(temporal: NodeAst){
     if(temporal != null){
         if(temporal.listaIns != null && temporal.listaIns.length > 0){

             for(let i=0;i<temporal.listaIns.length;i++){
                 if(temporal.listaIns[i].tipo1 == "Clase"){
                     this.clases1.push(temporal.listaIns[i]);
                 }
                 this.treeclass(temporal.listaIns[i]);
             }

         }
     }
 }

}