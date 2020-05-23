export class Variable{
    //>>> tsc -w
    public clase:string;
    public funcion1: string;
    public funcion2: string;
    public tipo: string;
    public variable1: string;
    public variable2: string;


    constructor(clase:string, funcion1: string, funcion2: string, tipo:string, variable1:string, variable2:string){
        this.clase=clase;
        this.funcion1=funcion1;
        this.funcion2 = funcion2;
        this.tipo = tipo;
        this.variable1 = variable1;
        this.variable2 = variable2;
    }

}
