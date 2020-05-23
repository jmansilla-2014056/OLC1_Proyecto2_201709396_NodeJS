export class Clase{
    //>>> tsc -w
    public clase:string;
    public metodos: number;
    public funciones: number;

    constructor(clase:string,metodos:number, funciones:number){
        this.clase=clase;
        this.metodos=metodos;
        this.funciones = funciones;
    }

}
