class CreateSequenceConfigurationSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :sequence_configuration_steps do |t|
      t.references :sequence_configuration, foreign_key: true
      t.string :uri, null: false
      t.text :description
      t.integer :days_from_start, null: false

      t.timestamps
    end
  end
end
