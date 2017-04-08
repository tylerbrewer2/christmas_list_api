class CreateUsersGroupsListsAndItems < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps
    end

    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

    create_table :lists do |t|
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end

    create_table :items do |t|
      t.string :name
      t.string :url
      t.decimal :price
      t.belongs_to :list, index: true
      t.timestamps
    end
  end
end
