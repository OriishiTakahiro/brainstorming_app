class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
			t.text :name, default: '名無し班', null: :false
			t.text :passwd

      t.timestamps
    end
  end
end
