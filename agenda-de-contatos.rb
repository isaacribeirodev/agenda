require "faraday"   # Importa a Gem Faraday para fazer requisições HTTP.
require "json"      # Importa o módulo JSON para que possamos usar as funções dessa classe.

# Cabeçalho exibido no terminal.
puts "Agenda de Contatos"
puts "="*60

# Formulário de Contato.
puts "nome:"
name = gets.chomp
puts "telefone:"
phone = gets.chomp
puts "email:"
correio = gets.chomp
puts "="*60

# Configura a Conexão com o Faraday, fornecendo o cabeçalho HTTP Authorization.
conexao = Faraday.new(
    url: "https://expert-spoon-jxxgvxj7wxwfp7wj-3000.app.github.dev",
    params: { param: "3" },
    headers: { "Authorization" => "85cb1f64072d4fb0dadd2beb5efd4661", "Content-Type" => "application/json" }
)

# Envia uma requisição HTTP com o verbo POST para submeter os dados colhidos pelo formulário de contato.
resposta = conexao.post("/contatos") do |requisicao|
    requisicao.params["limit"] = 100
    requisicao.body = { nome: name, telefone: phone, email: correio }.to_json
end

# Apresenta no terminal o status da resposta HTTP.
puts "Status da Resposta: #{resposta.status}"
puts "-"*60

case resposta.status
when 201
    puts "Contato adicionado com sucesso."
when 404
    puts "O servidor não conseguiu encontrar o recurso solicitado."
when 422
    puts "Dados inválidos."
when 500..599
    puts "Ocorreu um erro na API. Tente novamente mais tarde."
end
puts "="*60

# Envia uma requisição HTTP com o verbo GET.
agenda = conexao.get("/contatos")

# Função da classe JSON que transforma a string "agenda.body" em um hash com o intuito de
# facilitar o acesso às propriedades do corpo da resposta HTTP.
corpo = JSON.parse(agenda.body)

# Usando uma estrutura de controle de repetição quantificada para acessar as propriedades
# do corpo da resposta HTTP e imprimir os contatos da agenda no terminal.
corpo.each do |elemento|
    elemento.each do |chave, valor|
        puts "#{chave}: #{valor}"
    end
    puts "-"*60
end
