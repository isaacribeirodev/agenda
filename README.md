API DE AGENDA DE CONTATOS EM RUBY ON RAILS

Projeto Final da disciplina Programação Orientada a Serviços no Curso Técnico Subsequente em Informática para Internet.

CONSUMINDO A API

Esta API pode ser consumida com o script Ruby "agenda-de-contatos.rb" contido no diretório "agenda".

TESTES COM SWAGGER UI

Para executar testes locais pela Swagger UI, deve-se iniciar o servidor no ambiente de teste, usando o comando "RAILS_ENV=test rails s". Depois disso, na página de interface da ferramenta disponível em "https://{defaultHost}/api-docs/", deve-se substituir o defaultHost www.example.com pela URL do servidor local, clicar em Authorize no canto superior direito, inserir o token "74cb1f64073d4fb0dabb2beb6efd4771" (sem aspas) no campo Value, clicar em Authorize e, por último, em Close.