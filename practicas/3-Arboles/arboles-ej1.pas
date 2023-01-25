

{Escribir un programa que:
a. Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro y: 
    i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
    ii. Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. 
    iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
    iv. Aumente en 1 la edad de todos los socios.
    v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso.
    vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo#A52A2A que reciba el nombre lei­do y 
        retorne verdadero o falso.
    vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
    viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.
    ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
        los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leÃ­dos y retorne dicha cantidad. 
    x. Informe los numeros de socio en orden creciente. 
    xi. Informe los numeros de socio pares en orden decreciente. }

Program ImperativoClase3;


type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. }

	Procedure LeerSocio (var s: socio);
	begin
		write ('Ingrese numero del socio: ');
		readln (s.numero);
		If (s.numero <> 0) then begin
			write ('Ingrese nombre del socio: ');
			readln (s.nombre);
			write ('Ingrese edad del socio: ');
			readln (s.edad);
		end;
	end;  
  
	Procedure InsertarElemento (var a: arbol; elem: socio);
	Begin
		if (a = nil) then begin
			new(a);
			a^.dato:= elem; 
			a^.HI:= nil; 
			a^.HD:= nil;
		end
		else
			if (elem.numero < a^.dato.numero) then 
				InsertarElemento(a^.HI, elem)
			else 
				InsertarElemento(a^.HD, elem); 
	End;

var unSocio: socio;  
Begin
	a:= nil;
	LeerSocio (unSocio);
	while (unSocio.numero <> 0)do begin
		InsertarElemento (a, unSocio);
		writeln;
		LeerSocio (unSocio);
	end;
end;

procedure InformarNumeroSocioMasGrande (a: arbol);
{Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor.}

	function NumeroMasGrande (a: arbol): integer;
	begin
		if (a = nil) then 
			NumeroMasGrande:= -1
		else 
			if (a^.HD = nil) then
				NumeroMasGrande:= a^.dato.numero
			else
				NumeroMasGrande:= NumeroMasGrande (a^.HD);
	end;
   
var max: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Mas Grande ----->');
  writeln;
  max:= NumeroMasGrande (a);
  if (max = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio mas grande: ', max);
         writeln;
       end;
end;

procedure InformarDatosSocioNumeroMasChico (a: arbol);
{ Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. }
  
  function SocioMasChico (a: arbol): arbol;
  begin
    if ((a = nil) or (a^.HI = nil))
    then SocioMasChico:= a
    else SocioMasChico:= SocioMasChico (a^.HI);
  end;
   
var minSocio: arbol;
begin
  writeln;
  writeln ('----- Informar Datos Socio Numero Mas Chico ----->');
  writeln;
  minSocio:= SocioMasChico (a);
  if (minSocio = nil) then
    writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Socio con numero mas chico: ', minSocio^.dato.numero, ' Nombre: ', minSocio^.dato.nombre, ' Edad: ', minSocio^.dato.edad); 
         writeln;
       end;
end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

  procedure actualizarMaximo(var maxValor,maxElem : integer; valor, elem : integer);
	begin
	  if (valor >= maxValor) then
	  begin
		  maxValor := valor;
		  maxElem := elem;
	  end;
	end;
	
	procedure NumeroMasEdad (a: arbol; var maxEdad, maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		   actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		   numeroMasEdad(a^.HI, maxEdad,maxNum);
		   numeroMasEdad(a^.HD, maxEdad,maxNum);
	   end; 
	end;
	
var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
end;

procedure AumentarEdad (a: arbol);
begin
 if (a <> nil)
 then begin
        a^.dato.edad:= a^.dato.edad + 1;
        AumentarEdad (a^.HI);
        AumentarEdad (a^.HD);
      end;
end;

procedure InformarExistenciaNumeroSocio (a: arbol);
{ Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso. }
       
	function Buscar (a: arbol; num: integer): boolean;
	begin
		if (a = nil) then 
			Buscar:= false
		else
			If (a^.dato.numero = num) then 
				Buscar:= true
			else
				if (num < a^.dato.numero)then
					Buscar:= Buscar (a^.HI, num)
				else Buscar:= Buscar (a^.HD, num)
	end;
  
var numABuscar: integer;
begin
  writeln;
  writeln ('----- Informar Existencia Numero Socio ----->');
  writeln;
  write ('Ingrese numero de socio a buscar: ');
  Readln (numABuscar);
  writeln;
  if (Buscar (a, numABuscar)) 
  then writeln ('El numero ', numABuscar, ' existe')
  else writeln ('El numero ', numABuscar, ' no existe');
  writeln;
end;

{vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo#A52A2A que reciba el nombre lei­do y 
        retorne verdadero o falso.}
procedure informarExistenciaSiNombreSocio (a: arbol);

	procedure existeNombre(a:arbol ; nombre: cadena15 ; var ok: boolean);
	begin
		if (a = nil) then
			ok:= false
		else
			if (a^.dato.nombre = nombre) then
				ok:= true
			else begin
				existeNombre(a^.HI, nombre, ok);
				existeNombre(a^.HD, nombre, ok);
			end;
	end;
var
	nombreBuscado: cadena15;
	ok: boolean;
begin
	writeln('Ingrese el nombre a buscar');
	readln(nombreBuscado);
	existeNombre(a, nombreBuscado, ok);
	if (ok) then
		writeln('El nombre existe')
	else
		writeln('El nombre no existe');
end;

    {vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.}
procedure informarCantSocios (a: arbol);

	function cantSocios(a:arbol):integer;
	begin
		if (a = nil) then
			cantSocios:= 0
		else begin
			cantSocios:= cantSocios(a^.HI) + cantSocios(a^.HD) + 1;
		end;
	end;

begin
	writeln('La cantidad de socios es :', cantSocios(a))
end;

  {viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.}
  
procedure informarPromedioEdad (a:arbol);
 
	function cantSocios(a:arbol):integer;
	begin
		if (a = nil) then
			cantSocios:= 0
		else
			cantSocios:= cantSocios(a^.HI) + cantSocios(a^.HD) + 1;
	end;
	
	function totalEdades (a:arbol):integer;
	begin
		if (a = nil) then
			totalEdades:= 0
		else
			totalEdades:= totalEdades(a^.HI) + totalEdades(a^.HD) + a^.dato.edad;
	end;
	
	function promedio (a:arbol):real;
	begin
		if (a = nil) then
			promedio:= 0
		else
			promedio:= (totalEdades(a) / cantSocios(a));
	end;
 
 begin
	if (promedio(a) = 0) then
		writeln('El arbol esta vacio')
	else
		writeln('El promedio de edad entre los socios del club ','(',cantSocios(a),')' ,' es: ', promedio(a):2:2)
 end;
 
 {ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
  los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leÃ­dos y retorne dicha cantidad. }

procedure informarCantidadSociosEnRango (a:arbol);
 
	function sociosEnRango(a:arbol; inf, sup: integer):integer;
	begin
		if (a = nil) then
			sociosEnRango:= 0
		else
			if (a^.dato.numero >= inf) and (a^.dato.numero <= sup) then
				sociosEnRango:= sociosEnRango(a^.HI, inf, sup) + sociosEnRango(a^.HD, inf, sup) + 1
			else
				if (a^.dato.numero > inf) then
					sociosEnRango:= sociosEnRango(a^.HI, inf, sup)
				else
					if (a^.dato.numero < sup) then
						sociosEnRango:= sociosEnRango(a^.HD, inf, sup) + 1
		
	end;
 
 var
	num1, num2: integer;
 begin
	writeln('Ingrese el primer valor del rango a buscar (valor mas pequeño)');
	readln(num1);
	writeln('Ingrese el segundo valor del rango a buscar (valor mas grande)');
	readln(num2);
	if (sociosEnRango(a, num1, num2) = 0) then
		writeln('No hay socios con numero dentro del rango solicitado')
	else
		writeln('La cantidad de socios con numero dentro del rango son: ', sociosEnRango(a, num1, num2))
 end;
 
 
     {x. Informe los numeros de socio en orden creciente. }
procedure informarNumerosSociosOrdenCreciente (a:arbol);
begin
	if (a <> nil) then begin
		informarNumerosSociosOrdenCreciente(a^.HI);
		writeln(a^.dato.numero);
		informarNumerosSociosOrdenCreciente(a^.HD);
	end;
end;

procedure informarNumerosSociosOrdenDeCreciente (a:arbol);
begin
	if (a <> nil) then begin
		informarNumerosSociosOrdenDeCreciente(a);
		writeln(a^.dato.numero);
		informarNumerosSociosOrdenDeCreciente(a);
	end;
end;



  

  
var a: arbol; 
Begin
{DADOS}
	GenerarArbol (a);
	InformarNumeroSocioMasGrande (a);
	InformarDatosSocioNumeroMasChico (a);
	InformarNumeroSocioConMasEdad (a);
	AumentarEdad (a);
	InformarExistenciaNumeroSocio (a);
{YO}
	informarExistenciaSiNombreSocio(a);
	informarCantSocios(a);
	informarPromedioEdad(a);
	informarCantidadSociosEnRango(a);
	informarNumerosSociosOrdenCreciente(a);
	informarNumerosSociosOrdenDeCreciente(a);
End.




