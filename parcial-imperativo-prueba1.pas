

program parcialImperativoPrueba1;

const
    dimF = 500;
type
    planes = 1..5;
    afiliado = record
        numero: integer;
        dni: integer;
        plan: planes;
        ano:integer;
    end;
    
    arbol = ^nodo;
    nodo = record
        dato: afiliado;
        HI: arbol;
        HD: arbol;
    end;

    vector = array[1..dimF] of afiliado;
procedure generarArbol(var A:arbol);
var
	n:afiliado;
	procedure leer (var n:afiliado);
	begin
		writeln('Ingrese el dni, ingrese 0 para cortar la lectura');
		readln(n.dni);
		if (n.dni <> 0) then begin
			writeln('Ingrese el plan');
			readln(n.plan);
			writeln('Ingrese numero');
			readln(n.numero);
			writeln('Ingrese el año');
			readln(n.ano);
		end;
	end;
	procedure insertar (var a:arbol; n:afiliado);
	begin
		if (a = nil) then begin
			new(a); 
            a^.dato:=n; a^.hi:=nil; a^.hd:=nil;
		end
		else begin
			if(n.dni < a^.dato.dni) then
				insertar(a^.hi, n)
			else insertar(a^.hd, n);
		end;
	end;
begin
	a:=nil;
	leer(n);
	while (n.dni <> 0) do begin
		insertar(a,n);
		leer(n);
	end;
end;  
procedure generarVector (A: arbol ; var V: vector ; var dimL: integer ; num1, num2: integer ; planBuscado: planes); {Diml incializada en 0}
begin
    if (A <> nil) and (dimL < 500) then begin
        generarVector(A^.HD, V, dimL, num1, num2, planBuscado);
        generarVector(A^.HI, V, dimL, num1, num2, planBuscado);
        if (A^.dato.plan = planBuscado) and (A^.dato.dni >= num1) and (A^.dato.dni <= num2) then begin
            dimL:=dimL+1;
            V[dimL]:=A^.dato;
        end; 
    end;
end;
procedure imprimirVector(V:vector; dimL:integer) ;
var
    i: integer;
begin
    for i:= 1 to dimL do
    begin
        writeln(V[i].plan);
        writeln(V[i].dni);
    end;
end;

procedure ordenSeleccion (var V: vector ; dimL: integer);
var
    i, j, pos: integer;
    item: afiliado;
begin
    for i:= 1 to (dimL - 1) do
    begin
        pos:= i;
        for j:= (i + 1) to dimL do
        begin
            if (V[j].dni < V[pos].dni) then
                pos:= j;
            item:= V[pos];
            V[pos]:= V[i];
            V[i]:= item;
        end;
;    end;
end;


var
    A: arbol;
    V: vector;
    dimL: integer;
    num1, num2: integer;
    plan: planes;
begin
    generarArbol(A); //SE DISPONE
    
    writeln('Ingrese el numero inferior de DNI a buscar');
    readln(num1);
    writeln('Ingrese el numero superior de DNI a buscar');
    readln(num2);
    writeln('Ingrese el plan al que debe pertenecer el socio');
    readln(plan);
    dimL:= 0;
    generarVector(A, V, dimL, num1, num2, plan);
    writeln(dimL);
    imprimirVector(V, dimL);
    ordenSeleccion(V, dimL);
    imprimirVector(V, dimL);
end.


