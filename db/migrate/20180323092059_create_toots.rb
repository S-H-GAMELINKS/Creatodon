class CreateToots < ActiveRecord::Migration[5.2]
  def change
    create_table :toots do |t|
      t.string :toot

      t.timestamps
    end
  end
end
