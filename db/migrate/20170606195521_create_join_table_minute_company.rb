class CreateJoinTableMinuteCompany < ActiveRecord::Migration[5.0]
  def change
    create_join_table :minutes, :companies do |t|
      # t.index [:minute_id, :company_id]
      # t.index [:company_id, :minute_id]
    end
  end
end
