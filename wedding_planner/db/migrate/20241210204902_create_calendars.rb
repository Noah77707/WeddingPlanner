class CreateCalendars < ActiveRecord::Migration[7.1]
  def change
    create_table :calendars do |t|
      t.string :user_id
      t.string :calendar_id

      t.timestamps
    end
  end
end
