class CreateAppsCollaborationPrefs < ActiveRecord::Migration
  def change
    create_table :apps_collaboration_prefs do |t|
      t.references :channel, index: true, foreign_key: true
      t.boolean :active, null: false, default: false
      t.integer :ratio, null: false, default: 200

      t.timestamps null: false
    end
  end
end
