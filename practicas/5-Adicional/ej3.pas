program ej3;

const
	dimF = 10;

type
	producto = record
		codigo:integer;
		rubro:integer;
		stock:integer;
		precio:integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:producto;
		HI:arbol;
		HD:arbol;
	END;
	
	vector = array [1..dimF] of arbol;

procedure cargarVectorArboles(var V:vector);

	procedure leerProducto(var P:producto);
	begin
		writeln('Ingrese el codigo de producto');
		readln(P.codigo);
		if (P.codigo <> -1) then
		begin
			writeln('Ingrese el rubro del producto (1..10)');
			readln(P.rubro);
			//writeln('Ingrese el stock del producto');
			P.stock:= random(101);
			//writeln('Ingrese el precio unitario del producto');
			P.precio:= random(1001);
		end;
	end;
	
	procedure crear(var A:arbol ; P:producto);
	begin
		if (A = nil) then
		begin
			new(A);
			A^.dato:= P;
			A^.HI:= nil;
			A^.HD:= nil;
		end
		else
			if (P.codigo < A^.dato.codigo) then
				crear(A^.HI, P)
			else
				crear(A^.HD, P)
	end;

var
	P:producto;
begin
	leerProducto(P);
	while (P.codigo <> -1) do
	begin
		crear(V[P.rubro], P);
		leerProducto(P);
	end;
end;

procedure buscarCodigoRubro(V:vector);

	function buscar(A:arbol ; buscado:integer):boolean;
	begin
		if (A = nil) then
			buscar:= false
		else
			if (A^.dato.codigo = buscado) then
				buscar:= true
			else
				if (buscado < A^.dato.codigo) then
					buscar:= buscar(A^.HI, buscado)
				else
					buscar:= buscar(A^.HD, buscado)
	end;

var
	rubro, codigo:integer;
begin
	writeln('Ingrese el rubro a buscar');
	readln(rubro);
	writeln('Ingrese el codigo a buscar');
	readln(codigo);
	if (buscar(V[rubro], codigo)) then
		writeln('En el rubro ', rubro, ' se encuentra el codigo ', codigo)
	else
		writeln('En el rubro ', rubro, ' no se encuentra el codigo ', codigo)
end;

procedure stockMayorCodigo(V:vector);

	procedure maximo(A:arbol ; var max, maxStock:integer);
	begin
		if (A <> nil) then
		begin
			maximo(A^.HD, max, maxStock);
			if (A^.dato.codigo > max) then
			begin
				max:= A^.dato.codigo;
				maxStock:= A^.dato.stock;
			end;
		end;
	end;

var
	i, maxCod, maxStock:integer;
begin
	for i:=1 to dimF do
	begin
		maxCod:= -1;
		maximo(V[i], maxCod, maxStock);
		writeln('En el rubro ', i, ' el mayor codigo es: ', maxCod, ' stock: ', maxStock);
	end;
end;

procedure entreValores(V:vector);

	function contar(A:arbol ; inf, sup:integer):integer;
	begin
		if (A = nil) then
			contar:= 0
		else
			if (A^.dato.codigo >= inf) and (A^.dato.codigo <= sup) then
				contar:= contar(A^.HI, inf, sup) + contar(A^.HD, inf, sup) + 1
			else
				if (inf > A^.dato.codigo) then
					contar:= contar(A^.HD, inf, sup)
				else
					contar:= contar(A^.HI, inf, sup)
	end;

var
	inf, sup, i:integer;
begin
	writeln('Ingrese el valor inferior');
	readln(inf);
	writeln('Ingrese el valor superior');
	readln(sup);
	for i:=1 to dimF do
	begin
		writeln('Rubro ', i);
		writeln('La cantidad de codigos entre ', inf, ' y ', sup, ' es: ', contar(V[i], inf, sup));
	end;
end;


VAR
	V:vector;
BEGIN
	cargarVectorArboles(V);
	//buscarCodigoRubro(V);
	stockMayorCodigo(V);
	entreValores(V);
END.
