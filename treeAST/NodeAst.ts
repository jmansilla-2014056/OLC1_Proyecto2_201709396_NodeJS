export class NodeAst{
    //>>> tsc -w
    public listaIns:Array<NodeAst>;
    public tipo1: string;
    public nombre1: string;
    public id: number;

    constructor(tipo:string,nombre:string, id:number){
        this.listaIns= [];
        this.tipo1=tipo;
        this.nombre1=nombre;
        this.id = id;
    }

    encontrarNodeAst(listaNodo:Array<NodeAst>){
        for(let i=0;i<listaNodo.length;i++){
            this.listaIns.push(listaNodo[i]);
        }
    }

}
