class CreatePatientDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_details do |t|
      t.references :sequence, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: :false
      t.string :email, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
