class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      enable_extension 'citext' # Causes queries to be case insensitive
      t.citext :name

      t.timestamps
    end
  end
end
