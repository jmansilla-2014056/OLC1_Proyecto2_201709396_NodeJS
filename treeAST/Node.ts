export class Node{
    //>>> tsc -w
    public listaIns:Array<Node>;
    public tipo1: string;
    public nombre1: string;
    public id: number;

    constructor(tipo:string,nombre:string, id:number){
        this.listaIns= [];
        this.tipo1=tipo;
        this.nombre1=nombre;
        this.id = id;
    }

    encontrarNode(listaNodo:Array<Node>){
        for(let i=0;i<listaNodo.length;i++){
            this.listaIns.push(listaNodo[i]);
        }
    }

}
