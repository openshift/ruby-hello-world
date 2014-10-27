class CreateTimestamp < ActiveRecord::Migration
  def up
    create_table :timestamps do |t|
        t.date :date
        t.text :text
    end
  end

  def down
    drop_table :timestamps
  end
end
