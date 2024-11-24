class ModificarChaveEstrangeiraEmContatos < ActiveRecord::Migration[7.2]
  # Altera parâmetro da coluna usuario_id para impedir que o valor dela seja nulo.
  def change
    change_column_null :contatos, :usuario_id, false
  end
end
