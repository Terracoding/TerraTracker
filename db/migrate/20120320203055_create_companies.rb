class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string      :name
      t.string      :registration_number
      t.string      :image_file_name
      t.string      :image_content_type
      t.integer     :image_file_size
      t.datetime    :image_updated_at
      t.references  :plan, :default => 0
      t.timestamps
    end
  end
end
