class AdicionarUsuarioAContatos < ActiveRecord::Migration[7.2]
  # Chave estrangeira criada com possibilidade de valor nulo para permitir
  # a migração com os registros sem usuario_id existentes na tabela contatos.
  def change
    add_reference :contatos, :usuario, null: true, foreign_key: true
  end
end
