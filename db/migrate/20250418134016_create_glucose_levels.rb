class CreateGlucoseLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :glucose_levels do |t|
      t.references :member, null: false, foreign_key: true
      t.integer :value, null: false
      t.datetime :tested_at, null: false
      t.string :tz_offset, null: false

      t.timestamps
    end
  end
end
