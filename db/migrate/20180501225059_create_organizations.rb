class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :subdomain, null: false
      t.timestamps
    end
    add_index :organizations, :subdomain

    change_table :users do |t|
      t.references :organization
    end
  end
end
