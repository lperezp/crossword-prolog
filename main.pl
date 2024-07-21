% Inicializar la matriz
:- dynamic matriz/1.
matriz([
    [c, x, s, a],
    [x, m, x, r],
    [s, o, l, x],
    [a, x, o, s]
]).

% Regla permitida
es_valido(1,2,a).
es_valido(2,1,a).
es_valido(2,3,o).
es_valido(3,4,o).
es_valido(4,2,r).

crucigrama :-
    write("[c,_,s,a]"), nl,
    write("[_,m,_,r]"), nl,
    write("[s,o,l,_]"), nl,
    write("[a,_,o,s]"), nl.

ayuda :-
    write("1. Lugar donde una persona habita."), nl,
    write("2. Sentimiento fuerte de afecto."), nl,
    write("3. Contrario de acompañado."), nl,
    write("4. Joyería en forma de círculo."), nl.

solucion :-
    write("[c,a,s,a]"), nl,
    write("[a,m,o,r]"), nl,
    write("[s,o,l,o]"), nl,
    write("[a,r,o,s]"), nl.

inicio :-
write("Bienvenido al Crucigrama de la UTP"), nl,nl,
write("Tienes que llenar los valores de X hasta terminar el crucigrama."),
write("Si necesitas ayuda, usa el comando 'ayuda.'"),
write("Si quieres ver el estado del juego, coloca 'ver.'"),
nl,nl,
ver.

% Imprimir la matriz con los valores cambiados
ver :-
    matriz(Matriz),
    imprimir_matriz(Matriz).

% Función para imprimir la matriz
imprimir_matriz([]).
imprimir_matriz([Fila|Resto]) :-
    write(Fila),
    nl,
    imprimir_matriz(Resto).

% Regla para cambiar el valor en la matriz solo si es 'x' y el valor es válido
llenar(Fila, Columna, Valor) :-
    es_valido(Fila, Columna, Valor),
    matriz(Matriz),
    actualizar_matriz(Matriz, Fila, Columna, Valor, NuevaMatriz),
    retract(matriz(Matriz)),
    assert(matriz(NuevaMatriz)),
    ver.
    

% Actualizar la matriz en la posición especificada
actualizar_matriz([], _, _, _, []).
actualizar_matriz([Fila|Resto], FilaIndex, Columna, Valor, [NuevaFila|NuevaResto]) :-
    FilaIndex =:= 1,
    actualizar_fila(Fila, Columna, Valor, NuevaFila),
    NuevaResto = Resto.
actualizar_matriz([Fila|Resto], FilaIndex, Columna, Valor, [Fila|NuevaResto]) :-
    FilaIndex > 1,
    FilaIndex1 is FilaIndex - 1,
    actualizar_matriz(Resto, FilaIndex1, Columna, Valor, NuevaResto).

% Actualizar una fila en la posición especificada
actualizar_fila([], _, _, []).
actualizar_fila([_|Resto], 1, Valor, [Valor|Resto]).
actualizar_fila([Elemento|Resto], Columna, Valor, [Elemento|NuevaResto]) :-
    Columna > 1,
    Columna1 is Columna - 1,
    actualizar_fila(Resto, Columna1, Valor, NuevaResto).

% Inicio
 :- inicio. 