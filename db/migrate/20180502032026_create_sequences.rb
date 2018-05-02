class CreateSequences < ActiveRecord::Migration[5.0]
  def change
    create_table :sequences do |t|
      t.references :clinic, foreign_key: true
      t.references :sequence_configuration, foreign_key: true
      t.boolean :permission_to_contact, default: false
      t.datetime :start_date, null: false

      t.timestamps
    end
  end
end
