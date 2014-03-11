Compiladores 2014/2015
========

Compilador para a linguagem iJava
  Este projeto consiste no desenvolvimento de um compilador para a linguagem iJava (imperative Java), que consiste num pequeno subconjunto da linguagem Java (versão 5.0). Os programas da linguagem iJava são constituídos por uma única classe (a classe principal), contendo necessariamente um método main, e podendo conter outros métodos e atributos, todos eles estáticos e (possivelmente) públicos.
  
Na linguagem iJava é possível utilizar variáveis e literais dos tipos inteiro (de 32 bits) com sinal e booleano, e variáveis dos tipos array de inteiros e array de valores booleanos (com uma única dimensão). A linguagem implementa expressões aritméticas e lógicas e operações relacionais simples, bem como instruções de atribuição e de controlo (if-else e while). Implementa ainda métodos (estáticos) envolvendo quaisquer dos tipos de dados referidos acima e/ou o tipo de retorno void.

É possível passar parâmetros, que deverão ser literais inteiros, a um programa iJava através da linha de comandos. Supondo que o nome dado ao argumento do método main() é args, os seus valores podem ser recuperados através da construção Integer.parseInt(args[...]), e o número de parâmetros pode ser obtido através da expressão args.length. A construção System.out.println(...) permite imprimir valores inteiros ou lógicos.
Finalmente, são aceites (e ignorados) comentários dos tipos /* ... */ e //... .
