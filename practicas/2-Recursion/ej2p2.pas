program ej2p2;

const
    dimF = 10;
type
    vector = array [1..dimF] of integer;

procedure imprimirNumero (x:integer);
begin
    if (x <> 0) then
    begin
        imprimirNumero(x DIV 10);
        writeln(x MOD 10);
    end;
end;

procedure cargarVector(var V:vector ; var dimL:integer);
var
    x:integer;
begin
    writeln('Ingrese un numero');
    readln(x);
    while (dimL < dimF) and (x <> 0) do
    begin
        dimL:= dimL + 1;
        V[dimL]:= x;
        writeln('Ingrese un numero');
        readln(x);
    end;
end;

procedure imprimirVector(V:vector ; dimL:integer);
var
    i:integer;
begin
    if (dimL <> 0) then
        for i:=1 to dimL do 
            imprimirNumero(V[i]);
end;


VAR
    V:vector;
    dimL:integer;
BEGIN
    dimL:=0;
    cargarVector(V, dimL);
    imprimirVector(V, dimL);
END.
