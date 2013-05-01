class AddRuntimes < ActiveRecord::Migration
  def change
    create_table :runtimes do |t|
      t.decimal :time
      t.references :event
      t.references :attendee

      t.timestamps
    end
    #add_index :runtimes, :event_id
    #add_index :runtimes, :attendee_id
  end
end
