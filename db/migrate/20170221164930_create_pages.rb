# frozen_string_literal: true

# Create pages table
class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :url
      t.jsonb :contents

      t.timestamps
    end
  end
end
