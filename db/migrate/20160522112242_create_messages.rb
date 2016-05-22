class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
			t.integer :room_id, null: :false
      t.text :content
      t.text :contributor, default: '名無しさん'
      t.integer :voted, default: 0, null: :false

      t.timestamps
    end
  end
end
