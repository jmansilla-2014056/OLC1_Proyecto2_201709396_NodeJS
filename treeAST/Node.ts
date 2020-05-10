export class Node{

    public tipo1: string;
    public nombre1: string;
    public listaIns:Array<Node>;

    constructor(tipo:string,nombre:string){
        this.listaIns= [];
        this.tipo1=tipo;
        this.nombre1=nombre;
    }

    encontrarNodo(listaNodo:Array<Node>){
        for(let i=0;i<listaNodo.length;i++){

            this.listaIns.push(listaNodo[i]);
        }
    }

}
