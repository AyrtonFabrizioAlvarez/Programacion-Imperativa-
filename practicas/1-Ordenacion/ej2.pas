program ej2;

type

	oficina = record
		codigo:integer;
		dni:integer;
		valor:integer;
	end;
	
	vectorOficina = array [1..300] of oficina;
		
	procedure leerOficina (var O:oficina);
	begin
		Randomize;
		writeln('Ingrese el codigo');
		readln(O.codigo);
		if (O.codigo <> -1) then
		begin
			writeln('Ingrese el dni');
			O.dni:=random(32000);
			writeln('Ingrese el valor');
			O.valor:=random(10000);
		end;
	end;
	
	procedure cargarVector (var V:vectorOficina ; var dimL:integer);
		
		procedure agregarElemento(var V:vectorOficina ; var dimL:integer ; O:oficina);
		begin
			dimL:= dimL + 1;
			V[dimL]:= O;
		end;
		
	var
		O:oficina;
	begin
		dimL:= 0;
		leerOficina(O);
		while (O.codigo <> -1) do
		begin
			agregarElemento(V, dimL, O);
			leerOficina(O);
		end;
	end;
	
	procedure mostrarVector (V:vectorOficina ; dimL:integer);
	var
		i:integer;
	begin
		for i:=1 to dimL do
		begin
			writeln('Oficina ', V[i].codigo);
			writeln('Dni ', V[i].dni);
			writeln('Valor ', V[i].valor);
			writeln('');
		end;
	end;
	
	Procedure ordenInsercion ( var v: vectorOficina; dimL: integer );
	var 
		i, j: integer; actual: oficina;	
	begin
		for i:=2 to dimL do
		begin 
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
	
		procedure ordenSeleccion (var V:vectorOficina ; dimL:integer);
	var
		i, j, pos:integer;
		item:oficina;
	begin
		for i:=1 to dimL-1 do
		begin
			pos:= i;
			for j:= i+1 to dimL do
			begin
				if (V[j].codigo < V[pos].codigo) then
					pos:= j
			end;
			item:= V[pos];
			V[pos]:=V[i];
			V[i]:=item;
		end;
	end;

	
var
	V:vectorOficina;
	dimL:integer;
BEGIN
	Random;
	cargarVector(V, dimL);
	mostrarVector(V, dimL);
	
	ordenSeleccion(V, dimL);
	mostrarVector(V, dimL);
END.

