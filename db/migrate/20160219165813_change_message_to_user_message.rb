class ChangeMessageToUserMessage < ActiveRecord::Migration
  def change
    rename_column :messages, :message, :user_message
  end
end
