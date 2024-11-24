require "swagger_helper"

RSpec.describe "API de Agenda de Contatos em Ruby on Rails", type: :request do
 # Localiza o usuário de teste previamente criado no banco de dados storage/test.sqlite3.
 # Caso esse usuário não exista, ele será criado com as credenciais abaixo.
 let(:usuario) { Usuario.find_or_create_by(token: "74cb1f64073d4fb0dabb2beb6efd4771") { |u| u.nome = "Usuário de Teste" } }
 # Especifica o cabeçalho Authorization com o token do usuário de teste.
 let(:Authorization) { "Bearer #{usuario.token}" }

 # Bloco que define as operações do caminho /contatos.
 path "/contatos" do
   # Bloco de especificação da operação POST /contatos.
   post "Criar um contato." do
     consumes "application/json"
     # Bloco que determina o formato do objeto JSON que deve ser enviado na requisição.
     parameter name: :contato, in: :body, schema: {
       # Deve ser enviado um objeto JSON...
       type: :object,
       # com as seguintes propriedades:
       properties: {
         nome: { type: :string }, # Propriedade nome do tipo string.
         telefone: { type: :string }, # Propriedade telefone do tipo string.
         email: { type: :string } # Propriedade email do tipo string.
       },
       # Define as propriedades obrigatórias.
       required: [ :nome, :telefone ]
     }

     # Bloco de código define que uma possível resposta dessa operação é 201 (Created),
     # informando que o contato foi criado com sucesso.
     response "201", "Contato criado com sucesso." do
       # Cria um objeto "contato" com os seguintes dados:
       let(:contato) {
         {
           nome: "Ariano Suassuna",
           telefone: "(84) 98888-8888",
           email: "ariano.suassuna@academia.org.br"
         }
       }
       # Executa o teste com o contato criado anteriormente.
       run_test!
     end

     # Bloco de código define que uma possível resposta dessa operação é 422 (Unprocessable Entity),
     # informando que a requisição é inválida.
     response "422", "Requisição inválida." do
       # Cria um objeto "contato" com os seguintes dados:
       let(:contato) {
         {
           telefone: "(84) 98888-8888",
           email: "ariano.suassuna@academia.org.br"
         }
       }
       # Executa o teste com o contato criado anteriormente.
       run_test!
     end

     # Bloco de código define que uma possível resposta dessa operação é 401 (Unauthorized),
     # informando que o token de autenticação está ausente ou inválido.
     response "401", "Não autorizado." do
      # Simula a ausência do token de autenticação.
      let(:Authorization) { nil }
      # Executa o teste.
      run_test!
     end
   end

   # Bloco de especificação da operação GET /contatos.
   get "Listar contatos." do
     # Bloco de código define que uma possível resposta dessa operação é 200 (OK),
     # informando que a lista de contatos foi fornecida com sucesso.
     response "200", "Contatos listados com sucesso." do
       # Cria um objeto contato com os seguintes dados.
       let(:contato) { Contato.create(nome: "Ariano Suassuna", telefone: "(84) 98888-8888", email: "ariano.suassuna@academia.org.br") }
       # Executa o teste com o contato criado anteriormente.
       run_test!
     end

     # Bloco de código define que uma possível resposta dessa operação é 401 (Unauthorized),
     # informando que o token de autenticação está ausente ou inválido.
     response "401", "Não autorizado." do
      # Simula a ausência do token de autenticação.
      let(:Authorization) { nil }
      # Executa o teste.
      run_test!
     end
   end
 end

 # Bloco que define as operações do caminho /contatos/{id}.
 path "/contatos/{id}" do
   # Determina que o parâmetro {id} é um número do tipo inteiro.
   parameter name: :id, in: :path, type: :integer

   # Bloco de especificação da operação GET /contatos/{id}.
   get "Detalhar um contato." do
     # Determina que o corpo da resposta está no formato JSON.
     produces "application/json"

     # Bloco de código define que uma possível resposta dessa operação é 200 (OK),
     # informando que o contato foi encontrado.
     response "200", "Contato encontrado." do
       # Define o formato do corpo da resposta...
       schema type: :object,
         # com as seguintes propriedades:
         properties: {
           id: { type: :integer }, # Um parâmetro id do tipo inteiro.
           nome: { type: :string }, # Um parâmetro nome do tipo string.
           email: { type: :string }, # um parâmetro email do tipo string.
           created_at: { type: :string }, # Um parâmetro created_at do tipo string.
           updated_at: { type: :string }, # Um parâmetro updated_at do tipo string.
           usuario_id: { type: :integer } # Um parâmetro usuario_id do tipo inteiro.
         },
         # Define as propriedades obrigatórias.
         required: [ :id, :nome, :email, :created_at, :updated_at, :usuario_id ]

       # Cria uma variável "id" com o id de um contato existente.
       let(:id) { Contato.create(nome: "Ariano Suassuna", telefone: "(84) 98888-8888", email: "ariano.suassuna@academia.org.br").id }
       # Eexecuta o teste.
       run_test!
     end

     # Bloco de código define que uma possível resposta dessa operação é 404 (Not found),
     # informando que o contato não foi encontrado.
     response "404", "Contato não encontrado." do
       # Cria uma variável "id" com o valor 9999 (o id de um contato que não existe).
       let(:id) { 9999 }
       # Executa o teste.
       run_test!
     end

     # Bloco de código define que uma possível resposta dessa operação é 401 (Unauthorized),
     # informando que o token de autenticação está ausente ou inválido.
     response "401", "Não autorizado." do
      # Simula a ausência do token de autenticação.
      let(:Authorization) { nil }
      # Executa o teste.
      run_test!
     end
   end

   # Bloco de especificação da operação DELETE /contatos/{id}.
   delete "Apagar um contato." do
     # Determina que o formato do corpo da resposta é JSON.
     produces "application/json"

     # Bloco de código define que uma possível resposta dessa operação é 204 (No content),
     # informando que o contato foi apagado com sucesso e o corpo da resposta está vazio.
     response "204", "Contato apagado com sucesso." do
       # Cria uma variável "id" com o id de um contato existente.
       let(:id) { Contato.create(nome: "Ariano Suassuna", telefone: "(84) 98888-8888", email: "ariano.suassuna@academia.org.br").id }
       # Executa o teste.
       run_test!
     end

     # Bloco de código define que uma possível resposta dessa operação é 401 (Unauthorized),
     # informando que o token de autenticação está ausente ou inválido.
     response "401", "Não autorizado." do
      # Simula a ausência do token de autenticação.
      let(:Authorization) { nil }
      # Executa o teste.
      run_test!
     end
   end
 end
end
