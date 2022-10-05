program ej1;

1.- Implementar un programa que invoque a los siguientes módulos.





a. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y los almacene en un vector con dimensión física igual a 10.


procedure CargarVector (var v: vector; var dimL: integer);

  procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
  var caracter: char;
  begin
    write ('Ingrese un caracter: ');
    readln(caracter);  
    if (caracter <> '.' ) and (dimL < dimF) 
    then begin
          dimL:= dimL + 1;
          v[dimL]:= caracter;
          CargarVectorRecursivo (v, dimL);
         end;
  end;
  
 begin
  dimL:= 0;
  CargarVectorRecursivo (v, dimL);
end;





b. Implementar un módulo que imprima el contenido del vector.
                    
procedure ImprimirVector (v: vector; dimL: integer);
var
   i: integer;
begin
     for i:= 1 to dimL do begin
        write(v[i], ' | ');
     end;
End;    




c. Implementar un módulo recursivo que imprima el contenido del vector.

procedure imprimirVectorRecursivo (v:vector ; dimL: integer);
begin
	if (dimL > 1) then begin
		imprimirVectorRecursivo(v, dimL - 1);
		writeln(v[i]);
	end;
end;





d. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la cantidad de caracteres leídos. 
El programa debe informar el valor retornado.


function ContarCaracteres(): integer;
var 
	caracter: char;
Begin
	write ('Ingrese un caracter: ');
	readln(caracter);  
	if (caracter <> '.' ) then
		ContarCaracteres:= ContarCaracteres() + 1  
	else
		ContarCaracteres:=0  
End;



e. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una lista con los caracteres leídos.


procedure CargarLista (var l: lista);
var 
	caracter: char;
    nuevo: lista;
Begin
	write ('Ingrese un caracter: ');
	readln(caracter);  
	if (caracter <> '.' )then begin
		CargarLista (l);
		new (nuevo);
		nuevo^.dato:= caracter;
		nuevo^.sig:= l;
		l:= nuevo;
	end
	else
		l:= nil
End;


f. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en el mismo orden que están almacenados.

procedure ImprimirListaMismoOrden (l: lista);
begin
	if (l<> nil) then begin
		write (' ', l^.dato);
		ImprimirListaMismoOrden (l^.sig);
	end;
end;


g. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en orden inverso al que están almacenados.

procedure ImprimirListaOrdenInverso (l: lista);
begin
	if (l<> nil) then begin
		ImprimirListaMismoOrden (l^.sig);
		write (' ', l^.dato);
	end;
end;












var

BEGIN
	
	
END.

