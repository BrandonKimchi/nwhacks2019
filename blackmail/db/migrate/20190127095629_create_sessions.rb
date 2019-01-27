class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :token
      t.string :uid
      t.integer :date

      t.timestamps
    end
  end
end
