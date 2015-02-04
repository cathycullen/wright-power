class AddAttendingToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :attending, :boolean
  end
end
