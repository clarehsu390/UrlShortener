class CreateTagTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topics do |t|
      t.string :topic, null: false, unique: true
      t.timestamps
    end
  end
end
