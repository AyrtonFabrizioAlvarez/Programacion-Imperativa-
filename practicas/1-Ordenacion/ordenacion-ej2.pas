program ejercicio2;
type
oficina = record
    codigo:integer;
    dni:longint;
    expensas:real;
   end;

vector = array  [1..300] of oficina;

procedure leerOficina (var ofi:oficina);
begin
    writeln('Ingrese el codigo');
    readln(ofi.codigo);
    if (ofi.codigo <> -1) then
    begin
        writeln('Ingrese el numero de dni');
        readln(ofi.dni);
        writeln('Ingrese el monto de las expensas');
        readln(ofi.expensas);
    end;
end;


procedure cargarVector(var vect : vector ;var dimL:integer);
var
    ofi :oficina;
begin   
    leerOficina(ofi);
    
    while (ofi.codigo<>-1) do begin
        dimL:= dimL+1;
        vect[dimL]:= ofi;
        leerOficina(ofi);
       end;
end;

procedure cargarVector2(var vect : vector ;var dimL:integer);
var
    i:integer;
begin
	Randomize;
        for i:=1 to 100 do begin
        vect[i].codigo:= random(200);
        end;
        diml:=100;
end;


procedure mostrarVector(v:vector ; dimL:integer);
var
i:integer;
begin 
for i:= 1 to dimL do
writeln(i,') ',v[i].codigo);
end;



Procedure ordenInsercion ( var v: vector; dimL: integer );
var i, j: integer; actual: oficina;	
		
begin
 for i:=2 to dimL do begin 
     actual:= v[i];
     j:= i-1; 
     while (j > 0) and (v[j].codigo > actual.codigo) do      
       begin
         v[j+1]:= v[j];
         j:=  j - 1;                  
       end;  
     v[j+1]:= actual; 
 end;
end;

procedure ordenSeleccion (var v:vector ; dimL:integer);
var
	i, j, pos:integer;
	item : oficina;
begin
	for i:=1 to dimL-1 do begin {busca el mínimo y guarda en p la posición}
		pos := i;
		for j := i+1 to dimL do
			if (v[j].codigo < v[pos].codigo) then
				pos:=j;

			 {intercambia v[i] y v[p]}
		item := v[pos];   
		v[pos]:= v[i];   
		v[i]:= item;
      end;
end;

    
var 
diml : integer;
vect :vector;

BEGIN
dimL:=0;
cargarVector2(vect,dimL);
mostrarVector(vect, dimL);
ordenInsercion(vect, dimL);
ordenSeleccion(vect, dimL);
mostrarVector(vect, dimL);
END.
