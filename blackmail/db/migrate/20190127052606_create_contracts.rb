class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string: :ownerUID
      t.string: :receiverUID
      t.binary: :content
      t.binary: :passhash
      t.binary: :crypto_iv
      t.integer: :expiration
      t.string: :task
      t.string: :contractid

      t.timestamps
    end
  end
end
