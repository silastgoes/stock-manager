## Data Base

### Prompts Contexto um 1 - Criação do banco

 Descrição da relação das tabelas, sem criaçao de nenhum knowleg, workspace, agent ou stack

``` md
Preciso de ajuda para modelar um banco de dados mysql para um serviço de gestão de estoque que deve conter itens , categorias e lotes.
- Cada categoria deve conter um id(uuid), nome, descrição, um campo para indicar se é perecivel ou não, um campo para indicar se o item perene ou descartavel, e um campo que indique o grau de  periculosidade do item dessa categoria e um campo que indique se é retirado em lotes.
- O Lote deve conter um id(uuid), a categoria do item a quantidade inicial e a quantidade atual do lote em questão, a quatidade em deslocamento.
- O item deve conter um id(int, auto incrementado). descrição, lote(se houver), um outro campo de identificação externo(que pode ser um numero de serie, ou código de barra), o id da sua categoria, se ele não tiver um lote, deve conter um campo pra informar se o item esta no estoque
```

- Ajuste 

``` md
preciso que adicione uma campo de data de criação em todas as tabelas
```

Resultado satirfatório, com algumas modificações, que gerou  arquivo 000001_init_up.sql em sua primeira versão dia 29/08/2024

- Complemento

``` md
muito bom, mas tbm preciso de um schema para apagar essas tabelas se necessário
```

Resultado satirfatório que gerou  arquivo 000001_init_down.sql em sua primeira versão dia 29/08/2024


```` md
