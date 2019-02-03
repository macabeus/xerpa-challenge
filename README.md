<img src="https://static.thenounproject.com/png/771010-200.png" width="127px" height="127px" align="left"/>

# xerpa-challenge

Implementação do [desafio](https://github.com/hashlab/hiring/tree/5d9c767101f2fa7021155930839fb790e0451f7e) da [Xerpa](https://github.com/Xerpa). Resumidamente, deve-se criar uma aplicação da qual defina-se um campo onde posso criar robôs e determinar as ações para eles percorrerem no campo.

As ações que pode-se determinar ao robô são apenas 3:
- **M**: seguir para frente um tile
- **L**: virar para a esquerda 90° graus
- **R**: virar para a direita 90° graus

Para criar o campo, basta definir o X e Y máximo dele, sendo que as coordenadas `(0, 0)` representam o canto inferior esquerdo e `(X, Y)` representará o canto superior direito.

Ao criar um robô, deve-se dizer as coordenadas e direção inicial dele. A direção é definidida pelas inicias de **N**orth, **S**outh, **E**ast e **W**est.

# Executando

Há duas formas de executar a aplicação: no modo `interactive` e o modo `file`.

## Executando no modo "interactive"

Na pasta do projeto, execute:

```
mix
```

Então, ele pedirá para definir o X e Y máximo do campo, em seguida, as coordenadas iniciais do robô, e por fim, as ações.
Então a aplicação retornará as coordenadas finais do robô e o mapa do campo.

Exemplo:

```
Field: 3 4
Coordinate: 1 0 N
Actions: MMRML
2 2 N
....
....
..N.
....
....
```

Se por acaso uma ação tentar fazer o robô ultrapassar os limites do campo, ela simplesmente será ignorada. Por exemplo:

```
Field: 2 2
Coordinate: 0 0 N
Actions: MMMMMMMMM
0 2 N
N..
...
...
```

## Executando no modo "file"

Também pode-se ler um arquivo de texto, com o seguinte padrão:

```
Primeira linha: X e Y máximo do campo
Linha N: coordenadas iniciais do robô A
Linha N+1: ações do robô A
Linha N+2: coordenadas iniciais do robô B
Linha N+3: ações do robô B
...
```

Por exemplo, um arquivo válido seria:

```
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

Então, podemos rodá-lo usando:

```
mix read_file input.txt
```

O retorno serão as coordenadas finais dos robôs, na mesma ordem que foram definidos. Nesse exemplo, é:

```
1 3 N
5 1 E
......
......
.N....
......
.....E
......
```

O primeiro robô efetuará todo o percurso dele, e em seguida, o segundo, e assim por diante. Fique atento a isso, pois não é possível que dois robôs ocupem o mesmo espaço, por exemplo:

```
5 5
0 1 N
M
0 3 S
M
```

retorna:

```
0 2 N
0 3 S
......
......
S.....
N.....
......
......
```

## Como rodar os testes

```
mix test
```

# Como foi desenvolvido

Em vista que esse foi um projeto de estudo, irei explicar brevemente qual foi o racional de algumas decisões feitas no projeto.

Lembrando que eu não sou nenhum expert de Elixir, então se você tiver uma sugestão melhor, basta falar (e abrir PR) 🥰

## Os robôs e os processos

A primeira ideia que tive em mente foi definir que cada robô seja um processo. Isso me fez muito sentido, já que desse modo eu ganho mais flexibilidade no projeto como um todo.

Cada robô armazena o estado atual dele (as coordenadas, por exemplo), e consegue atualizar o estado ao receber uma determinada ação. Além disso, como cada robô
