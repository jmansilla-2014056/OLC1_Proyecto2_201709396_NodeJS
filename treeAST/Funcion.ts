export class Funcion{
    //>>> tsc -w
    public clase:string;
    public funcion1: string;
    public funcion2: string;
    public parametros1: Array<string>;
    public parametros2: Array<string>;

    constructor(clase:string, funcion1:string, funcion2:string, parametros1:Array<string>, parametros2:Array<string>){
        this.clase=clase;
        this.funcion1 = funcion1;
        this.funcion2 = funcion2;
        this.parametros1 = parametros2;
        this.parametros2 = parametros1;
    }

}
