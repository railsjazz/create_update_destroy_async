class CreateProjectViews < ActiveRecord::Migration[7.0]
  def change
    create_table :project_views do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    u = User.create
    p = Project.create(user: u)
  end
end
