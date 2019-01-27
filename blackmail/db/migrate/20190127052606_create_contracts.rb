class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :ownerUID
      t.string :receiverUID
      t.string :content
      t.string :pwhash
      t.integer :expriation
      t.string :task

      t.timestamps
    end
  end
end
