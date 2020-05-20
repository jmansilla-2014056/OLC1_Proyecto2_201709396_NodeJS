export class ErrorAst{
    //>>> tsc -w
    public descripcion: string;
    public lexema: string;
    public linea: number;
    public columna : number;
    public id: number;

    constructor(descripcion:string, lexema:string  ,linea:number, columna:number, id:number){
        this.descripcion=descripcion;
        this.lexema = lexema;
        this.linea=linea;
        this.columna = columna;
        this.id = id;
    }

}
