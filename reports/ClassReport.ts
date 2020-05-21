import {NodeAst} from "../treeAST/NodeAst";

export class ClassReport {

  public clases1: Array<NodeAst>;
  public clases2: Array<NodeAst>;
  public copiasclase1: Array<NodeAst>;
  public copiasclase2: Array<NodeAst>;

 constructor(ast1: NodeAst, ast2: NodeAst){
     this.clases1 = [];
     this.clases2 = [];
     this.copiasclase1 = [];
     this.copiasclase2 = [];
    this.compararClases(ast1,ast2);

 }

 compararClases(ast1: NodeAst, ast2: NodeAst ){
    this.treeclass(ast1);
    this.clases2 = this.clases1;
    this.clases1 = [];
    this.treeclass(ast2);
    this.copyclass(this.clases1,this.clases2);
 }


    copyclass(clases1:  Array<NodeAst>, clasese2:  Array<NodeAst>){
        for(let a of clases1){
            for(let b of clasese2) {
                if(a.nombre1 == b.nombre1){
                    console.log("se detecto una clase copia"+ a.nombre1);
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