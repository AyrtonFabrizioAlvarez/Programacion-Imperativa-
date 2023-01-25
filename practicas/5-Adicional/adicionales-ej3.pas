

program ej3;

const
	dimF = 10;
type
	producto = record
		codigo: integer;
		rubro: integer;
		stock: integer;
		precioUnit: integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato: producto;
		HI: arbol;
		HD: arbol;
	end;
	
	arrArboles = array [1..dimF] of arbol;
	
procedure cargarVectorArboles(var arr: arrArboles);

	procedure leerProducto (var P: producto);
	begin
		writeln('Ingrese el codigo del producto');
		readln(P.codigo);
		if (P.codigo <> -1) then
		begin
			writeln('ingrese el rubro al que pertenece el producto');
			readln(P.rubro);
			writeln('Ingrese el stock del producto');
			readln(P.stock);
			writeln('Ingrese el preciop por unidad');
			readln(P.precioUnit);
		end;
	end;
	
	procedure crearArbol(var A: arbol ; P: producto);
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
				crearArbol(A^.HI, P)
			else
				crearArbol(A^.HD, P)
	end;

var
	P: producto;
begin
	leerProducto(P);
	while(P.codigo <> -1) do
	begin
		crearArbol(arr[P.rubro], P);
		leerProducto(P)
	end;
end;


procedure buscarCodigo(arr: arrArboles);

	function buscar (A: arbol ; buscado:integer):arbol;
	begin
		if (A = nil) then
			buscar:= nil
		else
		begin
			if (buscado = A^.dato.codigo) then
				buscar:= A
			else
				if (buscado < A^.dato.codigo) then
					buscar:= buscar(A^.HI, buscado)
				else
					buscar:= buscar(A^.HD, buscado)
		end;
	end;
var
	rubro: integer;
	codigoBuscado: integer;
begin
	writeln('Ingrese el rubro al que pertenece el producto buscado');
	readln(rubro);
	writeln('Ingrese el codigo de producto buscado');
	readln(codigoBuscado);
	begin
		if ( buscar(arr[rubro], codigoBuscado) <> nil) then
			writeln('El producto con codigo ', codigoBuscado , ' existe en el rubro ', rubro)
		else
			writeln('El producto no existe')
	end;
end;


procedure encontrarMaximos(arr: arrArboles);

	procedure maximo(A: arbol ; var stockBuscado: integer ; var max: integer);
	begin
		if (A^.HD <> nil) then
		begin
			maximo(A^.HD, stockBuscado, max);
			if (A^.dato.codigo > max) then
			begin
				max:= A^.dato.codigo;
				stockBuscado:= A^.dato.stock;
			end;
		end;
	end;

var
	i: integer;
	maxCod: integer;
	stockBuscado: integer;
begin
	for i:= 1 to dimF do
	begin
		maxCod:= -1;
		maximo(arr[i], stockBuscado, maxCod);
		writeln('El codigo mas grande del rubro ', i, ' es el ', maxCod, ' su stock es de: ', stockBuscado)
	end;
end;

procedure cantEntreValores (arr: arrArboles);

	procedure contar(A: arbol ; inferior: integer ; superior: integer ; var cant: integer);
	begin
		if (A <> nil) then
			if (A^.dato.codigo >= inferior) and (A^.dato.codigo <= superior) then
			begin
				cant:= cant + 1;
				contar(A^.HI, inferior, superior, cant);
				contar(A^.HD, inferior, superior, cant);
			end
			else
				if (A^.dato.codigo > inferior) then
					contar(A^.HI, inferior, superior, cant)
				else
					if (A^.dato.codigo < superior) then
						contar(A^.HD, inferior, superior, cant)	
	end;

var
	i: integer;
	cantidad: integer;
	inferior: integer;
	superior: integer;
begin
	for i:= 1 to dimF do
	begin
		cantidad:= 0;
		writeln('Ingrese el numero inferior');
		readln(inferior);
		writeln('Ingrese el numero superior');
		readln(superior);
		contar(arr[i], inferior, superior, cantidad);
		writeln('En el rubro ', i, ' tenemos ', cantidad, ' productos cuyo codigo esta entre los valores ingresados ', '(', inferior, ' ', superior, ')');
	end;
end; 

var
	arr: arrArboles;
BEGIN
	cargarVectorArboles(arr);
	buscarCodigo(arr);
	encontrarMaximos(arr);
	cantEntreValores(arr);
END.

