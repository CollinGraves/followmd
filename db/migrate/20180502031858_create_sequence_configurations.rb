class CreateSequenceConfigurations < ActiveRecord::Migration[5.0]
  def change
    create_table :sequence_configurations do |t|
      t.references :clinic, foreign_key: true
      t.string :name, null: false
      t.boolean :global, default: false

      t.timestamps
    end
  end
end
