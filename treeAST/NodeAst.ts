export class NodeAst{
    //>>> tsc -w
    public tipo1: string;
    public nombre1: string;
    public id: number;
    public listaIns:Array<NodeAst>;


    constructor(tipo:string,nombre:string, id:number){
        this.tipo1=tipo;
        this.nombre1=nombre;
        this.id = id;
        this.listaIns= [];
    }

    encontrarNodeAst(listaNodo:Array<NodeAst>){
        for(let i=0;i<listaNodo.length;i++){
            this.listaIns.push(listaNodo[i]);
        }
    }

}
