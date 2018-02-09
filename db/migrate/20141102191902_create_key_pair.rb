class CreateKeyPair < ActiveRecord::Migration[5.1]
  def up
    create_table :key_pairs,  :primary_key => :key do |t|
        t.string :value
    end
    change_column :key_pairs, :key, :string
  end

  def down
    drop_table :key_pairs
  end
end
