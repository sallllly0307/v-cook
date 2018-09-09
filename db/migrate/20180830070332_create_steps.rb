class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :recipe_id
      t.string :step

      t.timestamps
    end
  end
end
