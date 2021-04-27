# bd-ufes-01-21
Repositório com conteúdos relacionados a disciplina de Banco de Dados, cursada durante o primeiro semestre de 2021 (EART).

## Projeto Final
###  Criar o projeto de banco de dados Imuniza (banco de dados para controle de vacinação de cidadãos com 18 anos ou mais) com os seguintes itens:

#### Dicionário de Dados
    Faça o dicionário de dados seguindo o modelo a seguir: (1,0 ponto)
    nome da entidade: entidade 1
    atributo 1:
    tipo:
    tamanho:
    descrição:
    ocorrência:
    indexado:
    chave:
    relacionamento:
    algoritmo:
    caso necessário acrescente informações.

### Faça um DE-R (Diagrama de Entidade e Relacionamento) com a cardinalidade das relações. (1,0 ponto)
### Construir o Script em SQL para cria: (3,0 pontos)
### O SGBD MySQL deverá estar instalado na Plataforma Docker 
### Criação de uma interface simples para entrada de dados. 
    Poderá ser utilizada qualquer tecnologia ou linguagem para o desenvolvimento da interface 
### Observações
    Dica - Vejam o aplicativo do Governo Federal MEU DigiSUS, pois tem um modulo de vacinação por faixa etária.

## Descrição do banco
    Dados do projeto de banco de dados Imuniza:

    Uma cidade necessita realizar o controle de vacinação dos habitantes do município que tenham 18 anos ou mais. As vacinas podem ter uma dose ou mais, dependendo do tipo de vacina, sendo necessário armazenar o tipo da vacina, a data da primeira dose, e se for o caso, a data das próximas doses. O responsável pela solicitação informa que:

        - O município possui cinco distritos, todos com moradores com 18 anos ou mais, sendo que estes devem ser vacinados.
        - Será necessário coletar os seguintes dados:
        - Número do SUS
        - CPF
        - Nome do Cidadão
        - Data de nascimento
        - Nome da mãe
        - Sexo genético
        - Endereço completo
        - Estado Civil
        - Escolaridade
        - Religião
        - Raça/Cor/Etnia
        - Possui plano de saúde?
        - Dados das vacinas
        - Verifique a necessidade de coletar outros dados, além dos solicitados.