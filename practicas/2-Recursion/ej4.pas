program ej4;
const 
    dimF=20;
type
    vector=array[1..dimF]of integer;

procedure cargarVector(var v:vector;var dimL:integer);
var
    x:integer;
begin
    if(dimL<dimF)then begin
        x:=random(100);
        dimL:=dimL+1;
        v[dimL]:=x;
        cargarVector(v,dimL);
    END;
END;

procedure maximo(v:vector; dimL:integer ; var max:integer);
begin
    if (dimL > 0) then
    begin
        if (V[dimL] > max) then
            max:= V[dimL];
        maximo(v, dimL-1, max);
    end;
end;

procedure imprimir(v:vector);
var
    i:integer;
begin
    for i := 0 to dimF do
        writeln(v[i]);
end;
    
function sumarValores(v:vector;dimL:integer):integer;
begin
    if(dimL>0)then
        sumarValores:=sumarValores(v,dimL-1)+v[dimL]
    else
        sumarValores:=0;
end;

var
    V:vector;
    dimL, max:integer;
BEGIN
    max:= -1;
    cargarVector(V, dimL);
    imprimir(v);
    writeln(' ');
    maximo(V, dimL, max);
    writeln('el maximo es ', max);
    writeln('la suma de los valores es: ',sumarValores(V, dimL));
END.
