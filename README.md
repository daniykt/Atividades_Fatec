# Atividades Fatec

Atividades de PHP feitas na disciplina de CI/CD. Cada pasta é um pequeno site independente.

## 📁 operações_aritmeticas
Você digita dois números e o site mostra as contas: soma, subtração, multiplicação, divisão, resto e potência. Se o segundo número for zero, ele avisa que não dá para dividir.

## 📁 farmacia_paracetaloka
Calcula quanto o cliente vai pagar na farmácia. Você informa o nome, o valor da compra e a idade, e o desconto é aplicado sozinho:
- de 51 a 69 anos: 5% de desconto
- 70 anos ou mais: 7% de desconto
- cartão fidelidade: mais 5%

### 🗓️ Atividade: Simulação de Parcelamento (01/10/2026)
Feita na pasta `farmacia_paracetaloka`. Depois de calcular o total com desconto, o site mostra o valor dividido de **1x a 6x**.
- O cálculo foi feito de duas formas, uma com `for` e outra com `while` (no arquivo `calculo.php`).
- As duas versões aparecem lado a lado numa tabela, para comparar.
- Também foi adicionado um botão **Limpar**, que apaga o formulário e o resultado.

## 📁 tabuada
Você digita um número e o site mostra a tabuada dele, de 0 a 9, com um visual de gatinhos 🐱.

## 📁 empresa_crud
Sistema para cadastrar os funcionários de uma empresa, ligado a um banco de dados MySQL. Dá para fazer as quatro operações básicas (CRUD):
- **cadastrar** um funcionário novo
- **listar** todos os funcionários cadastrados (`listar.php`)
- **atualizar** os dados de um funcionário (`atualizar.php`)
- **remover** um funcionário (`remover.php`)

A conexão com o banco fica no arquivo `conexao.php` e usa `mysqli`. O banco exportado está no repositório para você importar e testar.

## ▶️ Como rodar
Precisa ter o PHP instalado. Abra o terminal dentro da pasta que quer testar e rode:

```bash
php -S localhost:8000
```

Depois é só abrir `http://localhost:8000` no navegador.

### Para o `empresa_crud`
Além do PHP, precisa do MySQL (o XAMPP já vem com os dois).
1. Importe o arquivo `.sql` exportado no phpMyAdmin (ou no MySQL Workbench).
2. Confira se o usuário, a senha e o nome do banco no `conexao.php` batem com os do seu MySQL.
3. Rode o servidor dentro da pasta `empresa_crud`, como mostrado acima.
